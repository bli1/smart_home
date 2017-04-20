function [ ] = orgVSsch(Dtable, B_state, ...
    R_state, power, price, l_avg, lamda, app, best_price, iter)
    appnum = length(power);
    timeslot = length(price);
    opt = length(B_state);
    path_end = 0;
    chk=1;
    for s = 1: opt
        if Dtable(s, timeslot, 1) == 1
            path_end(chk) = s;
            chk = chk+1;
        end
    end
    
    c = zeros(3, 1);
    a = zeros(3, 1);
    
    for j = 1:3
        for i = 1:length(app(:,1))
            if app(i, j)>10
                c(j)=c(j)+1;
                a(j)=a(j)+app(i, j);
            end
        end
    end
    apptotal =  app(:,3) + app(:,4) + app(:,5);
    orgPrice = 0;
    for index = 1:length(apptotal)
        orgPrice = orgPrice + price(ceil(index/7200))*apptotal(index)/3600;
    end
    disp('Original Price');
    disp(orgPrice);
    
    path_num = length(path_end);
    state_opt = zeros (timeslot, appnum, path_num);
    battery_t = zeros (timeslot, path_num);
    battery = zeros (timeslot, path_num);

    operation = zeros (timeslot, appnum, path_num);
    power_t = zeros (timeslot, path_num);
    slot = timeslot-1;
    
    for p = 1: path_num
        for t = 1:slot

            state_index = path_end(p);
            state_opt(timeslot - t + 1, : , p) = R_state(state_index, 1:appnum ); 
            battery(timeslot - t + 1, p) = B_state (state_index);
            path_end(p) = Dtable(state_index, timeslot - t+1, 3);
            operation (timeslot - t, : , p) = R_state(path_end(p), 1:appnum)-R_state(state_index, 1:appnum);
            battery_t(timeslot-t, p) = B_state(path_end(p))-B_state(state_index);
            power_t (timeslot - t , p) = operation(timeslot - t, :, p) * power' - battery_t(timeslot - t , p);
            
        end
        
        schPrice = zeros(appnum, 12);

        x = zeros(1, 24);
        opplt = zeros(appnum, 24);
        figure;
        for i = 1:appnum
            for t = 1: 12
                x(2*t-1) = t;
                x(2*t) = t+1-1/7200;
                opplt(i, 2*t) = operation(t, i, p);
                opplt(i, 2*t-1) = operation(t, i, p);              
            end
        end
        hold on
        subplot(3,1,1)
        plot(x, opplt(1, :), ...
                'LineWidth',2)
        ylabel( 'Appliance1')
        subplot(3,1,2)
        plot(x, opplt(2, :), ...
                'LineWidth',2)
        ylabel( 'Appliance2')
        subplot(3,1,3)
        plot(x, opplt(3, :), ...
                'LineWidth',2)
        %ylim([0 5])
        ylabel( 'Appliance3')
        xlabel( 'Hours (h)')
        hold off

        %power
        figure;
        hold on
        plot(1:timeslot, power_t(:, p)/1000, ...
                'LineWidth',2)
        l_average(1:timeslot) = l_avg;
        upper = l_average(:)+lamda;
        lower = l_average(:)-lamda;
        %plot(1:timeslot, l_average, ':')
        plot(1:timeslot, upper/1000, ':', 'LineWidth',2)
        plot(1:timeslot, lower/1000, ':', 'LineWidth',2)
        plot(1/7200:1/7200:length(apptotal)/7200, apptotal*2/1000, ...
                'LineWidth',2);
        xlabel( 'Hours (h)')
        ylabel('Power Consumption (kw)')
        legend('Scheduled','Upper boundary','Lower boundary','Original')
        hold off
        
        %battery
        figure;
        hold on
        plot(1:timeslot, battery_t(:, p)/1000, ...
                'LineWidth',2);
        xlabel( 'Hours (h)')
        ylabel('Battery Charging-/Discharging+ (kw)')
        ylim([-0.3 0.3])
        xlim([0 13])
        hold off
        
    end

    schePrice = price * power_t;
    disp('scheduled Price');
    disp(schePrice);
    figure;
    hold on
    plot(1:12, price*1000,'b--o');
    xlabel('Hours (h)')
    ylabel('Real Time Electricity Price ($/kwh)')
    hold off
end

