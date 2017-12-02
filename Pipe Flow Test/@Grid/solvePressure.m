function solvePressure(obj, n)

cutoff = 0.001;
maxDiff = 1;
B = obj.dx/obj.dy;
P0 = obj.P(:,:,n-1);
P1 = P0;
P1(2:end-1,2:end-1) = zeros(size(obj.P,1)-2,size(obj.P,2)-2);
w = 1;

counter = 0;
while maxDiff > cutoff
    counter = counter + 1;
    
    for i = 2:size(P0,1) - 1
        for j = 2:size(P0,2) - 1
            
            % Gauss-Seidel w/ SOR
            b = (1/obj.dt) * ((obj.uF(i,j) - obj.uF(i-1,j))/obj.dx + ...
                    (obj.vF(i,j) - obj.vF(i,j-1))/obj.dy);
            c = w/(2*(1+B^2));
            
            if i == 2 && j == 2 % bottom left corner
                multipler = (1 - w/2)^(-1);
                a = P0(i+1,j) + B^2*P0(i,j+1);
                P1(i,j) = multipler * ((1-w)*P0(i,j) + c*a - obj.dx^2*c*b);
                
            elseif i == 2 % left wall
                multipler = (1 - c)^(-1);
                a = P0(i+1,j) + B^2*(P1(i,j-1) + P0(i,j+1));
                P1(i,j) = multipler * ((1-w)*P0(i,j) + c*a - obj.dx^2*c*b);
                
            elseif j == 2 % bottom wall
                multipler = (1 - B^2*c)^(-1);
                a = P1(i-1,j) + P0(i+1,j) + B^2*P0(i,j+1);
                P1(i,j) = multipler * ((1-w)*P0(i,j) + c*a - obj.dx^2*c*b);
                
            else
                a = P1(i-1,j) + P0(i+1,j) + B^2*(P1(i,j-1) + P0(i,j+1));
                P1(i,j) = (1-w)*P0(i,j) + c*a - obj.dx^2*c*b;
        
            end
            
            % Point Jacobi
%             a = P0(i-1,j) + P0(i+1,j) + B^2 * (P0(i,j-1) + P0(i,j+1));
%             b = (1/obj.dt) * ((obj.uF(i,j) - obj.uF(i-1,j))/obj.dx + ...
%                 (obj.vF(i,j) - obj.vF(i,j-1))/obj.dy);
%             P1(i,j) = (1/(2*(1+B^2))) * a - (obj.dx^2/(2*(1+B^2))) * b;
        end
    end
    
    P1 = solvePressureBoundary(P1);
    maxDiff = max(max(abs(P1 - P0)));
    P0 = P1;
end

obj.P(:,:,n) = P1;

end