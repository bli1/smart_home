function [] = main(  )
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
    
    [best_price, iter] = smartHome(price, runtime_schedulable', power_schedulable', ...
        runtime_nonschedulable', power_nonschedulable', battery, lamda);
    

    
    

end

