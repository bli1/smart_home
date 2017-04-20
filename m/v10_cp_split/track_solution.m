function [solution] = track_solution(r, Dtable_schedulable)

    [remaining_operation, timeslot ] = size(Dtable_schedulable(:,:,1));
    solution = zeros(remaining_operation, timeslot);
        
    if sum(Dtable_schedulable(:, end, 1)) == 0;
        disp('NO SOLUTION.');

    else
        for t = 1: timeslot
            solution(r, timeslot-t+1) = 1;
            % 'r' track back the solution position
            r = Dtable_schedulable(r, timeslot-t+1, 3);
        end
    end
end
