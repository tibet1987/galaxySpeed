function plotTwoBodySimResults(r1,r2,varargin)
% plotTwoBodySimResults(r1,r2)
%
% input:
%  r1    - timeseries with position of mass 1
%  r2    - timeseries with position of mass 2
%
% varargin [optional]
%  'size1'      - size of mass 1
%  'size2'      - size of mass 2
%  'timeScale'  - scaling of time during between frames (default: 8640000)
%
% time series of 3d vectors r1, r2

% default values
size1 = 25;
size2 = 15;
timeScale = 24*3600*100;
reps = 0;
useNewFigure = 1;
trailLength = numel(r1.Data(:,1));
exportToGif = 0; gifname = 'export.gif';
for k=1:2:nargin-2
    if strcmpi(varargin{k},'size1')
        size1 = varargin{k+1};
    elseif strcmpi(varargin{k},'size2')
        size2 = varargin{k+1};
    elseif strcmpi(varargin{k},'timeScale')
        timeScale = varargin{k+1};
    elseif strcmpi(varargin{k},'plotTrail')
        plotTrail = varargin{k+1};
    elseif strcmpi(varargin{k},'trailLength')
        trailLength = varargin{k+1};
    elseif strcmpi(varargin{k},'exportToGif')
        exportToGif = varargin{k+1};
    end        

end

figure('color',0.1*[1,1,1],'position',[2    42   958   954])
% plot body trail first such that it's always in the background
if plotTrail
    trail1 = plot(r1.Data(1,1),r1.Data(1,2),'-r','lineWidth',0.5');
    hold all
    trail2 = plot(r2.Data(1,1),r2.Data(1,2),'-w','lineWidth',0.5');
end
% plot initial bodies dots
p1 = plot(r1.Data(1,1),r1.Data(1,2),'.r','MarkerSize',size1);
hold all
p2 = plot(r2.Data(1,1),r2.Data(1,2),'.w','MarkerSize',size2);

drawnow

imageSize = 256;
im = zeros(imageSize,imageSize,1,numel(r1.Time));

set(gca,'color','k')
plotScale = 1.1;
maxVal = max(abs([r1.Data(:,1);r2.Data(:,1);r1.Data(:,2);r2.Data(:,2)])) * plotScale;
axis equal
xlim([-maxVal,maxVal])
ylim([-maxVal,maxVal])
timeDiff = (r1.Time(2)-r1.Time(1)) / timeScale;

if exportToGif
    f = getframe;
    [im,map] = rgb2ind(f.cdata,256,'nodither');
end

for k=2:numel(r1.Time)-1
    pause( timeDiff );
    if plotTrail
        if k<=trailLength+1
            set(trail1,'XData',r1.Data(1:k,1),'YData',r1.Data(1:k,2));
            set(trail2,'XData',r2.Data(1:k,1),'YData',r2.Data(1:k,2));
        else
            set(trail1,'XData',r1.Data(k-trailLength:k,1),'YData',r1.Data(k-trailLength:k,2));
            set(trail2,'XData',r2.Data(k-trailLength:k,1),'YData',r2.Data(k-trailLength:k,2));
        end
    end
    set(p1,'XData',r1.Data(k,1),'YData',r1.Data(k,2));
    set(p2,'XData',r2.Data(k,1),'YData',r2.Data(k,2));

    drawnow
    if exportToGif
        f = getframe;
        im(:,:,1,k) = rgb2ind(f.cdata,map,'nodither');
    end
end

    
if exportToGif && not(isempty(gifname))
    % save to fle
    imwrite(im,map,gifname,'DelayTime',timeDiff,'LoopCount',inf) %g443800
    fprintf('done.\n');
end

end

