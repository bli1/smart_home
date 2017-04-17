function [next_B_opt] = find_next_B_opt(r, B_max, B_opt, B_state)
    current_B = B_state(r);
    B_length = length(B_opt);
    next_B_opt = 0;
    chk = 1;
    for i = 1:B_length
        if current_B + B_opt(i) <= B_max && current_B + B_opt(i) >=0
            next_B_opt(chk) = B_opt(i);
            chk = chk + 1;
        end
    end
end

