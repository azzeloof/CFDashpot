function solvePressure(obj, n, w)

cutoff = 0.0001;
diffOld = 2;
diffNew = 1;
B = obj.dx/obj.dy;
P0 = obj.P(:,:,n-1);
P1 = P0;

counter = 0;
while abs(diffOld - diffNew) > cutoff
    
    counter = counter + 1;
    
    for i = 2:size(P0,1) - 1
        for j = 2:size(P0,2) - 1
            
            if (obj.nodeOnBox(i,j,'P') == false)
            
                % Gauss-Seidel w/ SOR
                b = (1/obj.dt) * ((obj.uF(i,j) - obj.uF(i-1,j))/obj.dx + ...
                        (obj.vF(i,j) - obj.vF(i,j-1))/obj.dy);
                c = w/(2*(1+B^2));

                if i == 2 && j == 2 % bottom left corner
                    a = P0(i+1,j) + B^2*P0(i,j+1);
                    coeff1 = c/(1-c-c*B^2);
                    coeff2 = (1-w)/(1-c-c*B^2);

                elseif (i == 2 ||... % left wall
                       (i == obj.boxPBounds(2)+1 && j >= obj.boxPBounds(3) && j <= obj.boxPBounds(4)))
                    a = P0(i+1,j) + B^2*(P1(i,j-1) + P0(i,j+1));
                    coeff1 = c/(1-c);
                    coeff2 = (1-w)/(1-c);

                elseif (j == 2 ||... % bottom wall
                       (j == obj.boxPBounds(4)+1 && j >= obj.boxPBounds(1) && j <= obj.boxPBounds(2)))
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
    end

    P1 = solvePressureBoundary(obj,P1);
    diffOld = diffNew;
    diffNew = max(max(abs(P1 - P0)));
    P0 = P1;
    
end

obj.P(:,:,n) = P1;

end