clear variables, close all;
addpath functions

%% movement of Pluto and Charon
close all
m1 = 1.3e22; % kg, mass of body 1 (Pluto equivalent)
m2 = 1.5e21;   % kg, mass of body 2 (charon equivalent)
scaleFac = 1e6;
fixPositionOfMass1 = 0;
r2_init = [19600 0, 0]';
r2dot_init = [0, 0.21e3,0]';
r1_init = -r2_init*m2/m1;
r1dot_init = -r2dot_init*m2/m1;
G = 6.674e-11; % m^3/(kg s^2)

Tsim = 300;%365*24*3600; % 1 year
T_sample = 1*3600; % 1 hour

load_system('twoBodySim')
mdl_settings = getActiveConfigSet('twoBodySim');
set_param(mdl_settings,'Solver','ode23tb','AbsTol','1e-10','RelTol','1e-10')
sim('twoBodySim')

plotTwoBodySimResults(r1,r2,'size1',30,'size2',18,'plotTrail',1,...
                            'timeScale',T_sample*1000,'trailLength',10)
                        
