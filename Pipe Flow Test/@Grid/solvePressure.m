function solvePressure(obj, n)

cutoff = 1e-6;
maxDiff = 1;
B = obj.dx/obj.dy;
P0 = obj.P(:,:,n-1);
%P1 = zeros(size(obj.P,1),size(obj.P,2));
% Changed this because when, in the loop, P0 is set to P1, BCs are removed
P1 = P0;
P1(2:end-1,2:end-1) = 0;

% This was previously using u(i,j) and v(i,j). Changed to use uF and vF.
while maxDiff > cutoff
    for i = 2:size(P0,1) - 1
        for j = 2:size(P0,2) - 1
            a = P0(i-1,j) + P0(i+1,j) + B^2 * (P0(i,j-1) + P0(i,j+1));
            b = obj.dx^2 * (1/obj.dt) * ((obj.uF(i,j) - obj.uF(i-1,j))/obj.dx + ...
                (obj.vF(i,j) - obj.vF(i,j-1))/obj.dy);
            P1(i,j) = (1/(2*(1+B^2))) * a - (1/(2*(1+B^2))) * b;
        end
    end
    
    maxDiff = max(max(abs(P1 - P0)));
    P0 = P1;
end

%obj.P(2:end-1,2:end-1,n) = P1(2:end-1,2:end-1);
obj.P(:,:,n) = P1;

end