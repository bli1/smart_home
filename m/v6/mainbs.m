function [] = mainbs()
    fileid = fopen('price.txt','r');
    formatspec = '%f';
    price = fscanf(fileid, formatspec);
    price = price';


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
    
    [runtime_schedulable, power_schedulable, runtime_nonschedulable, ...
        power_nonschedulable, price] = prepare_data(price);
    
    battery(4) = 25;
    Bvar_total = zeros(3, 5);
    Bvar_total(1, :) = [650, 700, 750, 800, 850];
    Bvar_step = zeros(3, 5);
    Bvar_step(1, :) = [150, 175, 200, 225, 250];
    lamda_var = zeros(3, 5);
    lamda_var(1, :) = [80, 85, 90, 95, 100];
    
    for bs = 1:length(Bvar_step)
        disp('$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$');
        disp('Battery Step ');
        disp(Bvar_step(1, bs));
        battery(5) = Bvar_step(1, bs);
        [Bvar_step(2, bs), Bvar_step(3, bs)] = smartHome(price, runtime_schedulable', power_schedulable', ...
            runtime_nonschedulable', power_nonschedulable', battery, lamda);
    end
    save('Bvar_step.txt','Bvar_step','-ASCII');
    
end

