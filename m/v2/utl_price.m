function [ut] = utl_price(power, price, start, t)
    ut = power * start'*price(t);

end