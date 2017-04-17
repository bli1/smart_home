function [Dynp] = gen_Dtable_reschedulable(runtime, price, power, ...
    R_state, B_state, B_opt, B_init, B_end, B_max, lamda, ...
    solution_nonschedulable_worstCase, power_nonschedulable)

    [szr, appnum] = size(runtime);
    Dynp(:,:,1) = R_state (:, appnum+1:end);        %%operations
    Dynp(:,:,2) = R_state (:, appnum+1:end);    %%for price
    Dynp(:,:,3) = R_state (:, appnum+1:end);     %%for position y
    R (:, 1:appnum) = R_state(:, 1:appnum);                %%remaining operation states
    t = 1;
    %for 2 appliance stater
    % generate [0, 0; 0, 1; 1, 0; 1, 1]
    timeslot = length(price);
    [remain, szr] = size(R);
    starter = ones(1, appnum);
    starter = create_state(starter, 0);
    starter = starter(:, 1:end-1);
    B_length = length(B_state);
    
    %find the starting point fitting the initial condition 
    for i = 1:B_length
        %% if B_state(i) == B_init && R(i, :) == runtime
        %% Operands to the || and && operators must be convertible to logical 
        %% scalar values.
        if B_state(i) == B_init
            chk = R(i, :) - runtime;
            if max(chk) == 0 && min(chk) == 0
                y = i;
            end 
        end
    end
    % set the 1st possible operation [B_init, runtime(:)]
    % y represent the initial position y coodinate, x = t. 
    % z(1) = 1, 
    % z(2) = 0 ult_t     
    % z(3) =y  current position
    if t == 1
        Dynp(y,1,1) = 1;
        Dynp(y,1,2) = 0;
        Dynp(y,1,3) = y;
    end
    
    
    %model = 1 for the schedulable appliances operation. 

    for t = 1 : timeslot-1
        disp('timeslot');
        disp(t);
        for r = 1: remain
            if Dynp(r, t, 1) == 1
                %next_opt only consider the running app has to run in the
                %next timeslot
                next_opt = find_next_opt(r, R, starter, appnum, runtime);
                %next_B_opt consider the total Battery capacity and 
                % max&min charging/discharging rate
                next_B_opt = find_next_B_opt(r, B_max, B_opt, B_state);
                length_next_B_opt = length(next_B_opt);
                for b = 1:length_next_B_opt
                    %%%%  battery energy equals to
                    %%%% next_B_opt(b)+B_state(r)
                    [Dynp(: , t+1, :)] = next_state_reschedule(Dynp(:, t, :), ...
                        Dynp(:, t+1, :), runtime, price, power, next_opt, R, ...
                        r, b, t, timeslot, next_B_opt, B_state, lamda, B_init, ...
                        B_end, solution_nonschedulable_worstCase, power_nonschedulable);
                end
            end
        end
    end
end