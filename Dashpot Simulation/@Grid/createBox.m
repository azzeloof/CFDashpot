function createBox(obj,width, height, yLocation)

xCenter = (length(obj.x)-1)/2 + 1;
yCenter = (yLocation/obj.dy) + (height/obj.dy)/2 + 1;
obj.boxPBounds = [xCenter - 0.5*(width/obj.dx) + 1
                  xCenter + 0.5*(width/obj.dx)
                  yCenter - 0.5*(height/obj.dy)
                  yCenter + 0.5*(height/obj.dy) - 1];
obj.boxUBounds = [xCenter - 0.5*(width/obj.dx) + 1
                  xCenter + 0.5*(width/obj.dx) - 1
                  yCenter - 0.5*(height/obj.dy)
                  yCenter + 0.5*(height/obj.dy) - 1];
obj.boxVBounds = [xCenter - 0.5*(width/obj.dx) + 1
                  xCenter + 0.5*(width/obj.dx)
                  yCenter - 0.5*(height/obj.dy)
                  yCenter + 0.5*(height/obj.dy) - 2];

end