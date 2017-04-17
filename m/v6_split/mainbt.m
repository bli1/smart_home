function [] = mainbt()
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
    Bvar_total(1, :) = [300, 350, 400, 450, 500];
    Bvar_step = zeros(3, 5);
    Bvar_step(1, :) = [250, 255, 260, 265, 270];
    lamda_var = zeros(3, 5);
    lamda_var(1, :) = [80, 85, 90, 95, 100];
    
    
    disp('&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&');
    %1. setting, 2, best price, 3. iter #
    for bt = 1:5
        disp('^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^');
        disp('Battery Total ');
        disp(Bvar_total(1, bt));
        battery(1) = Bvar_total(1, bt);
        [Bvar_total(2, bt), Bvar_total(3, bt)] = smartHome(price, runtime_schedulable', power_schedulable', ...
            runtime_nonschedulable', power_nonschedulable', battery, lamda);
    end
    save('Bvar_total.txt','Bvar_total','-ASCII');


end

