function [  ] = pltVar( lamda_var, B  )

    figure
    hold on
    box on
    plot(lamda_var(1, :), lamda_var(2, :)*1000, '-o', ...
                'LineWidth',2);
    plot(lamda_var(1, :), lamda_var(7, :)*1000, '-o', ...
                'LineWidth',2);
    xlabel('Power deviation Boundary');
    ylabel('Price (dollar/KWh)');
    legend('ICCAD 16 Price','ICCAD 17 Price')
    ylim([0 8])

    hold off

    figure
    hold on
    box on
    plot(lamda_var(1, :), lamda_var(4, :), '-o', ...
                'LineWidth',2);
    plot(lamda_var(1, :), lamda_var(5, :), '-o', ...
                'LineWidth',2);
    plot(lamda_var(1, :), lamda_var(6, :), '-o', ...
                'LineWidth',2);
    plot(lamda_var(1, :), lamda_var(8, :), '-o', ...
                'LineWidth',2);
    plot(lamda_var(1, :), lamda_var(9, :), '-o', ...
                'LineWidth',2);
    plot(lamda_var(1, :), lamda_var(9, :), '-o', ...
                'LineWidth',2);
    
    xlabel('Power deviation Boundary');
    ylabel('??');
    legend('ICCAD 16 Mean','ICCAD 16 Standard Deviation','ICCAD 16 Max', ...
        'ICCAD 17 Mean','ICCAD 17 Standard Deviation','ICCAD 17 Max')

    hold off
    
    
end

