function POut = solvePressureBoundary(PIn)

POut = PIn;

% Inlet
POut(2:end-1,1) = POut(2:end-1,2);

% Outlet
POut(2:end-1,end) = 0;%POut(2:end-1,end-1);

% Left wall
POut(1,:) = POut(2,:);

% Right wall
POut(end,:) = POut(end-1,:);

end