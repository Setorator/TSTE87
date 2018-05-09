clc;clear;close all;
load('lab2.mat','sfg_cas');
addpath /site/edu/da/TSTE87/matlab/;
set(0,'DefaultFigureWindowStyle','docked')

close all;

%% PART 1

sfg=addoperand([],'in',1,1);
sfg=addoperand(sfg,'constmult',1,1,2,0.25);
sfg=addoperand(sfg,'constmult',2,4,5,0.75);
sfg=addoperand(sfg,'add',1,[2 1],6);
sfg=addoperand(sfg,'add',2,[2 5],3);
sfg=addoperand(sfg,'add',3,[6 4],7);
sfg=addoperand(sfg,'delay',1,3,4);
sfg=addoperand(sfg,'out',1,7);

plotprecedence(sfg);

timinginfo = getdefaulttiminginfo;
timinginfo.constmult.latency = 2;
timinginfo.constmult.executiontime = 2;
timinginfo.add.latency = 2;
timinginfo.add.executiontime = 2;

schedule = getinitialschedule(sfg, timinginfo);%, scheduletime)
%schedule

%printschedule(schedule);
plotschedule(schedule);

%printstarttimes(schedule)

schedule = changestarttime(schedule, 'out', 1, 6);
schedule = changestarttime(schedule, 'add', 3, 2);
schedule = changestarttime(schedule, 'add', 1, 2);
schedule = changestarttime(schedule, 'constmult', 2, -2);
plotschedule(schedule);
% printstarttimes(schedule)

%% PART 2 INITIAL

timinginfo = getdefaulttiminginfo;
timinginfo.twoport.latency = 2;
timinginfo.twoport.executiontime = 1;
scheduletime = 6;

schedule = getinitialschedule(sfg_cas, timinginfo, scheduletime);
plotschedule(schedule);
%printstarttimes(schedule)

%% PART 2 reschedule

schedule2 = changestarttime(schedule, 'out', 1, 12);
schedule2 = changestarttime(schedule2, 'out', 2, 12);
schedule2 = changestarttime(schedule2, 'out', 3, 12);
schedule2 = changestarttime(schedule2, 'out', 4, 12);
schedule2 = changestarttime(schedule2, 'twoport', 3, -1);
schedule2 = changestarttime(schedule2, 'twoport', 5, -1);
schedule2 = changestarttime(schedule2, 'twoport', 7, 1);
schedule2 = changestarttime(schedule2, 'twoport', 12, -1);
schedule2 = changestarttime(schedule2, 'twoport', 14, -1);
schedule2 = changestarttime(schedule2, 'twoport', 2, 1);
schedule2 = changestarttime(schedule2, 'twoport', 4, -1);
schedule2 = changestarttime(schedule2, 'twoport', 9, 1);
schedule2 = changestarttime(schedule2, 'twoport', 11, 1);
schedule2 = changestarttime(schedule2, 'twoport', 13, -1);


plotschedule(schedule2);


%% PART 2 resolution

schedule3 = updatetimescale(schedule, 4);
schedule2 = changestarttime(schedule, 'out', 1, 48);
schedule2 = changestarttime(schedule2, 'out', 2, 48);
schedule2 = changestarttime(schedule2, 'out', 3, 48);
schedule2 = changestarttime(schedule2, 'out', 4, 48);

schedule3 = changestarttime(schedule3, 'twoport', 3, -1);
schedule3 = changestarttime(schedule3, 'twoport', 5, -2);
schedule3 = changestarttime(schedule3, 'twoport', 7, 2);
schedule3 = changestarttime(schedule3, 'twoport', 12, -3);
schedule3 = changestarttime(schedule3, 'twoport', 14, -4);
schedule3 = changestarttime(schedule3, 'twoport', 17, -5);

schedule3 = changestarttime(schedule3, 'twoport', 2, 1);
schedule3 = changestarttime(schedule3, 'twoport', 4, -1);
schedule3 = changestarttime(schedule3, 'twoport', 9, 2);
schedule3 = changestarttime(schedule3, 'twoport', 11, 3);
schedule3 = changestarttime(schedule3, 'twoport', 13, -2);
schedule3 = changestarttime(schedule3, 'twoport', 15, -4);
schedule3 = changestarttime(schedule3, 'twoport', 16, -3);
schedule3 = changestarttime(schedule3, 'twoport', 22, -5);

