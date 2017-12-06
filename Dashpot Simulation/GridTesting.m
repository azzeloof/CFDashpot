%% Grid Testing

%% Clean Up

clear all
close all
clc

%% Initialize grid

width = 10;
height = 10;
dx = 1;
dy = 1;

duration = 0;
dt = 1;

inletVelocity = 0;

grid = Grid(width, dx, height, dy, duration, dt);

%% Initialize box

boxWidth = 4;
boxHeight = 4;
boxYLocation = 5;
grid.createBox(boxWidth, boxHeight, boxYLocation);

%% Set initial conditions

% u velcity
u0 = zeros(length(grid.x), length(grid.y)+1);
u0(grid.boxUBounds(1):grid.boxUBounds(2),...
    grid.boxUBounds(3):grid.boxUBounds(4)) = NaN;

% v velocity
v0 = zeros(length(grid.x)+1, length(grid.y));
v0(grid.boxVBounds(1):grid.boxVBounds(2),...
    grid.boxVBounds(3):grid.boxVBounds(4)) = NaN;
v0(2:end-1,1) = inletVelocity;

% pressure
P0 = zeros(length(grid.x)+1, length(grid.y)+1);
P0(grid.boxPBounds(1):grid.boxPBounds(2),...
    grid.boxPBounds(3):grid.boxPBounds(4)) = NaN;

grid.setInitialConditions(u0, v0, P0);

%% Change nodes

% Change pressure
for i = 2:size(grid.P,1) - 1
    for j = 2:size(grid.P,2) - 1
        if (grid.nodeOnBox(i,j,'P') == false)
            grid.P(i,j) = 1;
        end
    end
end
grid.P;
solvePressureBoundary(grid, grid.P);
    
% Change u
for i = 2:size(grid.u,1)-1
    for j = 2:size(grid.u,2)-1
        if (grid.nodeOnBox(i,j,'u') == false)
            grid.u(i,j) = 1;
        end
    end
end
grid.u;

% Change v
for i = 2:size(grid.v,1)-1
    for j = 2:size(grid.v,2)-1
        if (grid.nodeOnBox(i,j,'v') == false)
            grid.v(i,j) = 1;
        end
    end
end
grid.v

[grid.u,grid.v] = solveVelocityBoundary(grid, grid.u, grid.v, inletVelocity);
grid.u;
grid.v







