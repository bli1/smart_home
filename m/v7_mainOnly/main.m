function [pltA, B_state_schedulable, R_state_schedulable, power_schedulable, price, l_avg, lamda, app, best_price, iter] = main(  )
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
        power_nonschedulable, price, app] = prepare_data(price);
    
    [best_price, iter, pltA, B_state_schedulable, R_state_schedulable, ...
        power_schedulable, l_avg] = smartHome(price, runtime_schedulable', power_schedulable', ...
        runtime_nonschedulable', power_nonschedulable', battery, lamda);

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
    
end

