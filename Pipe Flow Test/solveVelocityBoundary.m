function [uOut,vOut] = solveVelocityBoundary(uIn, vIn, inletVelocity)

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

end