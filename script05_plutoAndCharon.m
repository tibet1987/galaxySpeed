clear variables, close all;
addpath functions

%% movement of Pluto and Charon
close all
G = 6.674e-11; % m^3/(kg s^2)
m1 = 1.3e22; % kg, mass of body 1 (Pluto equivalent)
m2 = 1.5e21;   % kg, mass of body 2 (charon equivalent)
scaleFac = 1e6;
fixPositionOfMass1 = 0;
R_low = 19600e3; % periapsis
r2 = [R_low*m1/(m1+m2) 0, 0]';
r1 = -m2/m1*r2;
r2dot = [0, sqrt( norm(r2)*G*m1 / norm(r2 + r1)^2 ),0]';
r1dot = -m2/m1*r2dot;


F_G = G*m1*m2 / norm(r2 - r1)^2
F_z2 = m2*norm(r2dot)^2 / norm(r2)
F_z1 = m1*norm(r1dot)^2 / norm(r2)

Tsim = 300;%365*24*3600; % 1 year
T_sample = 1*3600; % 1 hour

mdlName = 'twoBodySim_cartesian';
load_system(mdlName)
mdl_settings = getActiveConfigSet(mdlName);
set_param(mdl_settings,'Solver','ode23tb','AbsTol','1e-10','RelTol','1e-10')
sim(mdlName)
%%
plotTwoBodySimResults(r1,r2,'size1',30,'size2',18,'plotTrail',1,...
                            'timeScale',T_sample*1000,'trailLength',10)
                        
