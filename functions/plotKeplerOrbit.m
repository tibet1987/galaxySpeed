function plotKeplerOrbit( phi, r, t, varargin )
%PLOTKEPLERORBIT Summary of this function goes here
%   Detailed explanation goes here

[x,y] = pol2cart(phi,r);% transforming into kartesian
pauseVal = 0.03;
maxRadiusPlot = max(abs(r))*1.2;


figure('Position',[191         137        1049         841])
plot(0,0,'.','Markersize',40); % center point
axis equal
xlim([-maxRadiusPlot,maxRadiusPlot])
ylim([-maxRadiusPlot,maxRadiusPlot])
hold all
plot(x,y)
bodyPlot = plot(x(1),y(1),'.','Markersize',20); drawnow;
pause(pauseVal);
for n=1:2
    for k=2:numel(phi)
        set(bodyPlot,'XData',x(k),'YData',y(k));
        drawnow;
        pause(pauseVal);
    end
end



end