schedule3 = changestarttime(schedule3, 'twoport', 1, 1);

schedule3 = changestarttime(schedule3, 'twoport', 6, -1);
schedule3 = changestarttime(schedule3, 'twoport', 18, -2);
schedule3 = changestarttime(schedule3, 'twoport', 21, -3);

schedule3 = changestarttime(schedule3, 'twoport', 3, -2);
schedule3 = changestarttime(schedule3, 'twoport', 5, -2);
schedule3 = changestarttime(schedule3, 'twoport', 12, -2);
schedule3 = changestarttime(schedule3, 'twoport', 14, -2);
schedule3 = changestarttime(schedule3, 'twoport', 17, -2);
schedule3 = changestarttime(schedule3, 'twoport', 8, -1);

%schedule2 = changestarttime(schedule2, 'twoport', 17, -1);


plotschedule(schedule3);
printstarttimes(schedule3)

schedule4 = updatetimescale(schedule, 4);
schedule4 = changestarttime(schedule4, 'twoport', 11, 7);
schedule4 = changestarttime(schedule4, 'twoport', 9, 15);
schedule4 = changestarttime(schedule4, 'twoport', 8, 14);
schedule4 = changestarttime(schedule4, 'twoport', 7, 7);
schedule4 = changestarttime(schedule4, 'twoport', 3, -7);
schedule4 = changestarttime(schedule4, 'twoport', 5, -6);
schedule4 = changestarttime(schedule4, 'twoport', 21, 6);
schedule4 = changestarttime(schedule4, 'twoport', 18, 5);
schedule4 = changestarttime(schedule4, 'twoport', 13, 5);
schedule4 = changestarttime(schedule4, 'twoport', 16, 4);
schedule4 = changestarttime(schedule4, 'twoport', 2, 1);
schedule4 = changestarttime(schedule4, 'twoport', 1, 1);
schedule4 = changestarttime(schedule4, 'twoport', 10, 6);
schedule4 = changestarttime(schedule4, 'twoport', 4, -1);
schedule4 = changestarttime(schedule4, 'twoport', 6, 3);
schedule4 = changestarttime(schedule4, 'twoport', 17, -4);
schedule4 = changestarttime(schedule4, 'twoport', 9, 12);
schedule4 = changestarttime(schedule4, 'twoport', 12, 4);
schedule4 = changestarttime(schedule4, 'twoport', 10, -3);
schedule4 = changestarttime(schedule4, 'twoport', 7, -3);
schedule4 = changestarttime(schedule4, 'twoport', 4, -2);
schedule4 = changestarttime(schedule4, 'twoport', 12, -2);
schedule4 = changestarttime(schedule4, 'twoport', 22, -2);
schedule4 = changestarttime(schedule4, 'twoport', 14, -1);
schedule4 = changestarttime(schedule4, 'twoport', 15, 0);
schedule4 = changestarttime(schedule4, 'twoport', 19, -1);
schedule4 = changestarttime(schedule4, 'twoport', 3, 1);
schedule4 = changestarttime(schedule4, 'twoport', 5, -1);
schedule4 = changestarttime(schedule4, 'twoport', 9, -1);
schedule4 = changestarttime(schedule4, 'twoport', 16, -1);
schedule4 = changestarttime(schedule4, 'twoport', 13, -1);
schedule4 = changestarttime(schedule4, 'twoport', 8, -1);
schedule4 = changestarttime(schedule4, 'twoport', 11, -1);
schedule4 = changestarttime(schedule4, 'twoport', 21, -1);
schedule4 = changestarttime(schedule4, 'twoport', 14,-1);
schedule4 = changestarttime(schedule4, 'twoport', 15, -2);
schedule4 = changestarttime(schedule4, 'twoport', 22, 2);
schedule4 = changestarttime(schedule4, 'twoport', 20, -1);
schedule4 = changestarttime(schedule4, 'twoport', 5, -1);
schedule4 = changestarttime(schedule4, 'twoport', 3, -1);
schedule4 = changestarttime(schedule4, 'twoport', 6, -1);
schedule4 = changestarttime(schedule4, 'twoport', 17, -1);
schedule4 = changestarttime(schedule4, 'twoport', 18, -1);

plotschedule(schedule4);
printstarttimes(schedule4)


