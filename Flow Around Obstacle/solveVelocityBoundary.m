function [uOut,vOut] = solveVelocityBoundary(uIn, vIn, inletVelocity, obs)

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

% Object top
uOut(obs.xVec(2:end-1),obs.yVec(end-1)) = -uIn(obs.xVec(2:end-1),obs.yVec(end));
vOut(obs.xVec(2:end-1),obs.yVec(end-1)) = 0;

% Object bottom
uOut(obs.xVec(2:end-1),obs.yVec(2)) = uIn(obs.xVec(2:end-1),obs.yVec(1));
vOut(obs.xVec(2:end-1),obs.yVec(2)) = 0;

% Object right
uOut(obs.xVec(end-1),obs.yVec(2:end-1)) = 0;
vOut(obs.xVec(end-1),obs.yVec(2:end-1)) = -vOut(obs.xVec(end),obs.yVec(2:end-1));

% Object left
uOut(obs.xVec(2),obs.yVec(2:end-1)) = 0;
vOut(obs.xVec(2),obs.yVec(2:end-1)) = -vOut(obs.xVec(1),obs.yVec(2:end-1));

end