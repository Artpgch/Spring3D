dur = 10;
fps = 60;
freq = 1.2;
pstart = 0.4; 
pend = 0.8;
r = 5; 
a = 1; 
b = 1; 
n = 8;
k = 0.01;
VD = VideoWriter('Spring','MPEG-4');
VD.FrameRate = fps;
VD.Quality = 100;
open(VD);
[X, Y, Z] = SpringModel(r, a, b, pstart, n);
S = surf(X, Y, Z,'FaceAlpha',0.6);
daspect([1 1 1])
colormap('parula')
shading interp
title('Spring')
axis('square','equal','off')
ax = gca;
gx = gcf;
ax.ZLim = [0 pend*(53+1/3)];
ax.NextPlot = 'replaceChildren';
get(gx)
gx.Color = [0 0 0];
gx.Position = [400 80 500 650];

for dt = 1:dur*fps
    %dt/(dur*fps)
    P = ((pend-pstart).*exp(-k.*dt).*sin(2.*pi.*dt.*freq./fps) + pstart + pend)./2;
    [X, Y, Z] = SpringModel(r, a, b, P, n);
    S.ZData = Z;
    drawnow
    F = getframe(gcf);
    writeVideo(VD,F);
end

close(VD);

function [X, Y, Z] = SpringModel(r, a, b, p, n)

    th = linspace(0, 2*pi, 36); 
    ph = linspace(0, n*2*pi, 36*n);
    [Ph,Th] = meshgrid(ph, th); 
    X = (r + a.*cos(Th)).*cos(Ph);
    Y = (r + b.*cos(Th)).*sin(Ph);
    Z = a.*sin(Th) + p*Ph;

end
