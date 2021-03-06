function POut = solvePressureBoundary(PIn, obs)

POut = PIn;

% Inlet
POut(2:end-1,1) = POut(2:end-1,2);

% Outlet
POut(2:end-1,end) = POut(2:end-1,end-1);

% Left wall
POut(1,:) = POut(2,:);

% Right wall
POut(end,:) = POut(end-1,:);

% Obstacle top
POut(obs.xVec(2:end-1),obs.yVec(end-1)) = POut(obs.xVec(2:end-1),obs.yVec(end));

% Obstacle bottom
POut(obs.xVec(2:end-1),obs.yVec(2)) = POut(obs.xVec(2:end-1),obs.yVec(1));

% Obstacle right
POut(obs.xVec(end-1),obs.yVec(2:end-1)) = POut(obs.xVec(end),obs.yVec(2:end-1));

% Obstacle left
POut(obs.xVec(2),obs.yVec(2:end-1)) = POut(obs.xVec(1),obs.yVec(2:end-1));

end