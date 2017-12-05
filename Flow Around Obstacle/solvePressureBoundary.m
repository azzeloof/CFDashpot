function POut = solvePressureBoundary(PIn)

obs = obj.obs;
POut = PIn;

% Inlet
POut(2:end-1,1) = POut(2:end-1,2);

% Outlet
POut(2:end-1,end) = POut(2:end-1,end-1);

% Left wall
POut(1,:) = POut(2,:);

% Right wall
POut(end,:) = POut(end-1,:);

% Obstacle bottom
POut(2:end-1,1) = POut(2:end-1,2);

% Obstacle top
POut(2:end-1,end) = POut(2:end-1,end-1);

% Obstacle right
POut(1,:) = POut(2,:);

% Obstacle left
POut(end,:) = POut(end-1,:);

end