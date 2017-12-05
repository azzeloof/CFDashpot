function A = solveAdvection(obj, i, j, n, direction)

if direction == 'x'
    duu_dx = 1/obj.dx * (((obj.u(i,j,n) + obj.u(i+1,j,n)) / 2)^2 - ...
                         ((obj.u(i,j,n) + obj.u(i-1,j,n)) / 2)^2);
    dvu_dy = 1/obj.dy * (((obj.v(i,j,n) + obj.v(i+1,j,n)) / 2) * ...
                         ((obj.u(i,j,n) + obj.u(i,j+1,n)) / 2) - ...
                         ((obj.v(i,j-1,n) + obj.v(i+1,j-1,n)) / 2) * ...
                         ((obj.u(i,j-1,n) + obj.u(i,j,n)) / 2));
    A = -(duu_dx + dvu_dy);


elseif direction == 'y'
    duv_dx = 1/obj.dx * (((obj.u(i,j,n) + obj.u(i,j+1,n)) / 2) * ...
                         ((obj.v(i,j,n) + obj.v(i+1,j,n)) / 2) - ...
                         ((obj.u(i-1,j,n) + obj.u(i-1,j+1,n)) / 2) * ...
                         ((obj.v(i,j,n) + obj.v(i-1,j,n)) / 2));
    dvv_dy = 1/obj.dy * (((obj.v(i,j,n) + obj.u(i,j+1,n)) / 2)^2 - ...
                         ((obj.v(i,j,n) + obj.u(i,j-1,n)) / 2)^2);
    A = -(duv_dx + dvv_dy);

else
    disp('invalid direction');
    A = NaN;

end

end