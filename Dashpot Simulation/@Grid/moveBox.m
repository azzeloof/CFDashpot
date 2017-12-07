function moveBox(obj, steps)

obj.boxPBounds(3) = obj.boxPBounds(3) + steps;
obj.boxPBounds(4) = obj.boxPBounds(4) + steps;

obj.boxUBounds(3) = obj.boxUBounds(3) + steps;
obj.boxUBounds(4) = obj.boxUBounds(4) + steps;

obj.boxVBounds(3) = obj.boxVBounds(3) + steps;
obj.boxVBounds(4) = obj.boxVBounds(4) + steps;

end