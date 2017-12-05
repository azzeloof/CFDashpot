%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% OBSTACLE CLASS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


classdef Obstacle < handle
    %% Properties
    properties
        x;
        y;
        xDim;
        yDim;
    end
    
    
    %% Methods
    methods
        
        % Constructor
        function obj = Obstacle(x, y, xDim, yDim)
            obj.x = x;
            obj.y = y;
            obj.xDim = xDim;
            obj.yDim = yDim;
        end
        

        
    end
    
end