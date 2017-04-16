function [solop, billingPrice] = smartHome(t)

    fileid = fopen('price.txt','r');
    formatspec = '%f';
    price = fscanf(fileid, formatspec);
    price = price';
%%% dimensions of runtime & power must be the same.
    fileid = fopen('runtime.txt','r');
    formatspec = '%f';
    runtime = fscanf(fileid, formatspec);
    runtime = runtime';
    
    fileid = fopen('power.txt','r');
    formatspec = '%f';
    power = fscanf(fileid, formatspec);
    power = power';
    
    l_avg = 2;
    lamda = 0.2;
    z_min = -1;
    z_max = 1;
    w = 0;


    BatteryTotal = [0:5];
    BatteryCharge = [-1, 0 , 1];
    
    [szp, timeslot] = size(price);
    [szr, appnum] = size(runtime);
    start = ones(appnum);
    operations = zeros(appnum, timeslot , timeslot);
    states = zeros(1, appnum+1);
    X=zeros(appnum, timeslot);
    R=zeros(appnum, timeslot);
    
    states = stateT (states, runtime, timeslot, start, appnum);

    [operations, billingPrice] = solution(operations, states, timeslot, runtime, power, price, appnum, t);
    solop = operations(:, :, t);
%    for i = states(1,szs(2)) : states(szs(1),szs(2))
%        operation(i, start(i):start(i)+runtime(i)-1, t)=1;
%    end
        
    
%%%%
%   syms z;
%    S = solve(power*X(: , 1)+w-l_avg-z<=lamda, p*X(: , 1)+w-l_avg+z>=-lamda, z>=z_min, z<=z_max, [z], 'ReturnConditions', true );
%    conditions = S.conditions; 
    
%    V = [X; Z];
%%%%
    

end

