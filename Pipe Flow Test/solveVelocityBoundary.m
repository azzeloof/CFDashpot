function [uOut,vOut] = solveVelocityBoundary(uIn, vIn, inletVelocity, obsX1, obsX2, obsY1, obsY2)

uOut = uIn;
vOut = vIn;

% Inlet
uOut(2:end-1,1) = -uIn(2:end-1,2);
vOut(2:end-1,1) = inletVelocity;

% Outlet
uOut(2:end-1,end) = -uIn(2:end-1,end-1);
vOut(2:end-1,end) = vIn(2:end-1,end-1);

% Left wall (u = 0, v = 0);
uOut(1,:) = 0;
vOut(1,:) = -vOut(2,:);

% Right wall (u = 0, v = 0);
uOut(end,:) = 0;
vOut(end,:) = -vOut(end-1,:);

% Obstacle Bottom
uOut(obsX1:obsX2,obsY1) = uOut(obsX1:obsX2,obsY1-1);
vOut(obsX1:obsX2,obsY1) = 0;

% Obstacle Top
uOut(obsX1:obsX2,obsY2) = uOut(obsX1:obsX2,obsY2+1);
vOut(obsX1:obsX2,obsY2) = 0;

% Obstacle Right Wall;
uOut(obsX2,obsY1:obsY2) = 0;
vOut(obsX2,obsY1:obsY2) = -vOut(obsX2+1,obsY1:obsY2);

% Obstacle Left Wall;
uOut(obsX1,obsY1:obsY2) = 0;
vOut(obsX1,obsY1:obsY2) = -vOut(obsX1-2,obsY1:obsY2);

end