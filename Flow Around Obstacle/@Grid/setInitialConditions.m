function setInitialConditions(obj, u0, v0, P0)

obs = obj.obs;

obj.u(:,:,1) = u0;
obj.v(:,:,1) = v0;
obj.P(:,:,1) = P0;

obj.u(obs.xVec(2:end-1),obs.yVec(2:end-1),1) = NaN;
obj.v(obs.xVec(2:end-1),obs.yVec(2:end-1),1) = NaN;
obj.P(obs.xVec(2:end-1),obs.yVec(2:end-1),1) = NaN;

end