function [best_price, iter, pltA, B_state_schedulable, R_state_schedulable, power_schedulable, l_avg] = smartHome(price, runtime_schedulable, power_schedulable, ...
        runtime_nonschedulable, power_nonschedulable, battery, lamda)
    
    % for plot data (pltA, B_state_schedulable, R_state_schedulable, power_schedulable, price, l_avg, lamda)
%B_state, Dtable
    tic;

    
    appnum_schedulable = length(power_schedulable);
    B_max = battery(1);
    B_init = battery(2);
    B_end = battery(3);
    %B_state gives the possible total energy left
    %B_opt gives the possible operation
    [B, B_opt] = create_B(battery);
    R_state_schedulable = create_state(runtime_schedulable, price);
    [B_state_schedulable, R_state_schedulable] = create_state_B(B, R_state_schedulable);
    
    R_state_nonschedulable = create_state(runtime_nonschedulable, price);
    [B_state_nonschedulable, R_state_nonschedulable] = create_state_B(B, R_state_nonschedulable);
    

    

    %generate the Dynamic table for schedulable appliances which are given from runtime&power.txt
    [Dtable_schedulable, l_avg] = gen_Dtable_schedulable(runtime_schedulable, ... 
        price, power_schedulable, R_state_schedulable, B_state_schedulable, ...
        B_opt, B_init, B_end, B_max, lamda); 
    %[operation_schedulable, power_t_schedulable, battery_t_schedulable] = track_path(Dtable_schedulable, ...
    %    B_state_schedulable, R_state_schedulable, power_schedulable, price, l_avg, lamda);
    
    
    for iter = 1: 10
        %with given 'n' appliances scheduabled table, schedule another 'm'
        %appliances. 
    
        %l_avg = total_power/timeslot

        %for selecting the worst case
        %input: R(given schedule), Dtable (given schedule), power(to be schedule), runtime(to be schedule), price(always same) 
        [solution_nonschedulable_wst, l_t_wst, best_price, pltA ] = gen_Dtable_worstCase(runtime_nonschedulable, ... 
            price, power_nonschedulable, R_state_nonschedulable, B_state_nonschedulable, ...
            B_opt, B_init, B_end, B_max, lamda, Dtable_schedulable, R_state_schedulable, ...
            runtime_schedulable, power_schedulable, l_avg, appnum_schedulable, B_state_schedulable); 
    
    
        %save results
        [row, col] = size(solution_nonschedulable_wst);
        solution_nonschedulable_worstCase(:,:,1) = zeros(row, col);
        solution_nonschedulable_worstCase(:,:,iter+1) = solution_nonschedulable_wst;
        l_t_worstCase(iter) = l_t_wst;
        best_price_schedulable(iter) = best_price;
        
        if iter >1
            if min(min(solution_nonschedulable_worstCase(:,:, iter) - solution_nonschedulable_worstCase(:,:,iter-1)))==0 && max(max(solution_nonschedulable_worstCase(:,:, iter) - solution_nonschedulable_worstCase(:,:,iter-1)))==0
                break;
            end
        end
        %for scheduling the schedulable appliances based on the non-schedulable
        %worst case. 
        [Dtable_schedulable] = gen_Dtable_reschedulable(runtime_schedulable, ... 
            price, power_schedulable, R_state_schedulable, B_state_schedulable, ...
            B_opt, B_init, B_end, B_max, lamda, solution_nonschedulable_worstCase, ...
            power_nonschedulable); 
        
        disp('iter');
        disp(iter);
        disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');
        disp('iter');
        disp(iter);
    end
    %based on the worst case of non-schedulable appliances operation
    %re-schedule the schedulable appliances
    %[Dtable, l_avg] = gen_Dtable(model, runtime, price, power, R_state, B_state, B_opt, B_init, B_end, B_max, lamda); 

    % for plot data (pltA, B_state_schedulable, R_state_schedulable, power_schedulable, price, l_avg, lamda)
   
    toc
end

