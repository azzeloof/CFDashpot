function result = nodeOnBox(obj,i,j,var)
% Returns true if node is inside the box or on a boundary of the box

if var == 'u'
    if (i >= obj.boxUBounds(1) - 1 && ...
        i <= obj.boxUBounds(2) + 1 && ...
        j >= obj.boxUBounds(3) && ...
        j <= obj.boxUBounds(4))

        result = true;

    else
        result = false;

    end
    
elseif var == 'v'
    if (i >= obj.boxVBounds(1) && ...
        i <= obj.boxVBounds(2) && ...
        j >= obj.boxVBounds(3) - 1 && ...
        j <= obj.boxVBounds(4) + 1)

        result = true;

    else
        result = false;

    end
    
elseif var == 'P'
    if (i >= obj.boxPBounds(1) && ...
        i <= obj.boxPBounds(2) && ...
        j >= obj.boxPBounds(3) && ...
        j <= obj.boxPBounds(4))

        result = true;

    else
        result = false;

    end
    
else
    disp('Invalid variable');
    result = NaN;
    
end

end