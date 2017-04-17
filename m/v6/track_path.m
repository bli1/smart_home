function [operation, power_t, battery_t] = track_path(Dtable, B_state, R_state, power, price, l_avg, lamda)
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

        %figure;
        %subplot(3,1,1)
        %for i = 1:appnum
        %    plot(1:timeslot, operation(:, i, p)+ i)
        %    hold on
        %end
        %hold off
        %title('operation')
        
        %subplot(3, 1, 2)
        %plot(1:timeslot, power_t(:, p))
        %hold on
        %l_average(1:timeslot) = l_avg;
        %upper = l_average(:)+lamda;
        %lower = l_average(:)-lamda;
        %plot(1:timeslot, l_average)
        %plot(1:timeslot, upper, ':')
        %plot(1:timeslot, lower, ':')
        %hold off
        %title('power consumption')
        
        %subplot(3, 1, 3)
        %plot(1:timeslot, battery_t(:, p))
        %title('battery operation (charge/discharge)')
        
    end
    



end

