function [ Dynp_next, l_avg ] = next_state_worstcase( Dynpt, Dynp_next, runtime, ...
    price, power, next_opt, R, r, b, b_next, t, timeslot, next_B_opt, B_state, lamda, ...
    B_init, B_end, solution_schedulable, R_schedulable, runtime_schedulable, ...
    power_schedulable, l_avg, appnum_schedulable, B_state_schedulable)
    [opt, szs] = size(next_opt);
    [remain, appnum] = size(R);
    current_battery_state = B_state_schedulable(b);
    next_battery_state = B_state_schedulable(b_next);
    charged_energy_t = next_battery_state - current_battery_state;

    chkt = 0;
    chkr = 0;
    % for all potential options
    for o = 1: opt
        % check whether this option will finish task before end 
        chkt = R(r, :) - next_opt(o, :);
        
        if max(chkt)+t < timeslot
            %for all remaining 
            for next = 1:remain
		%l_t_scheduable
		l_t_schedulable = solution_schedulable(r, t)*~(R_schedulable(r, 1:appnum_schedulable) == runtime_schedulable)*power_schedulable' - charged_energy_t;	
                l_t = next_opt(o, :)*power'+l_t_schedulable;
                pravicy_chk = l_t - current_battery_state + next_battery_state- l_avg;
                if pravicy_chk >= -lamda && pravicy_chk <= lamda %pravicy model
                   chkr = R(r, :)-next_opt(o, :)-R(next, :);
                    
                    if max(chkr)==0 && min(chkr)==0 && B_state(next) == next_battery_state
                        Dynp_next(next, 1) = 1;
                        
                        if Dynp_next (next, 2) == 0
                            Dynp_next (next, 2) = pravicy_chk;
                            Dynp_next (next, 3) = r;
                        elseif Dynp_next (next, 2) < pravicy_chk
                            Dynp_next (next, 2) = pravicy_chk;
                            Dynp_next (next, 3) = r;
                        end
                        
                    end
                    
                end
            end
        end
        
        
        
    end


end

