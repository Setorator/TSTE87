clc;clear;close all;
load('lab4.mat');
addpath /site/edu/da/TSTE87/matlab/;
set(0,'DefaultFigureWindowStyle','docked')


%% Lab 5
generatetimingcontroller(schedule_pipl(1,1))
generatememorycontroller(cellassignment1,1)
generatememorycontroller(cellassignment2,2)
generatememorycontroller(cellassignment3,3)

for i=1:4
    generatepecontroller(peassignment_pipl{i},schedule_pipl,i,10);
end





