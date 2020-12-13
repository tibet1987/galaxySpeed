function [ r ] = calcKeplerRadius( phi, a, e )
% Kepler radius is r(phi) = a*(1-e^2)/(1+e*cos(phi))
r = a*(1-e^2)./(1+e*cos(phi));
end

