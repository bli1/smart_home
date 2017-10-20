function [  ] = pltVar(  )

    figure
    hold on
    box on
    plot(lamda_var(1, :), lamda_var(2, :));
    plot(lamda_var(1, :), lamda_var(7, :));
    xlabel('Power deviation Boundary');
    ylabel('Price (dollar/KWh)');
    hold off

    figure
    hold on
    box on
    plot(lamda_var(1, :), lamda_var(4, :));
    plot(lamda_var(1, :), lamda_var(5, :));
    plot(lamda_var(1, :), lamda_var(6, :));
    plot(lamda_var(1, :), lamda_var(8, :));
    plot(lamda_var(1, :), lamda_var(9, :));
    plot(lamda_var(1, :), lamda_var(9, :));
    
    xlabel('Power deviation Boundary');
    ylabel('??');
    hold off
    
    
end

