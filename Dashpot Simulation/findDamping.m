%% Clean up

clear all;
close all;
clc;

%% Load file

filename = 'trial_12';
load([filename,'.mat']);

%% System params

pistonWidth = 0.024;
pistonVelocity = 0.04;

%% Remove NaNs

valCount = 0;
for i = 1:size(boxPressureOutput,1)
    if ~isnan(boxPressureOutput(i,1))
        valCount = valCount + 1;
    end
end

indexCounter = 1;
boxPressureOutputNew = zeros(valCount,2);
for i = 1:size(boxPressureOutput,1)
    if ~isnan(boxPressureOutput(i,1))
        boxPressureOutputNew(indexCounter,1) = boxPressureOutput(i,1);
        boxPressureOutputNew(indexCounter,2) = boxPressureOutput(i,2);
        indexCounter = indexCounter + 1;
    end
end

%% Plot pressure

figure(1);
plot(boxPressureOutputNew(:,1));
hold on;
plot(boxPressureOutputNew(:,2));

%% Calculate average pressure

% [x,y] = ginput(1);
x = 1;
meanBottomPressure = mean(boxPressureOutputNew(round(x):end,1));
meanTopPressure = mean(boxPressureOutputNew(round(x):end,2));
netPressure = meanBottomPressure - meanTopPressure;

%% Calculate Damping

force = netPressure * pistonWidth
dampingCoeff = force / pistonVelocity % N-m-s/kg



