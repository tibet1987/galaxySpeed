clear variables, close all;
addpath functions

%% drawing different Kepler orbits
close all
phi = linspace(0,2*pi,100); % linear true anomaly
a = 1;
e = 0.80;
figure('color','k')
plot(0,0,'.r','MarkerSize',30); hold all; set(gca,'color','k');
[r] = calcKeplerRadius(phi,a,e);
[x,y] = pol2cart(phi,r);
plot(x,y,'.-')
axis equal
hold all