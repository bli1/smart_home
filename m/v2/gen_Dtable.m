function [Dynp] = gen_Dtable(runtime, price, power, states)
    [szr, appnum] = size(runtime);
    Dynp(:,:,1) = states (:, appnum+1:end);        %%operations
    Dynp(:,:,2) = states (:, appnum+1:end);    %%for price
    Dynp(:,:,3) = states (:, appnum+1:end);     %%for position y
    R (:, 1:appnum) = states(:, 1:appnum);                %%remaining operation states
    t = 1;
    
    [szp, timeslot] = size(price);
    [remain, szr] = size(R);
    starter = ones(1, appnum);
    starter = creat_state(starter, 0);
    starter = starter(:, 1:end-1);
    if t == 1
        Dynp(1,1,:) = 1;
        Dynp(1,1,2) = 0;
    end
    
    for t = 1 : timeslot-1
        for r = 1: remain
            if Dynp(r, t, 1) == 1
                next_opt = find_next_opt(r, R, starter, appnum, runtime);
                Dynp(: , t+1, :) = next_state(Dynp(:, t, :), Dynp(:, t+1, :), runtime, price, power, next_opt, R, r, t, timeslot);
            end
        end
    end
    
    
   
end