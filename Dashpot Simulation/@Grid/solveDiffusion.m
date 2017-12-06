function B = solveDiffusion(obj, i, j, n, mu, rho, direction)

if direction == 'x'
    d2u_dx2 = (obj.u(i+1,j,n) - 2*obj.u(i,j,n) + obj.u(i-1,j,n)) / obj.dx^2;
    d2u_dy2 = (obj.u(i,j+1,n) - 2*obj.u(i,j,n) + obj.u(i,j-1,n)) / obj.dy^2;
    B = (mu/rho) * (d2u_dx2 + d2u_dy2);
    
elseif direction == 'y'
    d2v_dx2 = (obj.v(i+1,j,n) - 2*obj.v(i,j,n) + obj.v(i-1,j,n)) / obj.dx^2;
    d2v_dy2 = (obj.v(i,j+1,n) - 2*obj.v(i,j,n) + obj.v(i,j-1,n)) / obj.dy^2;
    B = (mu/rho) * (d2v_dx2 + d2v_dy2);
    
else
    disp('invalid direction');
    B = NaN;
    
end

end