function POut = solvePressureBoundary(obj, PIn)

POut = PIn;

% Inlet
POut(2:end-1,1) = POut(2:end-1,2);

% Outlet
POut(2:end-1,end) = POut(2:end-1,end-1);

% Left wall
POut(1,:) = POut(2,:);

% Right wall
POut(end,:) = POut(end-1,:);

% Box left wall
POut(obj.boxPBounds(1),obj.boxPBounds(3):obj.boxPBounds(4)) = POut(obj.boxPBounds(1)-1,obj.boxPBounds(3):obj.boxPBounds(4));

% Box right wall
POut(obj.boxPBounds(2),obj.boxPBounds(3):obj.boxPBounds(4)) = POut(obj.boxPBounds(2)+1,obj.boxPBounds(3):obj.boxPBounds(4));

% Box bottom wall
POut(obj.boxPBounds(1):obj.boxPBounds(2),obj.boxPBounds(3)) = POut(obj.boxPBounds(1):obj.boxPBounds(2),obj.boxPBounds(3)-1);

% Box top wall
POut(obj.boxPBounds(1):obj.boxPBounds(2),obj.boxPBounds(4)) = POut(obj.boxPBounds(1):obj.boxPBounds(2),obj.boxPBounds(4)+1);

end