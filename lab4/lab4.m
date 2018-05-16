clc;clear;close all;
load('lab3.mat');
addpath /site/edu/da/TSTE87/matlab/;
set(0,'DefaultFigureWindowStyle','docked')

 schedule = [
    [4 2 NaN NaN NaN NaN NaN NaN NaN NaN];
    [1 1 1 NaN NaN 0 NaN 0 0 0];
    [2 1 8 NaN NaN 0 NaN 3 0 0];
    [5 1 1 2   0.5 0 NaN 0 2 2];
    [5 2 2 3   0.5 0 NaN 2 2 2];
    [5 3 4 5   0.5 0 NaN 1 2 2];
    [5 4 6 7   0.5 0 NaN 3 2 2];
    [3 1 2 3   4   0 0   0 1 1];
    [3 2 4 5   6   0 0   3 1 1];
    [3 3 7 5   8   0 0   2 1 1]];
 
 
%% Task 1
close all;
mv = extractmemoryvariables(schedule);
printmemoryvariables(mv)
plotmemoryvariables(mv)

[mvlist, iv] = memorypartitioning(mv,1,1,2)

mvi = mvlist{1};
cellassignment = leftedgealgorithm(mvi);
printcellassignment(cellassignment)
plotcellassignment(cellassignment)

peassignment = getpeassignment(schedule)
printpeassignment(peassignment)

% Pipelining => Change exec. time
schedule = updatepetiming(schedule, [2 1],'constmult')

mv = extractmemoryvariables(schedule);
printmemoryvariables(mv)
plotmemoryvariables(mv)

[mvlist, iv] = memorypartitioning(mv,1,1,2)

mv1 = mvlist{1};
mv2 = mvlist{2};
cellassignment1 = leftedgealgorithm(mv1);
printcellassignment(cellassignment1)
plotcellassignment(cellassignment1)

cellassignment2 = leftedgealgorithm(mv2);
printcellassignment(cellassignment2)
plotcellassignment(cellassignment2)


peassignment = getpeassignment(schedule)
printpeassignment(peassignment)

printinterconnection(mv1, peassignment)
printinterconnection(mv2, peassignment)

%% Task 2
%close all;
schedule_pipl = updatetimescale(schedule_final,2);
schedule_pipl = updatepetiming(schedule_pipl, [15 8],'twoport');
schedule_pipl = changestarttime(schedule_pipl, 'out', 4, -1);

schedule_pipl = fliptwoport(schedule_pipl,7); % OK! PE4 (3,1) -> (4,0)
schedule_pipl = fliptwoport(schedule_pipl,5);

mv = extractmemoryvariables(schedule_pipl);


printmemoryvariables(mv)
plotmemoryvariables(mv)

[mvlist, iv] = memorypartitioning(mv,1,1,1)

mv1 = mvlist{1};
mv2 = mvlist{2};
mv3 = mvlist{3};

cellassignment1 = leftedgealgorithm(mv1);
cellassignment2 = leftedgealgorithm(mv2);
cellassignment3 = leftedgealgorithm(mv3);
printcellassignment(cellassignment1)
printcellassignment(cellassignment2)
printcellassignment(cellassignment3)

peassignment_pipl = getpeassignment(schedule_pipl)
printpeassignment(peassignment_pipl)


printinterconnection(mv1, peassignment_pipl)
printinterconnection(mv2, peassignment_pipl)
printinterconnection(mv3, peassignment_pipl)


%% Lab 5
generatetimingcontroller(scheduletime)

