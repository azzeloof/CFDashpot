function solveIntermediateVelocity(obj, n, mu, rho, inletVelocity, blockVelocity)

% Solve for uF
for i = 2:size(obj.u,1) - 1
    for j = 2:size(obj.u,2) - 1
        if (obj.nodeOnBox(i,j,'u') == false)
            %if n == 2
                % Advection in x direction
                Au = obj.solveAdvection(i, j, n-1, 'x');

                % Diffusion in x direction
                Bu = obj.solveDiffusion(i, j, n-1, mu, rho, 'x');

                % Solve for intermediate velocity
                obj.uF(i,j) = obj.u(i,j,n-1) + obj.dt*(Au + Bu);
                if isnan(obj.uF(i,j))
                    [i j]
                    obj.uF(i,j)
                    Au
                    Bu
                end
            %else
%                 % Advection in x direction
%                 Au0 = obj.solveAdvection(i, j, n-2, 'x');
%                 Au1 = obj.solveAdvection(i, j, n-1, 'x');
% 
%                 % Diffusion in x direction
%                 Bu0 = obj.solveDiffusion(i, j, n-2, mu, rho, 'x');
%                 Bu1 = obj.solveDiffusion(i, j, n-1, mu, rho, 'x');
% 
%                 % Solve for intermediate velocity
%                 obj.uF(i,j) = obj.u(i,j,n-1) + obj.dt*((3/2)*(Au1 + Bu1) - (1/2)*(Au0 + Bu0));
%                 if isnan(obj.uF(i,j))
%                     [i j]
%                     Au0
%                     Au1
%                     Bu0
%                     Bu1
%                 end
%             end
        end
    end
end


% Solve for vF
for i = 2:size(obj.v,1) - 1
    for j = 2:size(obj.v,2) - 1
        if (obj.nodeOnBox(i,j,'v') == false)
            %if n == 2
                % Advection in y direction
                Av = obj.solveAdvection(i, j, n-1, 'y');

                % Diffusion in y direction
                Bv = obj.solveDiffusion(i, j, n-1, mu, rho, 'y');

                % Solve for intermediate velocity
                obj.vF(i,j) = obj.v(i,j,n-1) + obj.dt*(Av + Bv);
                if isnan(obj.vF(i,j))
                    [i j]
                    obj.vF(i,j)
                    Av
                    Bv
                end
            %else
%                 % Advection in y direction
%                 Av0 = obj.solveAdvection(i, j, n-2, 'y');
%                 Av1 = obj.solveAdvection(i, j, n-1, 'y');
% 
%                 % Diffusion in y direction
%                 Bv0 = obj.solveDiffusion(i, j, n-2, mu, rho, 'y');
%                 Bv1 = obj.solveDiffusion(i, j, n-1, mu, rho, 'y');
% 
%                 % Solve for intermediate velocity
%                 obj.vF(i,j) = obj.v(i,j,n-1) + obj.dt*((3/2)*(Av1 + Bv1) - (1/2)*(Av0 + Bv0));
%             end
         end
    end
end

if n == 1001
    disp('uF and vF before boundary')
    obj.uF(:,:)
    obj.vF(:,:)
end

% Apply boundary conditions
[obj.uF, obj.vF] = solveVelocityBoundary(obj,obj.uF, obj.vF, inletVelocity, blockVelocity);

if n == 1001
    disp('uF and vF after boundary')
    obj.uF(:,:)
    obj.vF
end
        
end