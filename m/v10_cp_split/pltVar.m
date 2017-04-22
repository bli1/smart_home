function [  ] = pltVar(  )
    bt= [9.0000000e+01,   1.0000000e+02,   1.1000000e+02,   1.2000000e+02,   1.3000000e+02];
    bt_price = [7.5871000e-03,   7.5871000e-03,   7.5871000e-03,   7.5871000e-03,   7.5871000e-03];
    bs = [3.0000000e+01,   3.5000000e+01,   4.0000000e+01,   4.5000000e+01,   5.0000000e+01];
    bs_price = [7.5871000e-03,   7.5859000e-03,   7.5722500e-03,   7.5651250e-03,   7.5580000e-03];
    lambda = [2.0000000e+01,   2.5000000e+01,   3.0000000e+01,   3.5000000e+01,   4.0000000e+01];
    lambda_price = [7.5871000e-03,   7.3658250e-03,   7.1950000e-03,   7.0633250e-03,   6.9316500e-03];
   
    figure
    hold on
    plot(bt, bt_price);
    xlabel('Battery Total Capacity');
    ylabel('Price');
    hold off

    figure
    hold on
    plot(bs, bs_price);
    xlabel('Charging / Discharging Rate');
    ylabel('Price');
    hold off
    
    figure
    hold on
    plot(lambda, lambda_price);
    xlabel('Privacy');
    ylabel('Price');
    hold off
    
end

