function [Bvar_total, Bvar_step, lamda_var] = mainlm(  )
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
    
    
    Bvar_total = zeros(3, 5);
    Bvar_total(1, :) = [650, 700, 750, 800, 850];
    Bvar_step = zeros(3, 5);
    Bvar_step(1, :) = [250, 255, 260, 265, 270];
    lamda_var = zeros(3, 5);
    lamda_var(1, :) = [80, 85, 90, 95, 100];
    
    for ld = 1:5
        disp('#############################################################');
        disp('Lambda');
        disp(lamda_var(1, ld));
        lamda = lamda_var(1, ld);
        [lamda_var(2, ld), lamda_var(3, ld)] = smartHome(price, runtime_schedulable', power_schedulable', ...
            runtime_nonschedulable', power_nonschedulable', battery, lamda);
    end
    save('lamda_var.txt','lamda_var','-ASCII');

end

