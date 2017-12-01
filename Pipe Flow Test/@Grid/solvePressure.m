function solvePressure(obj, n)

cutoff = 0.01;
maxDiff = 1;
B = obj.dx/obj.dy;
P0 = obj.P(:,:,n-1);
P1 = zeros(size(obj.P,1),size(obj.P,2));

counter = 0;
while maxDiff > cutoff
    counter = counter + 1;
    
    for i = 2:size(P0,1) - 1
        for j = 2:size(P0,2) - 1
%             if i == size(P0,1) - 2 && j == size(P0,2) - 2
%                 P1(i,j) = 0;
%             else
                a = P0(i-1,j) + P0(i+1,j) + B^2 * (P0(i,j-1) + P0(i,j+1));
                b = (1/obj.dt) * ((obj.uF(i,j) - obj.uF(i-1,j))/obj.dx + ...
                    (obj.vF(i,j) - obj.vF(i,j-1))/obj.dy);
                P1(i,j) = (1/(2*(1+B^2))) * a - (obj.dx^2/(2*(1+B^2))) * b;
%             end
        end
    end
%     P1(:,end-1) = 0;
    P1 = solvePressureBoundary(P1);
    maxDiff = max(max(abs(P1 - P0)));
    P0 = P1;
end

obj.P(:,:,n) = P1;

end