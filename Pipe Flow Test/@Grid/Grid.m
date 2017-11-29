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
        Au, Av; % x and y advection terms
        Bu, Bv; % x and y diffusion terms
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
            obj.u = zeros(length(obj.x)+1, length(obj.y), length(obj.t));
            obj.v = zeros(length(obj.x), length(obj.y)+1, length(obj.t));
            obj.P = zeros(length(obj.x)+1, length(obj.y)+1, length(obj.t));
            obj.uF = zeros(length(obj.x)+1, length(obj.y));
            obj.vF = zeros(length(obj.x), length(obj.y)+1);
            obj.Au = zeros(length(obj.x)+1, length(obj.y));
            obj.Av = zeros(length(obj.x), length(obj.y)+1);
            obj.Bu = zeros(length(obj.x)+1, length(obj.y));
            obj.Bv = zeros(length(obj.x), length(obj.y)+1);
            
            % Set grid values to NaN
            obj.u(:,:,:) = NaN;
            obj.v(:,:,:) = NaN;
            obj.P(:,:,:) = NaN;
            obj.uF(:,:) = NaN;
            obj.vF(:,:) = NaN;
            obj.Au(:,:) = NaN;
            obj.Av(:,:) = NaN;
            obj.Bu(:,:) = NaN;
            obj.Bv(:,:) = NaN;
        end
        
        
        % Set initial conditions
        setInitialConditions(obj, u0, v0, P0)
%         function setInitialConditions(obj, u0, v0, P0)
% 
%             obj.u(:,:,1) = u0;
%             obj.v(:,:,1) = v0;
%             obj.P(:,:,1) = P0;
% 
%         end
        
    end
    
end