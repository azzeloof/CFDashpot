function solvePressure(obj, n, w)

cutoff = 0.002;
maxDiff = 1;
B = obj.dx/obj.dy;
P0 = obj.P(:,:,n-1);
P1 = P0;

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
                a = P0(i+1,j) + B^2*P0(i,j+1);
                coeff1 = c/(1-c-c*B^2);
                coeff2 = (1-w)/(1-c-c*B^2);
                
            elseif i == 2 % left wall
                a = P0(i+1,j) + B^2*(P1(i,j-1) + P0(i,j+1));
                coeff1 = c/(1-c);
                coeff2 = (1-w)/(1-c);
                
            elseif j == 2 % bottom wall
                a = P1(i-1,j) + P0(i+1,j) + B^2*P0(i,j+1);
                coeff1 = c/(1-c*B^2);
                coeff2 = (1-w)/(1-c*B^2);
                
            else
                a = P1(i-1,j) + P0(i+1,j) + B^2*(P1(i,j-1) + P0(i,j+1));
                coeff1 = c;
                coeff2 = (1-w);
        
            end
            
            P1(i,j) = coeff1*a - coeff1*obj.dx^2*b + coeff2*P0(i,j);
            
        end
    end
    
    P1 = solvePressureBoundary(P1);
    maxDiff = max(max(abs(P1 - P0)));
    P0 = P1;
    
end

obj.P(:,:,n) = P1;

end