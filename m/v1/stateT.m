function [ states ] = stateT(state, runtime, timeslot, start, appnum)
    i=1;
    states = state;
    while (i< appnum+1)
	opt=1;
	statei = state;
        for t = 1:timeslot
            if (t > max(runtime)+max(start)-1)
                for s = start(i):t-runtime(i)
                    statei(opt, i) = s;
                    statei(opt, end) = t; 
                    opt = opt+1;
                end
            end
        end
	states=merge(statei, states, i);
	i = i+1;
    end
end



