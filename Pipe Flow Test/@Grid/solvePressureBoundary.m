function solvePressureBoundary(obj, n)

% Left wall
obj.P(1,:,n) = obj.P(2,:,n);

% Right wall
obj.P(end,:,n) = obj.P(end-1,:,n);

% Inlet
obj.P(2:end-1,1,n) = obj.P(2:end-1,2,n);

% Outlet
obj.P(2:end-1,end,n) = obj.P(2:end-1,end-1,n);

end