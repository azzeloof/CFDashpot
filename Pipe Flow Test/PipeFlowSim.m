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

obsX1 = .01;
obsX2 = .03;
obsY1 = .04;
obsY2 = .06;

duration = 1.0;
dt = 0.0002;

inletVelocity = .01;

pipeFlowGrid = Grid(xDim, dx, yDim, dy, duration, dt, obsX1, obsX2, obsY1, obsY2);

%% Set initial conditions

mu = .1;
rho = 1000;
u0 = zeros(length(pipeFlowGrid.x), length(pipeFlowGrid.y)+1);
v0 = zeros(length(pipeFlowGrid.x)+1, length(pipeFlowGrid.y));
v0(2:end-1,1) = inletVelocity;
P0 = zeros(length(pipeFlowGrid.x)+1, length(pipeFlowGrid.y)+1);
pipeFlowGrid.setInitialConditions(u0, v0, P0);

%% Solve at each time step
for n = 2:3%:length(pipeFlowGrid.t)      
    if mod(n,25) == 0
        disp([num2str(round((n/length(pipeFlowGrid.t))*100)), '% complete']);
    end
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
surf(vUnified');
shading interp;
view(2);
axis image;
title('v')

figure(3);
quiver(uUnified',vUnified');
axis image;

figure(4);
contourf(pipeFlowGrid.P(:,:,end)');
title('Pressure');
axis image

figure(5);
surf(sqrt(vUnified'.^2+uUnified'.^2));
shading interp;
colormap(jet)
view(2);
axis image;
title('Velocity')
