function [ mcmTest ] = mcm( solution, privacy, l_avg, test )
    power_non_range = [1, 30];
    zone = [1, 6];
    index = 1000*test;
    
    
    mcmTest = zeros(1, index);
    for i = 1 : index
        t = randi(zone);
        power_non = randi(power_non_range);
        
        mcmTest(i) = abs(solution(t)+power_non-l_avg)-privacy;
        if mcmTest(i) < 0 
            mcmTest(i) = 0;
        end
    end
    

    
end

