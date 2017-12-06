%% Pipe Flow Simulation
%  Eric Reeder & Adam Zeloof

%% Clean Up

clear all
close all
clc

%% Initialize grid

width = 0.04;
height = 0.1;
dx = 0.002;
dy = 0.002;

duration = 0.5;
dt = 0.0002;

inletVelocity = .01;
mu = .1;
rho = 1000;

w = 1;

grid = Grid(width, dx, height, dy, duration, dt);

%% Initialize box

boxWidth = 0.02;
boxHeight = 0.008;
boxYLocation = 0.05;
grid.createBox(boxWidth, boxHeight, boxYLocation);

%% Set initial conditions

% u velcity
u0 = zeros(length(grid.x), length(grid.y)+1);
% u0(grid.boxUBounds(1):grid.boxUBounds(2),...
%     grid.boxUBounds(3):grid.boxUBounds(4)) = NaN;

% v velocity
v0 = zeros(length(grid.x)+1, length(grid.y));
% v0(grid.boxVBounds(1):grid.boxVBounds(2),...
%     grid.boxVBounds(3):grid.boxVBounds(4)) = NaN;
v0(2:end-1,1) = inletVelocity;

% pressure
P0 = zeros(length(grid.x)+1, length(grid.y)+1);
% P0(grid.boxPBounds(1):grid.boxPBounds(2),...
%     grid.boxPBounds(3):grid.boxPBounds(4)) = NaN;

grid.setInitialConditions(u0, v0, P0);

%% Solve at each time step

textprogressbar('Running Simulation: ');
for n = 2:length(grid.t)
    textprogressbar(n/length(grid.t)*100);
    grid.solveIntermediateVelocity(n, mu, rho, inletVelocity);
    grid.solvePressure(n, w);
    grid.solveFinalVelocity(n, inletVelocity);
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
