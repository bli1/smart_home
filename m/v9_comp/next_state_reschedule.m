function [ Dynp_next ] = next_state_reschedule( Dynpt, Dynp_next, runtime, ...
    price, power, next_opt, R, r, b, t, timeslot, next_B_opt, B_state, ...
    lamda, B_init, B_end, solution_nonschedulable_worstCase, power_nonschedulable)

    [opt, szs] = size(next_opt);
    [remain, appnum] = size(R);
    current_battery_state = B_state(r);
    next_battery_state = next_B_opt(b) + current_battery_state;
    charged_energy_t = next_battery_state - current_battery_state;
    l_avg = (sum(solution_nonschedulable_worstCase(:,:,1)'*power_nonschedulable')+(power * runtime') - B_init + B_end)/timeslot;
    chkt = 0;
    chkr = 0;
    % for all potential options
    for o = 1: opt
        % check whether this option will finish task before end 
        chkt = R(r, :) - next_opt(o, :);
        
        if max(chkt)+t < timeslot
            %for all remaining 
            for next = 1:remain
                l_t = next_opt(o, :)*power' + charged_energy_t;
                privacy_chk = l_t - l_avg;
                [safe, power_total] = privacy_check_reschedule(t+1, privacy_chk, lamda, solution_nonschedulable_worstCase, ...
                        power_nonschedulable);
                if  safe == 1%pravicy model
                   chkr = R(r, :)-next_opt(o, :)-R(next, :);
                    
                    if max(chkr)==0 && min(chkr)==0 && B_state(next) == next_battery_state
                        Dynp_next(next, 1) = 1;
                        
                        if Dynp_next (next, 2) == 0
                            Dynp_next (next, 2) = utl_price(l_t, price, t)+ Dynpt(r, 2);
                            Dynp_next (next, 3) = r;
                        elseif Dynp_next (next, 2) > utl_price(l_t, price, t)+ Dynpt(r, 2)
                            Dynp_next (next, 2) = utl_price(l_t, price, t)+ Dynpt(r, 2);
                            Dynp_next (next, 3) = r;
                        end
                        
                    end
                    
                end
            end
        end
        
        
        
    end


end

