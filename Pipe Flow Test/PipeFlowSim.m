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

duration = 0.01;
dt = 0.0002;

inletVelocity = 0.03;

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
    pipeFlowGrid.solveIntermediateVelocity(n, mu, rho);
    [pipeFlowGrid.uF, pipeFlowGrid.vF] = solveVelocityBoundary(pipeFlowGrid.uF, pipeFlowGrid.vF, inletVelocity);
    pipeFlowGrid.solvePressure(n);
    pipeFlowGrid.solvePressureBoundary(n);
    pipeFlowGrid.solveFinalVelocity(n);
    [pipeFlowGrid.u, pipeFlowGrid.v] = solveVelocityBoundary(pipeFlowGrid.u, pipeFlowGrid.v, inletVelocity);
end






