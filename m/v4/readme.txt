4.0
1. worst case non-schedulable operation will be finished. 
2. worst case non-schedulable prefer to start at the earliest worst slot. 
3. If non-sch cannot be finished in 2 scheduling, ends by the last worst slot. 

Input: [DynamicProgrammingTable, remainingOperationForEachT, bestPrice]=smartHome


Three txt should be in the same file of smartHome.m
	1) price.txt
	number of the price also indicates the timeslot and the e price of that timeslot;
	2) runtime.txt
	3) power.txt

	runtime and power indicate number of appliances. Thus the dimension of them must be the same. 
