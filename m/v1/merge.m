function [statetmp] = merge(statei, states, i)
	if (i == 1)
		statetmp = statei;
	else
		[opts, szs] = size(states);
		szs = opts;
		[opti, szi] = size(statei);

        for m = 1:szs
            for t = 1:opti
                if(statei(t, szi) == states(m, szi))
			opts = opts+1;
			states(opts, 1:szi) = zeros;
			states(opts, 1:i-1) = states(m, 1:i-1);
                    	states(opts, szi) = statei(t, szi);
			states(opts, i) = statei(t, i);
                end
            end
        end
        statetmp = states(szs+1:end, :);
	end



end
