%% Obstacle Flow Simulation
%  Eric Reeder & Adam Zeloof

%% Clean Up

clear all
close all
clc

%% Initialize grid

xDim = 0.04;
yDim = 0.1;

obsX = .01;
obsY = .04;
obsXDim = .02;
obsYDim = .02;

dx = 0.002;
dy = 0.002;

duration = 0.001;
dt = 0.001;

inletVelocity = .01;

obs = Obstacle(obsX, obsY, obsXDim, obsYDim, dx, dy);
pipeFlowGrid = Grid(xDim, dx, yDim, dy, duration, dt, obs);

%% Set initial conditions

mu = .1;
rho = 1000;
u0 = zeros(length(pipeFlowGrid.x), length(pipeFlowGrid.y)+1);
v0 = zeros(length(pipeFlowGrid.x)+1, length(pipeFlowGrid.y));
v0(2:end-1,1) = inletVelocity;
P0 = zeros(length(pipeFlowGrid.x)+1, length(pipeFlowGrid.y)+1);
pipeFlowGrid.setInitialConditions(u0, v0, P0);

%% Solve at each time step

textprogressbar('Running Simulation: ');
for n = 2:length(pipeFlowGrid.t)
    textprogressbar(n/length(pipeFlowGrid.t)*100); 
    pipeFlowGrid.solveIntermediateVelocity(n, mu, rho, inletVelocity);
    pipeFlowGrid.solvePressure(n);
    pipeFlowGrid.solveFinalVelocity(n, inletVelocity);
end
textprogressbar('Done!');


%% Plot results

pipeFlowGrid.u(:,:,end);
pipeFlowGrid.v(:,:,end);
[uUnified, vUnified] = pipeFlowGrid.unifyVelocity(n);

figure(1);
surf(pipeFlowGrid.u(:,:,end)');
shading interp;
view(2);
axis image;
title('X Velocity Magnitude (u)');

figure(2);
surf(pipeFlowGrid.v(:,:,end)');
shading interp;
view(2);
axis image;
title('Y Velocity Magnitude (v)')

figure(3);
quiver(uUnified',vUnified');
title('Velocity Vectors');
axis image;

figure(4);
surf(pipeFlowGrid.P(:,:,end)');
shading interp;
view(2);
axis image;
title('Pressure');

figure(5);
surf(sqrt(vUnified'.^2+uUnified'.^2));
shading interp;
colormap(jet)
view(2);
axis image;
title('Velocity Magnitude')
