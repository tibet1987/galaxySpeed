% This small script shall simulate the planetary movements 
% based on Kepler orbits

clear variables, close all;
addpath functions

%% understanding Kepler movement


    %% drawing different Kepler orbits
    close all
    phi = linspace(0,2*pi,100); % linear true anomaly
    a = 1;
    e = 0;
    plot(0,0,'.','MarkerSize',20); hold all;
    [r] = calcKeplerRadius(phi,a,e);
    [x,y] = pol2cart(phi,r);
    plot(x,y)
    axis equal
    hold all

    
    %% movement of bodies on Kepler orbits
    close all
    phi = linspace(0,2*pi,21);
    a = 1;
    e = 0.8;
    r = calcKeplerRadius(phi,a,e);
    t = linspace(0,10,numel(phi));
    plotKeplerOrbit(phi,r,t);

%% first test - simualte earth movement
