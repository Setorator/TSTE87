clc;clear;close all;
% Signal flow graph
sfg = [];
sfg = addoperand(sfg, 'in', 1, 1);
sfg = addoperand(sfg, 'add', 1, [1 2], 3);
sfg = addoperand(sfg, 'delay', 1, 3, 4);
sfg = addoperand(sfg, 'mult', 1, 4, 2, 0.5);
sfg = addoperand(sfg, 'out', 1, 4);

%printsfg(sfg);
%printprecedence(sfg);
%plotprecedence(sfg);
errorlist = checknodes(sfg);

%Input signals
N = 64;
impulse = [1, zeros(1,N-1)];
random = 2*rand(1,N)-1;

% output = simulate(sfg,impulse);
% figure
% stem(output);
% 
% figure
% freqz(output);


% ------------------------------
% TASK3
% 2nd ord IIR filter

a0 = 57/256;
a1 = 55/128;
a2 = 57/256;
b1 = -179/512;
b2 = 171/512;

sfg2 = [];
sfg2 = addoperand(sfg2,'in',1,1);
sfg2 = addoperand(sfg2,'add',1,[1 2],3);
sfg2 = addoperand(sfg2,'mult',1,3,4,a0);
sfg2 = addoperand(sfg2,'delay',1,3,5);
sfg2 = addoperand(sfg2,'mult',1,5,6,-b1);
sfg2 = addoperand(sfg2,'delay',1,5,7);
sfg2 = addoperand(sfg2,'mult',1,5,8,a1);
sfg2 = addoperand(sfg2,'mult',1,7,9,-b2);
sfg2 = addoperand(sfg2,'add',1,[6 9],2);
sfg2 = addoperand(sfg2,'mult',1,7,10,a2);
sfg2 = addoperand(sfg2,'add',1,[8 10],11);
sfg2 = addoperand(sfg2,'add',1,[4 11],12);
sfg2 = addoperand(sfg2,'out',1,12);

printsfg(sfg2);
printprecedence(sfg2);
%figure
plotprecedence(sfg2);
errorlist = checknodes(sfg2);

[output_org,outputids,registers,resterids,nodes,nodeids] = simulate(sfg2, impulse);
%figure
%stem(output);

[h,w] = freqz(output_org);
plot(w/pi, db(h));
hold on;
plot([0 1],[-1.023 -1.023]);

%Stopband At.
stopband = h(round(0.88*512):end);
A_min = max(stopband);
plot([0 1],[db(A_min) db(A_min)]);
hold off;


% Scaling
node_sum = [nodeids, zeros(max(nodeids),1)];
for i=1:max(nodeids)
    node_sum(i,2) = sum(abs(nodes(i,:)));
end
display(node_sum);

% Power-of-two scaling
sfg2 = insertoperand(sfg2,'mult',2,1,1/2);
%sfg2 = insertoperand(sfg2,'mult',2,12,2);

plotprecedence(sfg2);

% New simulation
[output_scaled,outputids_scaled,registers_scaled,resterids_scaled,nodes_scaled,nodeids_scaled] = simulate(sfg2, impulse);

node_sum_scaled = [nodeids_scaled, zeros(max(nodeids_scaled),1)];
for i=1:max(nodeids_scaled)
    node_sum_scaled(i,2) = sum(abs(nodes_scaled(i,:)));
end
display(node_sum_scaled);

% Filter comparison with random input signals
output_org = simulate(sfg,random,1,[],[],15);
output_scaled = simulate(sfg2,random,1,[],[],15);

figure
stem(output_org);
hold on;
stem(output_scaled);
hold off;


% ---------------------
% WDF

coeff = [167/256,-135/256,1663/2048,-1493/2048,669/1024,-117/128,583/1024];
sfg3 = sfg_LWDF(coeff);
error = checknodes(sfg3);
plotprecedence(sfg3);

%addoperand(sfg,operandname,id-number,innodes,outnodes,operanddata,operandtype)
sfg4 = [];
sfg4 = addoperand(sfg4,'in',1,1);
sfg4 = addoperand(sfg4,'twoport',1,[1 14], [16 15],coeff(1),'symmetric');
sfg4 = addoperand(sfg4,'delay',1,15,14);
sfg4 = addoperand(sfg4,'twoport',2,[1 2], [7 6],coeff(2),'symmetric');
sfg4 = addoperand(sfg4,'delay',2,3,2);
sfg4 = addoperand(sfg4,'twoport',3,[6 5], [3 4],coeff(3),'symmetric');
sfg4 = addoperand(sfg4,'delay',3,4,5);
sfg4 = addoperand(sfg4,'twoport',4,[16 17], [22 21],coeff(4),'symmetric');
sfg4 = addoperand(sfg4,'delay',4,18,17);
sfg4 = addoperand(sfg4,'twoport',5,[21 20], [18 19],coeff(5),'symmetric');
sfg4 = addoperand(sfg4,'delay',5,19,20);
sfg4 = addoperand(sfg4,'twoport',6,[7 8], [13 12],coeff(6),'symmetric');
sfg4 = addoperand(sfg4,'delay',6,9,8);
sfg4 = addoperand(sfg4,'twoport',7,[12 11], [9 10],coeff(7),'symmetric');
sfg4 = addoperand(sfg4,'delay'

%---------------------
% TASK 1
%load('interpolatorallpass.m');
%load interpolatorbireciprocal.m;

c,7,10,11);
sfg4 = addoperand(sfg4,'add',1,[13 22],23);
sfg4 = addoperand(sfg4,'mult',1,23,24,1/2);
sfg4 = addoperand(sfg4,'out',1,24);

error4 = checknodes(sfg4);
plotprecedence(sfg4);

%out3 = impulseresponse(sfg3,128);
%out4 = impulseresponse(sfg4,128);

[output_dwf,outputids_dwf,registers_dwf,registerids_dwf,nodes_dwf,nodeids_dwf] = simulate(sfg4, impulse);

%figure
%stem(output_dwf);

node_sum_dwf = [nodeids_dwf, zeros(max(nodeids_dwf),1)];
for i=1:max(nodeids_dwf)
    node_sum_dwf(i,2) = sum(abs(nodes_dwf(i,:)));
end
display(node_sum_dwf);
 
[h,w] = freqz(output_dwf);
%Magnetude respons
figure
plot(w/pi,abs(h));
%Phase respons
figure
%plot(w/pi, angle(h));
phasez(output_dwf);

% SCALING L2
sfg4 = insertoperand(sfg4,'mult',2,1,0.5);

[output_dwf,outputids_dwf,registers_dwf,registerids_dwf,nodes_dwf,nodeids_dwf] = simulate(sfg4, impulse);
node_sum_dwf = [nodeids_dwf, zeros(max(nodeids_dwf),1)];
for i=1:max(nodeids_dwf)
    node_sum_dwf(i,2) = sum(abs(nodes_dwf(i,:)));
end
display(node_sum_dwf);
