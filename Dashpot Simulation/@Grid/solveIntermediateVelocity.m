function solveIntermediateVelocity(obj, n, nu, blockVelocity)

% for i = 2:size(obj.P,1) - 1
%     for j = 2:size(obj.P,2) - 1
%         if i < size(obj.u,1) - 1
%             % Advection in x direction
%             Au = obj.solveAdvection(i, j, n-1, 'x');
% 
%             % Diffusion in x direction
%             Bu = obj.solveDiffusion(i, j, n-1, nu, 'x');
% 
%             % Solve for intermediate velocity
%             obj.uF(i,j) = obj.u(i,j,n-1) + obj.dt*(Au + Bu);
%         end
%         
%         if j < size(obj.v,2)
%             % Advection in y direction
%             Av = obj.solveAdvection(i, j, n-1, 'y');
% 
%             % Diffusion in y direction
%             Bv = obj.solveDiffusion(i, j, n-1, nu, 'y');
% 
%             % Solve for intermediate velocity
%             obj.vF(i,j) = obj.v(i,j,n-1) + obj.dt*(Av + Bv);
%         end
%     end
% end
            
% Solve for uF
for i = 2:size(obj.u,1) - 1
    for j = 2:size(obj.u,2) - 1
        if (obj.nodeOnBox(i,j,'u') == false)
            % Advection in x direction
            Au = obj.solveAdvection(i, j, n-1, 'x');

            % Diffusion in x direction
            Bu = obj.solveDiffusion(i, j, n-1, nu, 'x');

            % Solve for intermediate velocity
            obj.uF(i,j) = obj.u(i,j,n-1) + obj.dt*(Au + Bu);
        end
    end
end

% Solve for vF
for i = 2:size(obj.v,1) - 1
    for j = 2:size(obj.v,2) - 1
        if (obj.nodeOnBox(i,j,'v') == false)
            % Advection in y direction
            Av = obj.solveAdvection(i, j, n-1, 'y');

            % Diffusion in y direction
            Bv = obj.solveDiffusion(i, j, n-1, nu, 'y');

            % Solve for intermediate velocity
            obj.vF(i,j) = obj.v(i,j,n-1) + obj.dt*(Av + Bv);
         end
    end
end

% Apply boundary conditions
[obj.uF, obj.vF] = solveVelocityBoundary(obj,obj.uF, obj.vF, blockVelocity);
        
end