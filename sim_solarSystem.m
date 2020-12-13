% This small script shall simulate the planetary movements 
% based on Kepler orbits

clear all, close all;
addpath functions

%% understanding Kepler movement
phi = linspace(0,2*pi,100);
a = 0;
e = 0;
r = calcKeplerRadius(phi)



%% first test - simualte earth movement
