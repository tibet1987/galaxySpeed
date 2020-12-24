clear variables, close all;
addpath functions

%% movement of Pluto and Charon
close all
G = 6.674e-11; % m^3/(kg s^2)
m1 = 1.3e22; % kg, mass of body 1 (Pluto equivalent)
m2 = 1.5e21;   % kg, mass of body 2 (charon equivalent)
scaleFac = 1e6;
fixPositionOfMass1 = 0;
r2_init = [19600 0, 0]';
r2dot_init = [0, sqrt(G*m1/(4*r2_init(1))),0]';
r1_init = -r2_init*m2/m1;
r1dot_init = [0, sqrt(G*m2/(4*r2_init(1))),0]';


F_G = G*m1*m2/(r2_init(1)-r1_init(1))^2
F_z = m2*r2dot_init(2)^2 / r2_init(1)

Tsim = 300;%365*24*3600; % 1 year
T_sample = 1*3600; % 1 hour

mdlName = 'twoBodySim_cartesian';
load_system(mdlName)
mdl_settings = getActiveConfigSet(mdlName);
set_param(mdl_settings,'Solver','ode23tb','AbsTol','1e-10','RelTol','1e-10')
sim(mdlName)

plotTwoBodySimResults(r1,r2,'size1',30,'size2',18,'plotTrail',1,...
                            'timeScale',T_sample*1000,'trailLength',10)
                        
