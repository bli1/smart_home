function [R_state] = create_state(runtime, price)
    %timeslot gives the total length of time ; appnum euqals to total
    %number of appliances; B_length gives the number of possible battery
    %state
	timeslot = length(price);
	appnum = length(runtime);
    
    % insert first appliance in R
	R(1:runtime(1)+1, 1) = runtime(1):-1:0;
    % insert rest appliances in R
    for i = 2:appnum
		R = add_app_inR(R, i, runtime(i));
    end	
    R_state = R;
	R_state(: , appnum+1:timeslot+appnum) = 0;
end

