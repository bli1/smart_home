function [Dtable, path, ult] = smartHome()

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
    
    appnum = length(runtime);
       
    states = creat_state(runtime, price);
    Dtable = gen_Dtable(runtime, price, power, states); 
    [path, ult] = track_path(Dtable, states, appnum);

       
    
    
    
   

end

