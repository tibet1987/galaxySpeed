clear variables, close all;
addpath functions

%% movement of two bodies attacked by gravity
G = 6.674e-11; % m^3/(kg s^2)
scaleFac = 1;%1e6;
m1 = 1e22; % kg, mass of body 1 (Pluto sized object)
m2 = m1;   % kg, mass of body 2
fixPositionOfMass1 = 0;
r2_init = [1e8 0, 0]';
r2dot_init = [0, sqrt(G*m1/(4*r2_init(1)))*0.5,0]'; % 0.55e3
r1_init = -r2_init;
r1dot_init = -r2dot_init;

Tsim = 1*356*24*3600; % 1 year
T_sample = 24*3600; % 1 day

F_G = G*m1*m2/(r2_init(1)-r1_init(1))^2
F_z = m2*r2dot_init(2)^2 / r2_init(1)

mdlName = 'twoBodySim_cartesian';
load_system(mdlName)
mdl_settings = getActiveConfigSet(mdlName);
set_param(mdl_settings,'Solver','ode23tb','AbsTol','1e-10','RelTol','1e-10')
sim(mdlName)

%% plotting
close all
plotTwoBodySimResults(r1,r2,'size1',30,'size2',30,'plotTrail',1,...
                            'timeScale',T_sample*100,'trailLength',100)