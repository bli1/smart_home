function [best_price, iter, pltA, B_state_schedulable, R_state_schedulable, ...
    power_schedulable, l_avg, solution_nonschedulable_wst, best_price_schedulable, ...
    full_power_t] = smartHome_IC16(price, runtime_schedulable, power_schedulable, ...
        runtime_nonschedulable, power_nonschedulable, battery, lamda)
    
    % for plot data (pltA, B_state_schedulable, R_state_schedulable, power_schedulable, price, l_avg, lamda)
%B_state, Dtable
    tic;
    
    appnum_schedulable = length(power_schedulable);
    
    %%%battery 
    %%%(1)=total_max_cap 
    %%%(2)=init_cap
    %%%(3)=end_cap
    %%%(4)=smallest_step
    %%%(5)=largest_step
    
    B_max = battery(1);
    disp('*: Battery total capacity:');
    disp(B_max);
    
    B_init = battery(2);
    disp('*: Battery initial energy:');
    disp(B_init);
    
    B_end = battery(3);
    
    disp('*: Min Charging rate:');
    disp(battery(4));
    
    disp('*: Max Charging rate');
    disp(battery(5));
    
    %B_state gives the total energy left
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
    
    

        %with given 'n' appliances scheduabled table, schedule another 'm'
        %appliances. 
    
        %l_avg = total_power/timeslot

        %for selecting the worst case
        %input: R(given schedule), Dtable (given schedule), power(to be schedule), runtime(to be schedule), price(always same) 
    [solution_nonschedulable_wst, full_power_t, best_price, pltA] = gen_Dtable_worstCase(runtime_nonschedulable, ... 
        price, power_nonschedulable, R_state_nonschedulable, B_state_nonschedulable, ...
        B_opt, B_init, B_end, B_max, lamda, Dtable_schedulable, R_state_schedulable, ...
        runtime_schedulable, power_schedulable, l_avg, appnum_schedulable, B_state_schedulable); 
    
    
      best_price_schedulable = 0;
      iter = 0;

    %based on the worst case of non-schedulable appliances operation
    %re-schedule the schedulable appliances
    %[Dtable, l_avg] = gen_Dtable(model, runtime, price, power, R_state, B_state, B_opt, B_init, B_end, B_max, lamda); 

    % for plot data (pltA, B_state_schedulable, R_state_schedulable, power_schedulable, price, l_avg, lamda)
   
    toc
end

