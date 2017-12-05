function solveFinalVelocity(obj, n, inletVelocity)

% Solve for u
for i = 2:size(obj.u,1)-1
    for j = 2:size(obj.u,2)-1
        obj.u(i,j,n) = obj.uF(i,j) - obj.dt*((obj.P(i+1,j,n) - obj.P(i,j,n))/obj.dx);
    end
end

% Solve for v
for i = 2:size(obj.v,1)-1
    for j = 2:size(obj.v,2)-1
        obj.v(i,j,n) = obj.vF(i,j) - obj.dt*((obj.P(i,j+1,n) - obj.P(i,j,n))/obj.dy);
    end
end

% Apply boundary conditions
[obj.u(:,:,n), obj.v(:,:,n)] = solveVelocityBoundary(obj.u(:,:,n), obj.v(:,:,n), inletVelocity);

end