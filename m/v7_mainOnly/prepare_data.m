function [ runtime_schedulable, power_schedulable, runtime_nonschedulable, ...
        power_nonschedulable, price ] = prepare_data(price)
    %shrink timeslot
    timeslot = length(price);
    p = zeros(1, timeslot/2);
    for i = 1:0.5*timeslot
        p(i) = 0.5*(price(i*2)+price(i*2-1))/1000;
        
    end
    price = p;
    %load data
    a1 = csvread('1.csv');
    a2 = csvread('2.csv');
    a3 = csvread('3.csv');
    a4 = csvread('4.csv');
    a5 = csvread('5.csv');
    
    start_point = 1;

    
    app(:,1) = a1(start_point:end);
    app(:,2) = a2(start_point:end);
    app(:,3) = a3(start_point:end);
    app(:,4) = a4(start_point:end);
    app(:,5) = a5(start_point:end);
    apptotal = app(:,1) + app(:,2) + app(:,3) + app(:,4) + app(:,5);
    figure;
    subplot(3,2,1)
    plot(1:length(app(:,1)), app(:,1));
    title('Appliance1')
    subplot(3,2,2)
    plot(1:length(app(:,2)), app(:,2));
    title('Appliance2')
    subplot(3,2,3)
    plot(1:length(app(:,3)), app(:,3));
    title('Appliance3')
    subplot(3,2,4)
    plot(1:length(app(:,4)), app(:,4));
    title('Appliance4')
    subplot(3,2,5)
    plot(1:length(app(:,5)), app(:,5));
    title('Appliance5')
    subplot(3,2,6)
    plot(1:length(apptotal), apptotal);
    title('Total')
    
    c = zeros(5, 1);
    a = zeros(5, 1);
    
    for j = 1:5
        for i = 1:length(app(:,1))
            if app(i, j)>10
                c(j)=c(j)+1;
                a(j)=a(j)+app(i, j);
            end
        end
    end
    
    runtime=zeros(5, 1);
    power=zeros(5, 1);
    for j = 1:5
        runtime(j) =ceil( c(j)/7200);
        power(j) = (a(j)/runtime(j))/3600;
    end
    
    runtime_nonschedulable = runtime(1:2);
    runtime_schedulable = runtime(3:5);
    power_nonschedulable = power(1:2);
    power_schedulable = power(3:5);
    
end

