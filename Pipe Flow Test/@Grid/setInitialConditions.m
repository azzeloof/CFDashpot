function setInitialConditions(obj, u0, v0, P0)

obj.u(:,:,1) = u0;
obj.v(:,:,1) = v0;
obj.P(:,:,1) = P0;

obj.u(obj.obsX1:obj.obsX2,obj.obsY1:obj.obsY2,1) = NaN;
obj.v(obj.obsX1:obj.obsX2,obj.obsY1:obj.obsY2,1) = NaN;
obj.P(obj.obsX1:obj.obsX2,obj.obsY1:obj.obsY2,1) = NaN;

end