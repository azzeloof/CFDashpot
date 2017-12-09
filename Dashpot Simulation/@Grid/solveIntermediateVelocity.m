function solveIntermediateVelocity(obj, n, nu, blockVelocity)

for i = 2:size(obj.u,1) - 1
    for j = 2:size(obj.v,2) - 1
        % Solve for uF
        % Advection in x direction
        Au = obj.solveAdvection(i, j, n-1, 'x');

        % Diffusion in x direction
        Bu = obj.solveDiffusion(i, j, n-1, nu, 'x');

        % Solve for intermediate velocity
        obj.uF(i,j) = obj.u(i,j,n-1) + obj.dt*(Au + Bu);
        
        % Solve for vF
        % Advection in y direction
        Av = obj.solveAdvection(i, j, n-1, 'y');

        % Diffusion in y direction
        Bv = obj.solveDiffusion(i, j, n-1, nu, 'y');

        % Solve for intermediate velocity
        obj.vF(i,j) = obj.v(i,j,n-1) + obj.dt*(Av + Bv);
    end
end

% Solve uF at last j node
j = size(obj.u,2) - 1;
for i = 2:size(obj.u,1) - 1
    % Advection in x direction
    Au = obj.solveAdvection(i, j, n-1, 'x');

    % Diffusion in x direction
    Bu = obj.solveDiffusion(i, j, n-1, nu, 'x');

    % Solve for intermediate velocity
    obj.uF(i,j) = obj.u(i,j,n-1) + obj.dt*(Au + Bu);
end

% Solve vF ast last i node
i = size(obj.v,1) - 1;
for j = 2:size(obj.v,2) - 1
    % Advection in y direction
    Av = obj.solveAdvection(i, j, n-1, 'y');

    % Diffusion in y direction
    Bv = obj.solveDiffusion(i, j, n-1, nu, 'y');

    % Solve for intermediate velocity
    obj.vF(i,j) = obj.v(i,j,n-1) + obj.dt*(Av + Bv);
end

% Apply boundary conditions
[obj.uF, obj.vF] = solveVelocityBoundary(obj,obj.uF, obj.vF, blockVelocity);
        
end