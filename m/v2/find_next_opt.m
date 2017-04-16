function [ next_opt ] = find_next_opt( r, R, starter, appnum, runtime )
    current_state = R(r, :);
    chk = 1;
    running_app = 0;
    next_opt = 0;
    starterTMP = starter;
    for i = 1: appnum
        if current_state(i)< runtime(i)&& current_state(i)~=0
            running_app(chk) = i;
            chk = chk +1;
        end
    end
    lra = length(running_app);
    if running_app == 0
        next_opt = starter;
    else
        for l = 1:lra
            [opt, szs] = size(starterTMP);
            chk = 1;
            rapp = running_app(l);
            for j = 1:opt
                if starterTMP(j, rapp) == 1
                    starterTMP(chk, :) = starterTMP(j, :);
                    chk = chk+1;
                end
            end
            starterTMP = starterTMP(1:chk, :);
        end
        next_opt = starterTMP;
    end

end

