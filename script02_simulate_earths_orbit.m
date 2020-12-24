clear variables, close all;
addpath functions

%% first simulation - earths movement around the sun
close all
m1 = 2e30; %kg mass of the sun
m2 = 1;%6e24; % mass of the earth (neglected here)
scaleFac = 1e6; % only needed for numeric efficiency
fixPositionOfMass1 = 1;
r2_init = [149e9 0, 0]';
r2dot_init = [0, 29.78e3,0]';
r1_init = -r2_init*1e-6;
r1dot_init = -r2dot_init*1e-6;
G = 6.674e-11; % m^3/(kg s^2)

F_G = G*m1*m2/r1_init(1)^2;
F_z = m2*r1dot_init(2)^2 / r1_init(1);

Tsim = 2*365*24*3600; % 1 year
T_sample = 24*3600; % 2 days

mdlName = 'twoBodySim_cartesian';
load_system(mdlName)
mdl_settings = getActiveConfigSet(mdlName);
set_param(mdl_settings,'Solver','ode45','AbsTol','1e-10','RelTol','1e-10')
sim(mdlName)

plotTwoBodySimResults(r1,r2,'size1',30,'size2',18,'plotTrail',1,...
                            'timeScale',T_sample*100,'traillength',10)
