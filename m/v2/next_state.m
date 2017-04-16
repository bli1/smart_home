function [ Dynp_next ] = next_state( Dynpt, Dynp_next, runtime, price, power, next_opt, R, r, t, timeslot )
    [opt, szs] = size(next_opt);
    [remain, appnum] = size(R);
    chkt = 0;
    chkr = 0;
    for o = 1: opt
        chkt = R(r, :) - next_opt(o, :);
        if max(chkt)+t < timeslot
            for next = 1:remain
                chkr = R(r, :)-next_opt(o, :)-R(next, :);
                if max(chkr)==0 && min(chkr)==0
                    Dynp_next(next, 1) = 1;
                    if Dynp_next (next, 2) == 0
                       Dynp_next (next, 2) = utl_price(power, price, next_opt(o, :), t)+ Dynpt(r, 2);
                       Dynp_next (next, 3) = r;
                    elseif Dynp_next (next, 2) > utl_price(power, price, next_opt(o, :), t)+ Dynpt(r, 2)
                       Dynp_next (next, 2) = utl_price(power, price, next_opt(o, :), t)+ Dynpt(r, 2);
                       Dynp_next (next, 3) = r;
                    end

                end
            end
        end
    end


end

