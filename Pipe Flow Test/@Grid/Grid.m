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
        xDim, dx, x; % Physical domain width, x grid spacing, x nodes
        yDim, dy, y; % Physical domain height, y grid spacing, y nodes
        duration, dt, t; % Simulation duration, time step, time nodes
        u, v; % x and y velocity components
        uF, vF; % x and y intermediate velocity grids
        P; % Pressure per density (p/rho)
    end
    
    
    %% Methods
    methods
        
        % Constructor
        function obj = Grid(xDimIn, dxIn, yDimIn, dyIn, durationIn, dtIn)
            % Define x nodes
            obj.xDim = xDimIn;
            obj.dx = dxIn;
            obj.x = 0:obj.dx:obj.xDim;
            
            % Define y nodes
            obj.yDim = yDimIn;
            obj.dy = dyIn;
            obj.y = 0:obj.dy:obj.yDim;
            
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
        end
        
        
        % Set initial conditions for velocity and pressure
        setInitialConditions(obj, u0, v0, P0);
        
        % Find intermediate velocity ignoring pressure
        solveIntermediateVelocity(obj, n, mu, rho, inletVelocity);
        
        % Find pressure at n+1 time step
        solvePressure(obj, n);
        
        % Find final velocity using pressure
        solveFinalVelocity(obj, n, inletVelocity);
        
        [uUnified, vUnified] = unifyVelocity(obj,n);
        
        A = solveAdvection(obj, i, j, n, direction);
        
        B = solveDiffusion(obj, i, j, n, mu, rho, direction);
        
    end
    
end