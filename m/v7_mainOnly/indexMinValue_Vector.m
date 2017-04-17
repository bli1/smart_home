function [r] = indexMinValue_Vector(Vector)
    %find the min value in the vector and return the index
    %In this case, 1st find the min value; 
    %2nd when multiple solution give the same min value, 
    %choose the bigger index since it means the remaining battery energy is higher for the same price.  

    vector_length = length(Vector);
    MinValue = sum(Vector);
    r = vector_length;
    for i = 1 : vector_length
        if Vector(i) <= MinValue && Vector(i) ~= 0
            MinValue = Vector(i);
            r = i;
        end
    end


end
