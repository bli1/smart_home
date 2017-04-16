function [operations, billingPrice] = solution(operations, states, timeslot, runtime, power, price, appnum, t)

    sz = size(states);
    tempop = zeros(appnum, timeslot);
    for i = 1:appnum
        l = states(1, i);
        for j = 1:runtime(i)
            tempop(i, l:(j+l-1)) = 1;
        end
    end
    totalpower = power*tempop;
    ref=totalpower*price';

    for s = 1 : sz(1)
        if states(s, end) == t
            for i = 1:appnum
                l = states(s, i);
                for j = 1:runtime(i)
                        tempop(i, l:(j+l-1)) = 1;
                end
            end
            totalpower = power*tempop;
            billingPrice = totalpower*price';
            if billingPrice <= ref
                ref = billingPrice;
                operations(:, :, t) = tempop;
            end
        end
        tempop = zeros(appnum, timeslot);

    end
    
    
end