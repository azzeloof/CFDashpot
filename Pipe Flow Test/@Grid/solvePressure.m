function solvePressure(obj, n)

cutoff = 1e-6;
maxDiff = 1;
B = obj.dx/obj.dy;
P0 = obj.P(:,:,n-1);
P1 = zeros(size(obj.P,1),size(obj.P,2));

% Set one node to zero
while maxDiff > cutoff
    for i = 2:size(P0,1) - 1
        for j = 2:size(P0,2) - 1
            a = P0(i-1,j) + P0(i+1,j) + B^2 * (P0(i,j-1) + P0(i,j+1));
            b = obj.dx^2 * (1/obj.dt) * ((obj.u(i,j) - obj.u(i-1,j))/obj.dx + ...
                (obj.v(i,j) - obj.v(i,j-1))/obj.dy);
            P1(i,j) = (1/(2*(1+B^2))) * a - (1/(2*(1+B^2))) * b;
        end
    end
    maxDiff = max(max(abs(P1 - P0)));
    P0 = P1;
end

obj.P(:,:,n) = P1;

end