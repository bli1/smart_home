function [R] = add_app_inR(R, i, runtime)
	Rtmp = R;
	[opt, szr] = size(R);
	for l = 1:runtime+1
		R((l-1)*opt+1:l*opt, i) = runtime-l+1; 
		R((l-1)*opt+1:l*opt, 1:i-1) = Rtmp;
    end
end

