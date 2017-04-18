function [ut] = utl_price(l_t, price, t)
    ut = l_t*price(t);
    if ut < 0 
	ut = 0;
    end
end
