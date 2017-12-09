function findBoxPressure(obj, n)

P = obj.P(:,:,n);

xMin = obj.boxPBounds(1);
xMax = obj.boxPBounds(2);
yMin = obj.boxPBounds(3);
yMax = obj.boxPBounds(4);

obj.boxPressure(n,1) = sum(P(xMin:xMax,yMin))/(xMax-xMin);
obj.boxPressure(n,2) = sum(P(xMin:xMax,yMax))/(xMax-xMin);
end