function solveFinalVelocity(obj, n)

% Solve for u
for i = 2:size(u,1)-1
    for j = 2:size(u,2)-1
        obj.u(i,j,n) = obj.uF(i,j) - obj.dt*((obj.P(i+1,j,n) - obj.P(i-1,j,n))/(2*obj.dx));
    end
end

% Solve for v
for i = 2:size(v,1)-1
    for j = 2:size(v,2)-1
        obj.v(i,j,n) = obj.vF(i,j) - obj.dt*((obj.P(i,j+1,n) - obj.P(i,j-1,n))/(2*obj.dy));
    end
end

end