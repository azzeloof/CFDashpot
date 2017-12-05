%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% OBSTACLE CLASS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


classdef Obstacle < handle
    %% Properties
    properties
        x; %Left edge
        y; %Bottom edge
        xDim;
        yDim;
        dx;
        dy;
        xVec;
        yVec;
    end
    
    
    %% Methods
    methods
        
        % Constructor
        function obj = Obstacle(x, y, xDim, yDim, dx, dy)
            obj.x = x;
            obj.y = y;
            obj.xDim = xDim;
            obj.yDim = yDim;
            obj.dx = dx;
            obj.dy = dy;
            obj.xVec = ((x/dx):(x+xDim)/dx);
            obj.yVec = ((y/dy):(y+yDim)/dy);
        end
        

        
    end
    
end