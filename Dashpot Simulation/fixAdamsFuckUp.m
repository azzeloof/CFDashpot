%% Pipe Flow Simulation
%  Eric Reeder & Adam Zeloof

%% Clean Up & Set Up

clear all
close all
clc

saveFilename = 'trial_4.mat';
load(saveFilename);

%% Initialize grid

width = 0.04;
height = 0.1;
dx = 0.0002;
dy = 0.0002;

duration = 0.1;
dt = 0.00002;

nu = 0.00002;

blockVelocity = -0.02; % m/s
timeStepsPerMove = round((abs(blockVelocity) * dt / dy)^(-1));

w = 1;

grid = Grid(width, dx, height, dy, duration, dt);

%% Initialize box

boxWidth = 0.020;
boxHeight = 0.006;
boxYLocation = 0.05;
grid.createBox(boxWidth, boxHeight, boxYLocation);

%% Solve at each time step

timeStepSkip = 5;
grid.P(:,:,1:timeStepSkip:end) = pressureOutput;

tic
textprogressbar('Fixing Fuckup: ');
for n = 2:length(grid.t)
    textprogressbar(n/length(grid.t)*100);
    if mod(n, timeStepsPerMove) == 0
        grid.moveBox(-1);
    end
    grid.findBoxPressure(n);
end
textprogressbar('Done!');
toc


%% Save results


boxPressureOutput = grid.boxPressure;
save(saveFilename,'pressureOutput','uOutput','vOutput','boxPressureOutput');

beep
