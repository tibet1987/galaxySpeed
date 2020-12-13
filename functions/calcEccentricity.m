function [ e ] = calcEccentricity( ra, rp )
% calculate eccentricity from apoapse and periapse
e = 1 - 2/(ra/rp + 1);

end

