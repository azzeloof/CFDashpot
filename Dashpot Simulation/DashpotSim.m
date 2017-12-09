%% Pipe Flow Simulation
%  Eric Reeder & Adam Zeloof

%% Clean Up & Set Up

clear all
close all
clc

saveFilename = 'trial_2.mat';

% animate = false;
% saveAnimation = false;

%% Initialize grid

width = 0.04;
height = 0.1;
dx = 0.0002;
dy = 0.0002;

duration = 0.001;
dt = 0.00002;

nu = 0.00002;

blockVelocity = -0.06; % m/s
timeStepsPerMove = round((abs(blockVelocity) * dt / dy)^(-1));

w = 1;

grid = Grid(width, dx, height, dy, duration, dt);

%% Initialize box

boxWidth = 0.03;
boxHeight = 0.006;
boxYLocation = 0.05;
grid.createBox(boxWidth, boxHeight, boxYLocation);

%% Set initial conditions

% u velocity
u0 = zeros(length(grid.x), length(grid.y)+1);

% v velocity
v0 = zeros(length(grid.x)+1, length(grid.y));

% pressure
P0 = zeros(length(grid.x)+1, length(grid.y)+1);

grid.setInitialConditions(u0, v0, P0);

%% Solve at each time step

tic
textprogressbar('Running Simulation: ');
for n = 2:length(grid.t)
    textprogressbar(n/length(grid.t)*100);
    grid.solveIntermediateVelocity(n, nu, blockVelocity);
    grid.solvePressure(n, w);
    grid.solveFinalVelocity(n, blockVelocity);
    grid.findBoxPressure(n);
    if mod(n, timeStepsPerMove) == 0
        grid.moveBox(-1);
        grid.P(:,:,n) = solvePressureBoundary(grid, grid.P(:,:,n));
        [grid.u(:,:,n), grid.v(:,:,n)] = solveVelocityBoundary(grid, grid.u(:,:,n), grid.v(:,:,n), blockVelocity);
    end
end
textprogressbar('Done!');
toc

%% Unify Velocity

uUnified = zeros(size(grid.P,1)-2, size(grid.P,2)-2, size(grid.P,3));
vUnified = zeros(size(grid.P,1)-2, size(grid.P,2)-2, size(grid.P,3));

for n = 1:length(grid.t)
    [uUnified(:,:,n), vUnified(:,:,n)] = grid.unifyVelocity(n);
end

velMag = sqrt(uUnified.^2+vUnified.^2);
maxVel = max(max(max(velMag)));
minVel = min(min(min(velMag)));

%% Save results

timeStepSkip = 5;
pressureOutput = grid.P(:,:,1:timeStepSkip:end);
uOutput = uUnified(:,:,1:timeStepSkip:end);
vOutput = vUnified(:,:,1:timeStepSkip:end);
save(saveFilename,'pressureOutput','uOutput','vOutput');

%% Make an Animation

% if animate
%     textprogressbar('Generating Animation: ');
%     frameSkip = 5;
%     animationLength = round(length(grid.t)/frameSkip);
%     frames = struct('cdata', cell(1,animationLength), 'colormap', cell(1,animationLength));
%     f = figure('visible', 'off','Position',[0 0 273 685]);
%     hold on;
%     for n = 1:animationLength
%         ind = n*frameSkip;
%         textprogressbar(n/animationLength*100);
%         surf(sqrt(vUnified(:,:,ind)'.^2+uUnified(:,:,ind)'.^2));
%         shading interp;
%         colormap(jet)
%         view(2);
%         axis image;
%         colorbar;
%         caxis([minVel maxVel]);
%         title('Velocity Magnitude')
%         drawnow;
%         pause(.01);
%         frames(n) = getframe(gcf);
%         clf;
%     end
%     hold off;
%     textprogressbar('Done!');
% end

%% Plot results

clf;
close all;
timeIndex = n;

figure(1);
surf(grid.P(:,:,timeIndex)');
shading interp;
view(2);
axis image;
title('Pressure');

figure(2);
surf(grid.u(:,:,timeIndex)');
shading interp;
view(2);
axis image;
title('X Velocity Magnitude (u)');

figure(3);
surf(grid.v(:,:,timeIndex)');
shading interp;
view(2);
axis image;
title('Y Velocity Magnitude (v)')

figure(4);
streamslice(uUnified(:,:,timeIndex)',vUnified(:,:,timeIndex)');
title('Velocity Vectors');
axis image;

figure(5);
surf(velMag(:,:,timeIndex)');
shading interp;
colormap(jet)
view(2);
axis image;
colorbar;
title('Velocity Magnitude')

% if animate
%     figure(6);
%     movie(frames,2,20);
% end

%% Save Video
% if animate && saveAnimation
%     vid = VideoWriter('CFDashpot.avi');
%     open(vid);
%     for k = 1:length(frames)
%         frame = frames(k);
%         writeVideo(vid,frame);
%     end
%     close(vid);
% end
