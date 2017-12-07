function [uOut,vOut] = solveVelocityBoundary(obj, uIn, vIn, inletVelocity, blockVelocity)

uOut = uIn;
vOut = vIn;

% Inlet
uOut(2:end-1,1) = -uIn(2:end-1,2);
vOut(2:end-1,1) = inletVelocity;

% Outlet
uOut(2:end-1,end) = uIn(2:end-1,end-1);
vOut(2:end-1,end) = vIn(2:end-1,end-1);

% Left wall (u = 0, v = 0);
uOut(1,:) = 0;
vOut(1,:) = -vOut(2,:);

% Right wall (u = 0, v = 0);
uOut(end,:) = 0;
vOut(end,:) = -vOut(end-1,:);

% Box left wall (u = 0, v = 0)
uOut(obj.boxUBounds(1)-1,obj.boxUBounds(3):obj.boxUBounds(4)) = 0;
vOut(obj.boxVBounds(1),obj.boxVBounds(3):obj.boxVBounds(4)) = -vOut(obj.boxVBounds(1)-1,obj.boxVBounds(3):obj.boxVBounds(4)) + 2*blockVelocity;

% Box right wall (u = 0, v = 0)
uOut(obj.boxUBounds(2)+1,obj.boxUBounds(3):obj.boxUBounds(4)) = 0;
vOut(obj.boxVBounds(2),obj.boxVBounds(3):obj.boxVBounds(4)) = -vOut(obj.boxVBounds(2)+1,obj.boxVBounds(3):obj.boxVBounds(4)) + 2*blockVelocity;

% Box bottom wall (u = 0, v = 0)
uOut(obj.boxUBounds(1):obj.boxUBounds(2),obj.boxUBounds(3)) = -uOut(obj.boxUBounds(1):obj.boxUBounds(2),obj.boxUBounds(3)-1);
vOut(obj.boxVBounds(1):obj.boxVBounds(2),obj.boxVBounds(3)-1) = blockVelocity;

% Box top wall (u = 0, v = 0)
uOut(obj.boxUBounds(1):obj.boxUBounds(2),obj.boxUBounds(4)) = -uOut(obj.boxUBounds(1):obj.boxUBounds(2),obj.boxUBounds(4)+1);
vOut(obj.boxVBounds(1):obj.boxVBounds(2),obj.boxVBounds(4)+1) = blockVelocity;

end