function solveIntermediateVelocity(obj, n, mu, rho)

% Solve for uF
for i = 2:size(obj.u,1) - 1
    for j = 2:size(obj.u,2) - 1
        % Advection in x direction
        duu_dx = 1/obj.dx * (((obj.u(i,j,n-1) + obj.u(i+1,j,n-1)) / 2)^2 - ...
                             ((obj.u(i,j,n-1) + obj.u(i-1,j,n-1)) / 2)^2);
        dvu_dy = 1/obj.dy * (((obj.v(i,j,n-1) + obj.v(i+1,j,n-1)) / 2) * ...
                             ((obj.u(i,j,n-1) + obj.u(i,j+1,n-1)) / 2) - ...
                             ((obj.v(i,j-1,n-1) + obj.v(i+1,j-1,n-1)) / 2) * ...
                             ((obj.u(i,j-1,n-1) + obj.u(i,j,n-1)) / 2));
        Au = duu_dx + dvu_dy;
        
        % Diffusion in x direction
        d2u_dx2 = (obj.u(i+1,j,n-1) - 2*obj.u(i,j,n-1) + obj.u(i-1,j,n-1)) / obj.dx^2;
        d2u_dy2 = (obj.u(i,j+1,n-1) - 2*obj.u(i,j,n-1) + obj.u(i,j-1,n-1)) / obj.dy^2;
        Bu = (mu/rho) * (d2u_dx2 + d2u_dy2);
        
        % Solve for intermediate velocity
        obj.uF(i,j) = obj.u(i,j,n-1) + obj.dt*(Au + Bu);
    end
end

%Solve for vF
for i = 2:size(obj.v,1) - 1
    for j = 2:size(obj.v,2) - 1
        % Advection in y direction
        duv_dx = 1/obj.dx * (((obj.u(i,j,n-1) + obj.u(i,j+1,n-1)) / 2) * ...
                             ((obj.v(i,j,n-1) + obj.v(i+1,j,n-1)) / 2) - ...
                             ((obj.u(i-1,j,n-1) + obj.u(i-1,j+1,n-1)) / 2) * ...
                             ((obj.v(i,j,n-1) + obj.v(i-1,j,n-1)) / 2));
        dvv_dy = 1/obj.dy * (((obj.v(i,j,n-1) + obj.u(i,j+1,n-1)) / 2)^2 - ...
                             ((obj.v(i,j,n-1) + obj.u(i,j-1,n-1)) / 2)^2);
        Av = duv_dx + dvv_dy;
                
        % Diffusion in y direction
        d2v_dx2 = (obj.v(i+1,j,n-1) - 2*obj.v(i,j,n-1) + obj.v(i-1,j,n-1)) / obj.dx^2;
        d2v_dy2 = (obj.v(i,j+1,n-1) - 2*obj.v(i,j,n-1) + obj.v(i,j-1,n-1)) / obj.dy^2;
        Bv = (mu/rho) * (d2v_dx2 + d2v_dy2);
        
        % Solve for intermediate velocity
        obj.vF(i,j) = obj.v(i,j,n-1) + obj.dt*(Av + Bv);
    end
end
        
end