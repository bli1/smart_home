function [pltA, B_state_schedulable, R_state_schedulable, power_schedulable, price, l_avg, lamda, app, best_price, iter, full_power_t, full_power_t_IC16] = main(  )
    
    fileid = fopen('price.txt','r');
    formatspec = '%f';
    price = fscanf(fileid, formatspec);
    price = price';

    %shrink timeslot
    timeslot = length(price);
    p = zeros(1, timeslot/2);
    for i = 1:0.5*timeslot
        p(i) = 0.5*(price(i*2)+price(i*2-1))/1000;
        
    end
    price = p;

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
    
    [best_price_IC16, iter_IC16, pltA_IC16, B_state_schedulable_IC16, R_state_schedulable_IC16, ...
        power_schedulable_IC16, l_avg_IC16, full_power_t_wst_list_IC16, best_price_schedulable_IC16, full_power_t_IC16] = smartHome_IC16(price, runtime_schedulable, power_schedulable, ...
        runtime_nonschedulable, power_nonschedulable, battery, lamda);


disp('OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    fileid = fopen('price.txt','r');
    formatspec = '%f';
    price = fscanf(fileid, formatspec);
    price = price';
    
    %shrink timeslot
    timeslot = length(price);
    p = zeros(1, timeslot/2);
    for i = 1:0.5*timeslot
        p(i) = 0.5*(price(i*2)+price(i*2-1))/1000;
        
    end
    price = p;

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
    
    [best_price, iter, pltA, B_state_schedulable, R_state_schedulable, ...
        power_schedulable, l_avg, full_power_t_wst_list, best_price_schedulable, full_power_t] = smartHome(price, runtime_schedulable, power_schedulable, ...
        runtime_nonschedulable, power_nonschedulable, battery, lamda);
    
    timeslot = length(price);
    
    app = zeros(appnum_schedulable,timeslot*7200);
    
    save('full_power_t.mat','full_power_t');
    save('full_power_t_IC16.mat','full_power_t_IC16');
    save('a.mat', 'pltA');
    save('b.mat', 'B_state_schedulable');
    save('c.mat', 'R_state_schedulable');
    save('d.mat', 'power_schedulable');
    save('e.mat', 'price');
    save('f.mat', 'l_avg');
    save('g.mat', 'lamda');
    save('h.mat', 'app');
    save('i.mat', 'best_price');
    save('j.mat', 'iter');
    save('k.mat','full_power_t_wst_list');
    save('m.mat','best_price_schedulable');

    
    
end

