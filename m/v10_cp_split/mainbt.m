function [] = mainbt()
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
    
<<<<<<< HEAD
    Bvar_total = zeros(11, 5);
    Bvar_total(1, :) = [30, 45, 60, 75, 90];
    Bvar_step = zeros(11, 5);
=======
    [runtime_schedulable, power_schedulable, runtime_nonschedulable, ...
        power_nonschedulable, price] = prepare_data(price);
    
    Bvar_total = zeros(3, 5);
    Bvar_total(1, :) = [30, 35, 40, 45, 55];
    Bvar_step = zeros(3, 5);
>>>>>>> 9748794dc25d42378b4a69d22e4408afb7a1ce16
    Bvar_step(1, :) = [30, 35, 40, 45, 50];
    lamda_var = zeros(11, 5);
    lamda_var(1, :) = [20, 25, 30, 35, 40];

    for bt = 1:5
	disp('^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^');
	disp('Battery Total');
	disp(Bvar_total(1, bt));

    	[Bvar_total(2, bt), Bvar_total(3, bt), pltA, B_state_schedulable, R_state_schedulable, ...
        	power_schedulable, l_avg, full_power_t_wst_list, best_price_schedulable, ...
		full_power_t] = smartHome(price, runtime_schedulable, power_schedulable, ...
        	runtime_nonschedulable, power_nonschedulable, battery, lamda);
	Bvar_total(4, bt) = mean(mcm(full_power_t, lamda, l_avg, 100));
	Bvar_total(5, bt) = std(mcm(full_power_t, lamda, l_avg, 100));
	Bvar_total(6, bt) = max(mcm(full_power_t, lamda, l_avg, 100));

    end
    
    disp('&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&');
    %1. setting, 2, best price, 3. iter #
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
    
    for bt = 1:5
	disp('^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^');
	disp('Battery Total');
	disp(Bvar_total(1, bt));
    	[Bvar_total(7, bt), Bvar_total(8, bt), pltA, B_state_schedulable, R_state_schedulable, ...
        	power_schedulable, l_avg, full_power_t_wst_list, best_price_schedulable, ...
		full_power_t] = smartHome(price, runtime_schedulable, power_schedulable, ...
        	runtime_nonschedulable, power_nonschedulable, battery, lamda);
	Bvar_total(9, bt) = mean(mcm(full_power_t, lamda, l_avg, 100));
	Bvar_total(10, bt) = std(mcm(full_power_t, lamda, l_avg, 100));
	Bvar_total(11, bt) = max(mcm(full_power_t, lamda, l_avg, 100));


    end

    save('Bvar_total.mat','Bvar_total');


end

