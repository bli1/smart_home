function [solution_nonschedulable_wst, l_t_wst, best_price, solution_schedulable ] = gen_Dtable_worstCase(runtime_nonschedulable, ... 
        price, power_nonschedulable, R_state_nonschedulable, B_state_nonschedulable, ...
        B_opt, B_init, B_end, B_max, lamda, Dtable_schedulable, ...
        R_state_schedulable, runtime_schedulable, power_schedulable, l_avg, ...
        appnum_schedulable, B_state_schedulable) 
    
    %From the Dtable_schedulable, extract the best solution for schedulable appliances.
    %Based on the Schedulable Operation, schedule the non-schedulable appliances to find the worst case in term of Privacy.

    % find the best price finish point index. 
    % input vector,  return the index.
    [indexMinValue] = indexMinValue_Vector(Dtable_schedulable(:, end, 2)); 
    % r hold the finishing point index.

    % track_Solution will create a Dtable(best solution only) 
    solution_schedulable = track_solution(indexMinValue, Dtable_schedulable);
    solution_schedulable(:,:,2:3) = Dtable_schedulable(:,:,2:3);
    [operation_schedulable, power_t_schedulable, battery_t_schedulable, ...
        ] = track_path(solution_schedulable, B_state_schedulable, ...
        R_state_schedulable, power_schedulable, price, l_avg, lamda);
    
    appnum_nonschedulable =  length(runtime_nonschedulable);
    timeslot = length(price);
    solution_nonschedulable_wst = zeros(appnum_nonschedulable, timeslot);
    
    
    best_price = solution_schedulable(indexMinValue, end, 2);
    disp('Best schedulable appliances solution: ');
    disp('The best price is ');
    disp(best_price);
    disp('schedulable appliances operation');
    disp(operation_schedulable');
    
    disp('power consumption');
    disp(power_t_schedulable');
        
    disp('battery operation (charge - / discharge +)')
    disp(battery_t_schedulable');
    
    disp('Price');
    disp(price);
    
    privacy_wst = power_t_schedulable(1);
    
    for p = 1:timeslot
        if privacy_wst < power_t_schedulable(p)
            privacy_wst = power_t_schedulable(p);
            solution_nonschedulable_wst = zeros(appnum_nonschedulable, timeslot);
            solution_nonschedulable_wst(:, p) = 1;
        elseif privacy_wst == power_t_schedulable(p)
            solution_nonschedulable_wst (:, p) = 1;
        end
    end
    
    

    
    disp('selected worst case for nonschedulable appliances operation');
    disp(solution_nonschedulable_wst);
    
    l_t_wst = privacy_wst + sum(power_nonschedulable);
    
    disp('The worst privacy case:');
    disp(l_t_wst);
    
end
