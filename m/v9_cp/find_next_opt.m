function [ next_opt ] = find_next_opt( r, R, starter, appnum, runtime)
    current_state = R(r, :);
    chkra = 1;
    chkfa = 1;
    running_app = 0;
    finished_app = 0;
    counter = 1;
    next_opt = zeros(1, appnum);
    [opt, sza]= size(starter);
    flag = ones(opt, 1);
    %% checking running appliance and save them in running_app
    for i = 1: appnum
        if current_state(i)< runtime(i)&& current_state(i)~=0
            running_app(chkra) = i;
            chkra = chkra +1;
        elseif current_state(i)==0
            finished_app(chkfa) = i;
            chkfa = chkfa +1;
        end
    end
    %% number of running&finished appliances
    ra_num = length(running_app);
    fa_num = length(finished_app);
    
    %starter saved all possible operation in the next timeslot;
    %delete the operation conflict with running app and finished app. 
    %check all, if conflict, mark the flag in the row. 
    
    for p = 1:opt
        %check each app, if conflict with running app, mark flag as '0'
        if running_app ~=0
            for i = 1:ra_num
                if starter(p, running_app(i)) == 0;
                    flag(p) = 0;
                end
            end
        end
        %check each app, if conflict with finished app, mark flag as '0'
        if finished_app ~=0
            for i = 1:fa_num
                if starter(p, finished_app(i)) == 1;
                    flag(p) = 0;
                end
            end
        end
        %if the flag is '1', save it into the next_option list. 
        if flag(p) == 1
            next_opt(counter, :) = starter (p, :);
            counter = counter +1;
        end
    end
end

