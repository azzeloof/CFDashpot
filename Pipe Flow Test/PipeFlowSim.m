%% Pipe Flow Simulation
%  Eric Reeder & Adam Zeloof

%% Clean Up

clear all
close all
clc

%% Initialize grid

xDim = 0.04;
yDim = 0.1;
dx = 0.002;
dy = 0.002;

duration = 0.1;
dt = 0.0002;

inletVelocity = 0.001;

pipeFlowGrid = Grid(xDim, dx, yDim, dy, duration, dt);

%% Set initial conditions

mu = 8.9e-5;
rho = 998;
u0 = zeros(length(pipeFlowGrid.x), length(pipeFlowGrid.y)+1);
v0 = zeros(length(pipeFlowGrid.x)+1, length(pipeFlowGrid.y));
v0(2:end-1,1) = inletVelocity;
P0 = zeros(length(pipeFlowGrid.x)+1, length(pipeFlowGrid.y)+1);
pipeFlowGrid.setInitialConditions(u0, v0, P0);

%% Solve at each time step

for n = 2:length(pipeFlowGrid.t)
    pipeFlowGrid.solveIntermediateVelocity(n, mu, rho, inletVelocity);
    pipeFlowGrid.solvePressure(n);
    pipeFlowGrid.solveFinalVelocity(n, inletVelocity);
end

%% Plot results

pipeFlowGrid.u(:,:,end);
pipeFlowGrid.v(:,:,end);
[uUnified, vUnified] = pipeFlowGrid.unifyVelocity(n);

figure(1);
contourf(uUnified');
shading interp;
view(2);
axis image;
title('u');

figure(2);
contourf(vUnified');
shading interp;
view(2);
axis image;
title('v')

figure(3);
streamslice(uUnified',vUnified');
axis image;

figure(4);
contourf(pipeFlowGrid.P(:,:,end)');
title('Pressure');




