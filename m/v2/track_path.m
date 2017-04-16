function [path, ult] = track_path(Dtable, states, appnum)
    
    [opt, timeslot, tmp] = size(Dtable);
    
    ult = Dtable (end, end, 2);
    remain = zeros(appnum, timeslot);
    
    for t = 1: timeslot
        remain(1: appnum, timeslot+1-t) = states(opt, 1:appnum);
        opt = Dtable (opt, timeslot+1-t, 3);
    end
    
    path = remain;


end

