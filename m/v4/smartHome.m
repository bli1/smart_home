function [] = smartHome()
%B_state, Dtable
    tic;
    fileid = fopen('price.txt','r');
    formatspec = '%f';
    price = fscanf(fileid, formatspec);
    price = price';

    %%% dimensions of runtime & power must be the same.
    fileid = fopen('runtime.txt','r');
    formatspec = '%f';
    runtime_schedulable = fscanf(fileid, formatspec);
    runtime_schedulable = runtime_schedulable';
    
    fileid = fopen('power.txt','r');
    formatspec = '%f';
    power_schedulable = fscanf(fileid, formatspec);
    power_schedulable = power_schedulable';
    appnum_schedulable = length(power_schedulable);
    
    %non-schedulable appliance input
    fileid = fopen('runtime_nonSchedulable.txt','r');
    formatspec = '%f';
    runtime_nonschedulable = fscanf(fileid, formatspec);
    runtime_nonschedulable = runtime_nonschedulable';
    
    fileid = fopen('power_nonSchedulable.txt','r');
    formatspec = '%f';
    power_nonschedulable = fscanf(fileid, formatspec);
    power_nonschedulable = power_nonschedulable';
    appnum_nonschedulable = length(power_nonschedulable);
    %%%battery 
    %%%(1)=total_max_cap 
    %%%(2)=init_cap
    %%%(3)=end_cap
    %%%(4)=smallest_step
    %%%(5)=largest_step
    fileid = fopen('battery.txt','r');
    formatspec = '%f';
    battery = fscanf(fileid, formatspec);
    
    %% pravicy = lamda value
    fileid = fopen('privacy.txt','r');
    formatspec = '%f';
    lamda = fscanf(fileid, formatspec);
    
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
        [solution_nonschedulable_wst, l_t_wst, best_price] = gen_Dtable_worstCase(runtime_nonschedulable, ... 
            price, power_nonschedulable, R_state_nonschedulable, B_state_nonschedulable, ...
            B_opt, B_init, B_end, B_max, lamda, Dtable_schedulable, R_state_schedulable, ...
            runtime_schedulable, power_schedulable, l_avg, appnum_schedulable, B_state_schedulable); 
    
    
        %save results
        solution_nonschedulable_worstCase(:,:,iter) = solution_nonschedulable_wst;
        l_t_worstCase(iter) = l_t_wst;
        best_price_schedulable(iter) = best_price;
        
    
    
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

    
   
    toc
end

