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
    runtime = fscanf(fileid, formatspec);
    runtime = runtime';
    
    fileid = fopen('power.txt','r');
    formatspec = '%f';
    power = fscanf(fileid, formatspec);
    power = power';
    
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
    %B_opt gives the possible
    [B, B_opt] = creat_B(battery);
    R_state = creat_state(runtime, price);
    [B_state, R_state] = creat_state_B(B, R_state);
    %generate the Dynamic table for schedulable appliances which are given from runtime&power.txt
      [Dtable, l_avg] = gen_Dtable(runtime, price, power, R_state, B_state, B_opt, B_init, B_end, B_max, lamda); 
    [operation, power_t, battery_t] = track_path(Dtable, B_state, R_state, power, price, l_avg, lamda);

       
    
    
    
   
    toc
end

