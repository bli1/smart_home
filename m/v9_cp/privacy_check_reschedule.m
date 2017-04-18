function [ safe, power_total ] = privacy_check_reschedule( t, privacy_chk, lamda, solution_nonschedulable_worstCase, ...
                        power_nonschedulable )
    [szr, szc, iter] = size(solution_nonschedulable_worstCase);
    safe = 1;
    
    for i = 1:iter
        power_total = privacy_chk + solution_nonschedulable_worstCase(:, t, i)'*power_nonschedulable';
        if power_total < -lamda || power_total > lamda
            safe = 0;
        end
    end
end

