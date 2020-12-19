function phi = calcEquichronousAngleSlices(N,a,b,M,G)
% phi = calcEquichronousAngleSlices(N,a,b,M,G)
%
% calculate the equichronous angles of an object flying around the sun
%
% input:
%   N   -   number of time vector steps
%   a   -   semi major axis
%   b   -   semi minor axis
%   M   -   mass of the object
%   G   -   gravitational constant 
%            (in case you want to play with universal constants :)
%
% (C) Timo Benzel
    
P = sqrt( 4*pi^2*a^3 / (G*M) );
t = linspace(0,P,N);
phi = 2*pi*a*b/(r^2*P)*t;
