%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% GRID CLASS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%{

The Grid class stores all the information contained in the staggered grid,
including x and y velocities, pressures, and intermediate calculations. All
units are SI (m, kg, s, etc).

%}

classdef Grid < handle
    %% Properties
    properties
        width, dx, x; % Physical domain width, x grid spacing, x nodes
        height, dy, y; % Physical domain height, y grid spacing, y nodes
        duration, dt, t; % Simulation duration, time step, time nodes
        u, v; % x and y velocity components
        uF, vF; % x and y intermediate velocity grids
        P; % Pressure per density (p/rho)
        boxPBounds; % [left, right, bottom, top] Internal pressure nodes
        boxUBounds; % [left, right, bottom, top] Internal u velocity nodes
        boxVBounds; % [left, right, bottom, top] Internal v velocity nodes
    end
    
    
    %% Methods
    methods
        
        % Constructor
        function obj = Grid(widthIn, dxIn, heightIn, dyIn, durationIn, dtIn)
            % Define x nodes
            obj.width = widthIn;
            obj.dx = dxIn;
            obj.x = 0:obj.dx:obj.width;
            
            % Define y nodes
            obj.height = heightIn;
            obj.dy = dyIn;
            obj.y = 0:obj.dy:obj.height;
            
            % Define t nodes
            obj.duration = durationIn;
            obj.dt = dtIn;
            obj.t = 0:obj.dt:obj.duration;
            
            % Create grids for each variable
            obj.u = zeros(length(obj.x), length(obj.y)+1, length(obj.t));
            obj.v = zeros(length(obj.x)+1, length(obj.y), length(obj.t));
            obj.P = zeros(length(obj.x)+1, length(obj.y)+1, length(obj.t));
            obj.uF = zeros(length(obj.x), length(obj.y)+1);
            obj.vF = zeros(length(obj.x)+1, length(obj.y));
            
            % Set grid values to NaN
            obj.u(:,:,:) = NaN;
            obj.v(:,:,:) = NaN;
            obj.P(:,:,:) = NaN;
            obj.uF(:,:) = NaN;
            obj.vF(:,:) = NaN;
            
            % Initialize box outside computational domain
            obj.boxPBounds = [-1 -1 -1 -1];
            obj.boxUBounds = [-1 -1 -1 -1];
            obj.boxVBounds = [-1 -1 -1 -1];
        end
        
        
        % Set initial conditions for velocity and pressure
        setInitialConditions(obj, u0, v0, P0);
        
        % Find intermediate velocity ignoring pressure
        solveIntermediateVelocity(obj, n, mu, rho, inletVelocity, blockVelocity);
        
        % Find pressure at n+1 time step
        counter = solvePressure(obj, n, w);
        
        % Find final velocity using pressure
        solveFinalVelocity(obj, n, inletVelocity, blockVelocity);
        
        [uUnified, vUnified] = unifyVelocity(obj,n);
        
        A = solveAdvection(obj, i, j, n, direction);
        
        B = solveDiffusion(obj, i, j, n, mu, rho, direction);
        
%         [uOut,vOut] = solveVelocityBoundary(obj, uIn, vIn, inletVelocity)
        
%         POut = solvePressureBoundary(obj, PIn)
        
        createBox(obj,width, height, yLocation)
        
    end
    
end