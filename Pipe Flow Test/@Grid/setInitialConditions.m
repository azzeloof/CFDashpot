function setInitialConditions(obj, u0, v0, P0)

    obj.u(:,:,1) = u0;
    obj.v(:,:,1) = v0;
    obj.P(:,:,1) = P0;

end