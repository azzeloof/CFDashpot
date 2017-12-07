%% Pipe Flow Simulation
%  Eric Reeder & Adam Zeloof

%% Clean Up

clear all
close all
clc

%% Initialize grid

width = 0.04;
height = 0.1;
dx = 0.001;
dy = 0.001;

duration = 0.1;
dt = 0.0001;

inletVelocity = 0.01;
mu = .1;
rho = 1000;

% blockSpeed = 0.01; % m/s
% timeStepsPerMove = (blockSpeed * dt / dy)^(-1);

w = 0.1;

grid = Grid(width, dx, height, dy, duration, dt);

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
v0(2:end-1,1) = inletVelocity;

% pressure
P0 = zeros(length(grid.x)+1, length(grid.y)+1);

grid.setInitialConditions(u0, v0, P0);

%% Solve at each time step
    
textprogressbar('Running Simulation: ');
for n = 2:length(grid.t)
    textprogressbar(n/length(grid.t)*100);
    grid.solveIntermediateVelocity(n, mu, rho, inletVelocity);
    grid.solvePressure(n, w);
    grid.solveFinalVelocity(n, inletVelocity);
%     if mod(n, timeStepsPerMove) == 0
%         grid.moveBox(-1);
%     end
end
grid.u(grid.boxUBounds(1):grid.boxUBounds(2),...
    grid.boxUBounds(3):grid.boxUBounds(4),:) = NaN;
grid.v(grid.boxVBounds(1):grid.boxVBounds(2),...
    grid.boxVBounds(3):grid.boxVBounds(4),:) = NaN;
grid.P(grid.boxPBounds(1):grid.boxPBounds(2),...
    grid.boxPBounds(3):grid.boxPBounds(4),:) = NaN;
textprogressbar('Done!');



%% Plot results

[uUnified, vUnified] = grid.unifyVelocity(n);

figure(1);
surf(grid.P(:,:,end)');
shading interp;
view(2);
axis image;
title('Pressure');

figure(2);
surf(grid.u(:,:,end)');
shading interp;
view(2);
axis image;
title('X Velocity Magnitude (u)');

figure(3);
surf(grid.v(:,:,end)');
shading interp;
view(2);
axis image;
title('Y Velocity Magnitude (v)')

figure(4);
streamslice(uUnified',vUnified');
title('Velocity Vectors');
axis image;

figure(5);
surf(sqrt(vUnified'.^2+uUnified'.^2));
shading interp;
colormap(jet)
view(2);
axis image;
title('Velocity Magnitude')
