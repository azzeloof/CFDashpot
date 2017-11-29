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

pipeFlowGrid = Grid(xDim, dx, yDim, dy, duration, dt);

%% Set initial conditions

x = 0:dx:xDim;
y = 0:dy:yDim;

inletStart = 0.01;
inletStartIndex = find(x == inletStart);
inletEnd = 0.03;
inletEndIndex = find(x == inletEnd);

u0 = zeros(length(x)+1, length(y));
v0 = zeros(length(x), length(y)+1);
v0(inletStartIndex:inletEndIndex,1) = 0.1;
P0 = zeros(length(x)+1, length(y)+1);

pipeFlowGrid.u(:,:,1)

pipeFlowGrid.setInitialConditions(u0, v0, P0);

pipeFlowGrid.u(:,:,1)