%% Clean up

clear all;
close all;
clc;

%% Load file

filename = 'trial_3';
load([filename,'.mat']);

%% Set scale

% maxVel = 0.4;
% minVel = -0.4;
velMag = sqrt(uOutput.^2+vOutput.^2);
% maxVel = 0.3334;
% minVel = 0;
maxVel = max(max(max(velMag)))
minVel = min(min(min(velMag)));

%% Animate and save

figure(1);

disp('Rendering animation...');
for n = 1:10:size(pressureOutput,3)
    
    surf(pressureOutput(:,:,n)');
    shading interp;
    colormap(jet)
    view(2);
    axis image;
    caxis([minVel maxVel]);
    colorbar;
    title('Pressure');
 
    % gif utilities
    set(gcf,'color','w'); % set figure background to white
    drawnow;
    frame = getframe(1);
    im = frame2im(frame);
    [imind,cm] = rgb2ind(im,256);
    outfile = [filename,'_pressure.gif'];
 
    % On the first loop, create the file. In subsequent loops, append.
    if n==1
        imwrite(imind,cm,outfile,'gif','DelayTime',0,'loopcount',inf);
    else
        imwrite(imind,cm,outfile,'gif','DelayTime',0,'writemode','append');
    end
 
end
disp('Done!');