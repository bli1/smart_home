function [ index ] = counter( operation )
    chk = 1;
    op_len = length(operation);
    index = 0;
    for i = 1: op_len
        if operation(i) == 1
            index(chk) = i;
        end
    end

end

