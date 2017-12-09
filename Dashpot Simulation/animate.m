
%% Load file

filename = 'trial_1';
load([filename,'.mat']);


%% Animate and save

figure(1);
velMag = sqrt(uOutput.^2+vOutput.^2);
maxVel = max(max(max(velMag)));
minVel = min(min(min(velMag)));

disp('Rendering animation...');
for n = 1:10:size(velMag,3)
    
    surf(velMag(:,:,n)');
    shading interp;
    colormap(jet)
    view(2);
    axis image;
    caxis([minVel maxVel]);
    colorbar;
    title('Velocity Magnitude');
 
    % gif utilities
    set(gcf,'color','w'); % set figure background to white
    drawnow;
    frame = getframe(1);
    im = frame2im(frame);
    [imind,cm] = rgb2ind(im,256);
    outfile = [filename,'.gif'];
 
    % On the first loop, create the file. In subsequent loops, append.
    if n==1
        imwrite(imind,cm,outfile,'gif','DelayTime',0,'loopcount',inf);
    else
        imwrite(imind,cm,outfile,'gif','DelayTime',0,'writemode','append');
    end
 
end
disp('Done!');