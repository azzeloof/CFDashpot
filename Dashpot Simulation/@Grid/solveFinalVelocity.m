function solveFinalVelocity(obj, n, blockVelocity)

for i = 2:size(obj.P,1) - 1
    for j = 2:size(obj.P,2) - 1
        % Solve for u
        if (obj.nodeOnBox(i,j,'u') == false)
            obj.u(i,j,n) = obj.uF(i,j) - obj.dt*((obj.P(i+1,j,n) - obj.P(i,j,n))/obj.dx);
        end
        
        % Solve for v
        if (obj.nodeOnBox(i,j,'v') == false)
            obj.v(i,j,n) = obj.vF(i,j) - obj.dt*((obj.P(i,j+1,n) - obj.P(i,j,n))/obj.dy);
        end
    end
end

% Solve u at last j node
j = size(obj.u,2) - 1;
for i = 2:size(obj.u,1) - 1
    if (obj.nodeOnBox(i,j,'u') == false)
        obj.u(i,j,n) = obj.uF(i,j) - obj.dt*((obj.P(i+1,j,n) - obj.P(i,j,n))/obj.dx);
    end
end

% Solve v ast last i node
i = size(obj.v,1) - 1;
for j = 2:size(obj.v,2) - 1
    if (obj.nodeOnBox(i,j,'v') == false)
        obj.v(i,j,n) = obj.vF(i,j) - obj.dt*((obj.P(i,j+1,n) - obj.P(i,j,n))/obj.dy);
    end
end

% % Solve for u
% for i = 2:size(obj.u,1)-1
%     for j = 2:size(obj.u,2)-1
%         if (obj.nodeOnBox(i,j,'u') == false)
%             obj.u(i,j,n) = obj.uF(i,j) - obj.dt*((obj.P(i+1,j,n) - obj.P(i,j,n))/obj.dx);
%         end
%     end
% end
% 
% % Solve for v
% for i = 2:size(obj.v,1)-1
%     for j = 2:size(obj.v,2)-1
%         if (obj.nodeOnBox(i,j,'v') == false)
%             obj.v(i,j,n) = obj.vF(i,j) - obj.dt*((obj.P(i,j+1,n) - obj.P(i,j,n))/obj.dy);
%         end
%     end
% end

% Apply boundary conditions
[obj.u(:,:,n), obj.v(:,:,n)] = solveVelocityBoundary(obj,obj.u(:,:,n), obj.v(:,:,n), blockVelocity);


end