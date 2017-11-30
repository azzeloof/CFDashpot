function [uUnified, vUnified] = unifyVelocity(obj, n)

% Initialize grids
uUnified = zeros(size(obj.P,1), size(obj.P,2));
vUnified = zeros(size(obj.P,1), size(obj.P,2));

% Solve via interpolation
for i = 2:size(uUnified,1)-1
    for j = 2:size(uUnified,1)-1
        uUnified(i,j) = (obj.u(i,j,n) + obj.u(i-1,j,n)) / 2;
        vUnified(i,j) = (obj.v(i,j,n) + obj.v(i,j-1,n)) / 2;
    end
end

% Remove ghost nodes
uUnified = uUnified(2:end-1,2:end-1);
vUnified = vUnified(2:end-1,2:end-1);

end