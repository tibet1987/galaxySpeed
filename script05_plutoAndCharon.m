clear variables, close all;
addpath functions

%% movement of Pluto and Charon
close all
G = 6.674e-11; % m^3/(kg s^2)
m1 = 1.3e22; % kg, mass of body 1 (Pluto equivalent)
m2 = 1.5e21;   % kg, mass of body 2 (charon equivalent)
R_low = 19600e3; % periapsis
scaleFac = 10^(floor(log10(R_low)));
fixPositionOfMass1 = 0;

r2 = [R_low*m1/(m1+m2) 0, 0]';
r1 = -m2/m1*r2;
r2dot = [0, sqrt( abs(norm(r2))*G*m1 / norm(abs(r2) + abs(r1))^2 ),0]';
r1dot = -m2/m1*r2dot; %[0, sqrt( abs(norm(r1))*G*m2 / norm(abs(r2) + abs(r1))^2 ),0]';


F_G = G*m1*m2 / norm(abs(r2) + abs(r1))^2
F_z2 = m2*norm(r2dot)^2 / norm(r2)
F_z1 = m1*norm(r1dot)^2 / norm(r1)

Tsim = 6.5*24*3600; % 100 days
T_sample = 2*3600; % 1 hour

mdlName = 'twoBodySim_cartesian';
load_system(mdlName)
r1_init = r1;   % load initial conditions for simulation
r2_init = r2;
r1dot_init = r1dot;
r2dot_init = r2dot;
mdl_settings = getActiveConfigSet(mdlName);
set_param(mdl_settings,'Solver','ode23tb','AbsTol','1e-10','RelTol','1e-10')
sim(mdlName)
%%
close all
plotTwoBodySimResults(r1,r2,'size1',100,'size2',40,'plotTrail',0,...
                            'timeScale',T_sample*50,'trailLength',20,...
                            'exportToGif',1,'gifName','script05_plutoAndCharon.gif')
                        
