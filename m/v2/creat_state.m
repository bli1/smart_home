function [states] = creat_state(runtime, price)

	[szp, timeslot] = size(price);
	[szr, appnum] = size(runtime);
	R(1:runtime(1)+1, 1) = runtime(1):-1:0;
	for i = 2:appnum
		R = add_app_inR(R, i, runtime(i));
    end		
    states = R;
	states(: , appnum+1:timeslot+appnum) = 0;
end

