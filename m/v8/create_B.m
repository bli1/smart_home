function [B_state, B_opt] = create_B(battery)

    B_max = battery(1);
    min_charge = battery(4);
    max_charge = battery(5);
    %B_opt gives battery charge/discharge operation options for timeslot t.
    B_opt = -max_charge:min_charge:max_charge;
    %B_state gives total battery energy at timeslot t
    B_state = 0:min_charge:B_max;


end

