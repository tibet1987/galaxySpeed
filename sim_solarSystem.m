% This small script shall simulate the planetary movements 
% based on Kepler orbits

clear variables, close all;
addpath functions

%% understanding Kepler movement


%% drawing different Kepler orbits
close all
phi = linspace(0,2*pi,100); % linear true anomaly
a = 1;
e = 0.80;
plot(0,0,'.','MarkerSize',20); hold all;
[r] = calcKeplerRadius(phi,a,e);
[x,y] = pol2cart(phi,r);
plot(x,y,'.-')
axis equal
hold all


%% first test - simualte earth movement
close all
m1 = 2e30; %kg mass of the sun
m2 = 1;%6e24; % mass of the earth
fixPositionOfMass1 = 1;
r2_init = [149e9 0, 0]';
r2dot_init = [0, 29.78e3,0]';
r1_init = -r2_init*1e-6;
r1dot_init = -r2dot_init*1e-6;
G = 6.674e-11; % m^3/(kg s^2)

F_G = G*m1*m2/r1_init(1)^2;
F_z = m2*r1dot_init(2)^2 / r1_init(1);

Tsim = 2*365*24*3600; % 1 year
T_sample = 24*3600; % 1 day

sim('twoBodySim')

plotTwoBodySimResults(r1,r2,'size1',30,'size2',18,'plotTrail',1,...
                            'timeScale',T_sample*50)

%% movement of Pluto and Charon
close all
m1 = 1.3e22; % kg, mass of body 1 (Pluto equivalent)
m2 = 1.5e21;   % kg, mass of body 2
fixPositionOfMass1 = 0;
r2_init = [19600 0, 0]';
r2dot_init = [0, 0.21e3,0]';
r1_init = -r2_init*m2/m1;
r1dot_init = -r2dot_init*m2/m1;
G = 6.674e-11; % m^3/(kg s^2)

Tsim = 300;%365*24*3600; % 1 year
T_sample = 1*3600; % 1 hour

sim('twoBodySim')

plotTwoBodySimResults(r1,r2,'size1',30,'size2',18,'plotTrail',1,...
                            'timeScale',T_sample*1000)
                        
%% movement of two bodies attacked by gravity
close all
m1 = 1e22; % kg, mass of body 1 (Pluto equivalent)
m2 = m1;   % kg, mass of body 2
fixPositionOfMass1 = 0;
r2_init = [5e12 0, 0]';
r2dot_init = [0, 0.01e3,0]';
r1_init = -r2_init;
r1dot_init = -r2dot_init;
G = 6.674e-11; % m^3/(kg s^2)

Tsim = 7*24*3600; % 1 year
T_sample = 1*3600; % 1 hour

F_G = G*m1*m2/(r2_init(1)-r1_init(1))^2
F_z = m2*r2dot_init(2)^2 / r2_init(1)

% sim('twoBodySim')

% plotTwoBodySimResults(r1,r2,'size1',30,'size2',18,'plotTrail',1,...
%                             'timeScale',T_sample*10)
