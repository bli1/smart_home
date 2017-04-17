function [B_state, R_state] = create_state_B(B, R_state)
    %insert B, but split R & B into two table
    [szb, B_length] = size(B);
    [R_length, szr] = size(R_state);
    for j = 1:B_length
        R_state((j-1)*R_length+1:j*R_length, :) = R_state(1:R_length, :);
        B_state((j-1)*R_length+1:j*R_length) = B(j);
    end

end

