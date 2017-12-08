%% Pipe Flow Simulation
%  Eric Reeder & Adam Zeloof

%% Clean Up & Set Up

clear all
close all
clc

animate = true;

%% Initialize grid

width = 0.04;
height = 0.1;
dx = 0.001;
dy = 0.001;

duration = 0.1;
dt = 0.0001;

mu = .1;
rho = 1000;

blockVelocity = -0.1; % m/s
timeStepsPerMove = (abs(blockVelocity) * dt / dy)^(-1);

w = 0.1;

grid = Grid(width, dx, height, dy, duration, dt);
length(grid.t)

%% Initialize box

boxWidth = 0.02;
boxHeight = 0.008;
boxYLocation = 0.05;
grid.createBox(boxWidth, boxHeight, boxYLocation);

%% Set initial conditions

% u velcity
u0 = zeros(length(grid.x), length(grid.y)+1);

% v velocity
v0 = zeros(length(grid.x)+1, length(grid.y));
%v0(2:end-1,1) = inletVelocity;

% pressure
P0 = zeros(length(grid.x)+1, length(grid.y)+1);

grid.setInitialConditions(u0, v0, P0);

%% Solve at each time step

textprogressbar('Running Simulation: ');
for n = 2:length(grid.t)
    textprogressbar(n/length(grid.t)*100);
    grid.solveIntermediateVelocity(n, mu, rho, blockVelocity);
    if n == 2
        acceptableNansUint = sum(sum(isnan(grid.uF)));
        acceptableNansVint = sum(sum(isnan(grid.vF)));
    end
     if sum(sum(isnan(grid.uF(:,:)))) > acceptableNansUint
        disp('NaN found in uF');
        disp(n);
        break;
    end
    if sum(sum(isnan(grid.vF(:,:)))) > acceptableNansVint
        disp('NaN found in vF');
        disp(n);
        break;
    end
    grid.solvePressure(n, w);
    grid.solveFinalVelocity(n, blockVelocity);
    if n == 2
        acceptableNansU = sum(sum(isnan(grid.u(:,:,n))));
        acceptableNansV = sum(sum(isnan(grid.v(:,:,n))));
    end
    if mod(n, timeStepsPerMove) == 0
        grid.moveBox(-1);
        grid.P(:,:,n) = solvePressureBoundary(grid, grid.P(:,:,n));
        [grid.u(:,:,n), grid.v(:,:,n)] = solveVelocityBoundary(grid, grid.u(:,:,n), grid.v(:,:,n), blockVelocity);
    end
    if sum(sum(isnan(grid.P(:,:,n)))) > 0
        disp('NaN found in P');
        disp(n);
        break;
    end
    if sum(sum(isnan(grid.u(:,:,n)))) > acceptableNansU
        disp('NaN found in u');
        disp(n);
        break;
    end
    if sum(sum(isnan(grid.v(:,:,n)))) > acceptableNansV
        disp('NaN found in v');
        disp(n);
        break;
    end
end
% grid.u(grid.boxUBounds(1):grid.boxUBounds(2),...
%     grid.boxUBounds(3):grid.boxUBounds(4),:) = NaN;
% grid.v(grid.boxVBounds(1):grid.boxVBounds(2),...
%     grid.boxVBounds(3):grid.boxVBounds(4),:) = NaN;
% grid.P(grid.boxPBounds(1):grid.boxPBounds(2),...
%     grid.boxPBounds(3):grid.boxPBounds(4),:) = NaN;
textprogressbar('Done!');

%% Unify Velocity

uUnified = zeros(size(grid.P,1)-2, size(grid.P,2)-2, size(grid.P,3));
vUnified = zeros(size(grid.P,1)-2, size(grid.P,2)-2, size(grid.P,3));

for n = 1:length(grid.t)
    [uUnified(:,:,n), vUnified(:,:,n)] = grid.unifyVelocity(n);
end

velMag = sqrt(uUnified.^2+vUnified.^2);
maxVel = max(max(max(velMag)));
minVel = min(min(min(velMag)));

%% Make an Animation

if animate
    textprogressbar('Generating Animation: ');
    frameSkip = 5;
    animationLength = round(length(grid.t)/frameSkip);
    frames = struct('cdata', cell(1,animationLength), 'colormap', cell(1,animationLength));
    f = figure('visible', 'off');
    hold on;
    for n = 1:animationLength
        ind = n*frameSkip;
        textprogressbar(n/animationLength*100);
        surf(sqrt(vUnified(:,:,ind)'.^2+uUnified(:,:,ind)'.^2));
        shading interp;
        colormap(jet)
        view(2);
        axis image;
        colorbar;
        caxis([minVel maxVel]);
        title('Velocity Magnitude')
        pause(.0001)
        drawnow;
        frames(n) = getframe(gca);
        clf;
    end
    hold off;
    textprogressbar('Done!');
end

%% Plot results

clf;
close all;
timeIndex = n;

%[uUnified, vUnified] = grid.unifyVelocity(timeIndex);

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
streamslice(uUnified(:,:,n)',vUnified(:,:,n)');
title('Velocity Vectors');
axis image;

figure(5);
surf(velMag(:,:,n)');
shading interp;
colormap(jet)
view(2);
axis image;
colorbar;
title('Velocity Magnitude')

if animate
    %figure(6);
    movie(frames,2,20);
end
