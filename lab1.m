clc;clear;close all;
addpath /site/edu/da/TSTE87/matlab/
num_sample = 64;
impulse = [1,zeros(1,num_sample-1)];
%% Task 2
sfg2 = [];

num_samples2 = 50;

sfg2 = addoperand(sfg2, 'in', 1, 1);
sfg2 = addoperand(sfg2, 'add', 1, [1 2], 3);
sfg2 = addoperand(sfg2, 'delay', 1, 3, 4);
sfg2 = addoperand(sfg2, 'constmult', 1, 4, 2, 0.5);
sfg2 = addoperand(sfg2, 'out', 1, 4);

errorlist = checknodes(sfg2);
if errorlist > 0
    error('Initialization failed');
end

output2 = impulseresponse(sfg2, num_samples2);
figure('Name', 'Task 2');
stem(output2, 'filled');
title('Impulse response');

figure('Name', 'Task 2 - Freq response');
output_freq2 = simulate(sfg2, fft(output2));
freqz(output_freq2);

%% Task 3

num_samples3 = 64;
consts_a = [57/256 55/128 57/256];
consts_b = [-179/512 171/512];
sfg3 = [];

% addoperand(sfg, opname, id-number, innodes, outnodes, opdata, optype)
sfg3 = addoperand(sfg3, 'in', 1, 1);
sfg3 = addoperand(sfg3, 'add', 1, [1 2], 4);
sfg3 = addoperand(sfg3, 'add', 2, [3 5], 2);
sfg3 = addoperand(sfg3, 'add', 3, [8 11], 12);
sfg3 = addoperand(sfg3, 'add', 4, [9 10], 11);
sfg3 = addoperand(sfg3, 'constmult', 1, 6, 5, -consts_b(1));
sfg3 = addoperand(sfg3, 'constmult', 2, 7, 3, -consts_b(2));
sfg3 = addoperand(sfg3, 'constmult', 3, 4, 8, consts_a(1));
sfg3 = addoperand(sfg3, 'constmult', 4, 6, 9, consts_a(2));
sfg3 = addoperand(sfg3, 'constmult', 5, 7, 10, consts_a(3));
sfg3 = addoperand(sfg3, 'delay', 1, 4, 6);
sfg3 = addoperand(sfg3, 'delay', 2, 6, 7);
sfg3 = addoperand(sfg3, 'out', 1, 12);

errorlist = checknodes(sfg3);
if errorlist > 0
    error('Initialization of sfg3 failed');
end

printprecedence(sfg3);

plotprecedence(sfg3);
title('Precedence');

figure; 
output3 = impulseresponse(sfg3, num_samples3);
stem(output3, 'filled');
title('Impulse response');

%%
[output_freq3,outputid3,registers3,registerid3,nodes3,nodeid3] = simulate(sfg3, impulse);

figure('Name', 'Task 3 - Freq response');
[h,w] = freqz(output_freq3);
plot(w/pi,db(h));
hold on;
plot([0 1],[-1.023,-1.023]);
hold off;




%% Scaling
node_sum3 = [nodeid3,zeros(max(nodeid3),1)];
for i=1:max(nodeid3)
    node_sum3(i,2)=sum(abs(nodes3(i,:)));
end
display(node_sum3);

%% Extra def for insertoperand error
%sfg3_scale = [];
% sfg3_scale = addoperand(sfg3_scale, 'in', 1, 1);
% sfg3_scale = addoperand(sfg3_scale, 'add', 1, [13 2], 4);
% sfg3_scale = addoperand(sfg3_scale, 'add', 2, [3 5], 2);
% sfg3_scale = addoperand(sfg3_scale, 'add', 3, [8 11], 12);
% sfg3_scale = addoperand(sfg3_scale, 'add', 4, [9 10], 11);
% sfg3_scale = addoperand(sfg3_scale, 'constmult', 1, 6, 5, -consts_b(1));
% sfg3_scale = addoperand(sfg3_scale, 'constmult', 2, 7, 3, -consts_b(2));
% sfg3_scale = addoperand(sfg3_scale, 'constmult', 3, 4, 8, consts_a(1));
% sfg3_scale = addoperand(sfg3_scale, 'constmult', 4, 6, 9, consts_a(2));
% sfg3_scale = addoperand(sfg3_scale, 'constmult', 5, 7, 10, consts_a(3));
% sfg3_scale = addoperand(sfg3_scale, 'delay', 1, 4, 6);
% sfg3_scale = addoperand(sfg3_scale, 'delay', 2, 6, 7);
% sfg3_scale = addoperand(sfg3_scale, 'out', 1, 12);
%sfg3_scale = addoperand(sfg3_scale,'constmult',6,1,13,0.5);

%% Scaling cont.
sfg3_scale = sfg3;
sfg3_scale = insertoperand(sfg3_scale,'constmult',6,1,0.5);

errorlist = checknodes(sfg3_scale);
if errorlist > 0
    error('Initialization of sfg3_scale failed');
end

plotprecedence(sfg3_scale);
[output_freq3_2,outputid3_2,registers3_2,registerid3_2,nodes3_2,nodeid3_2] = simulate(sfg3_scale, impulse);

node_sum3_2 = [nodeid3_2,zeros(max(nodeid3_2),1)];
for i=1:max(nodeid3_2)
    node_sum3_2(i,2)=sum(abs(nodes3_2(i,:)));
end
display(node_sum3_2);

figure('Name', 'Task 3 - Scaled Freq response');
[h,w] = freqz(output_freq3_2);
plot(w/pi,db(h));
%hold on;
%plot([0 1],[-1.023,-1.023]);
%hold off;

random = 2*rand(1,num_sample)-1;
output3_3 = simulate(sfg3,random,1,[],[],[1 15]);
output3_4 = simulate(sfg3_scale,random,1,[],[],[1 15]);

figure;
stem(output3_3);
hold on;
stem(output3_4);
hold off;
legend('show');



%% TASK 4 - WDF

coeff = [167/256 -135/256 1663/2048 -1493/2048 669/1024 -117/128 583/1024];

sfg4 = [];
sfg4 = addoperand(sfg4,'in',1,1);
sfg4 = addoperand(sfg4,'twoport',1,[1 2],[4 3],coeff(1),'symmetric');
sfg4 = addoperand(sfg4,'twoport',2,[1 11],[12 13],coeff(2),'symmetric');
sfg4 = addoperand(sfg4,'twoport',3,[13 14],[16 15],coeff(3),'symmetric');
sfg4 = addoperand(sfg4,'twoport',4,[4 5],[7 6],coeff(4),'symmetric');
sfg4 = addoperand(sfg4,'twoport',5,[6 8],[10 9],coeff(5),'symmetric');
sfg4 = addoperand(sfg4,'twoport',6,[12 17],[19 18],coeff(6),'symmetric');
sfg4 = addoperand(sfg4,'twoport',7,[18 20],[22 21],coeff(7),'symmetric');
sfg4 = addoperand(sfg4,'delay',1,3,2);
sfg4 = addoperand(sfg4,'delay',2,16,11);
sfg4 = addoperand(sfg4,'delay',3,15,14);
sfg4 = addoperand(sfg4,'delay',4,10,5);
sfg4 = addoperand(sfg4,'delay',5,9,8);
sfg4 = addoperand(sfg4,'delay',6,22,17);
sfg4 = addoperand(sfg4,'delay',7,21,20);
sfg4 = addoperand(sfg4,'add',1,[7 19],23);
sfg4 = addoperand(sfg4,'constmult',1,23,24,1/2);
sfg4 = addoperand(sfg4,'out',1,24);

errorlist = checknodes(sfg4);
if errorlist > 0
    error('Initialization of sfg4 failed');
end

plotprecedence(sfg4);
N = 10000;
impulse2=[1, zeros(1,N-1)];
[output_freq4,outputid4,registers4,registerid4,nodes4,nodeid4] = simulate(sfg4, impulse2);

node_sum4 = [nodeid4,zeros(max(nodeid4),1)];
for i=1:max(nodeid4)
    node_sum4(i,2)=sum(abs(nodes4(i,:)));
end
display(node_sum4);

figure('Name', 'Task 4 - Freq response');
[h,w] = freqz(output_freq4);
plot(w/pi,db(h));


figure;
phasez(nodes4(7,:));
hold on;
phasez(nodes4(18,:));
hold off;

%% L2-norm scaling
sfg4_scaled = sfg4;

sfg4_scaled = insertoperand(sfg4_scaled,'constmult',2,1,1/2);
sfg4_scaled = insertoperand(sfg4_scaled,'constmult',3,4,1/2);
sfg4_scaled = insertoperand(sfg4_scaled,'constmult',4,25,1/2);
sfg4_scaled = insertoperand(sfg4_scaled,'constmult',5,12,1/2);
sfg4_scaled = insertoperand(sfg4_scaled,'constmult',5,24,8);


[output_freq4,outputid4_s,registers4_s,registerid4_s,nodes4_s,nodeid4_s] = simulate(sfg4_scaled, impulse2);

node_sum4_3 = [nodeid4_s,zeros(max(nodeid4_s),1)];
for i=1:max(nodeid4_s)
    node_sum4_3(i,2)=sum(abs(nodes4_s(i,:)));
end
display(node_sum4_3);

%L2-sum, multiplier inputs
diff1 = sqrt(sum((nodes4_s(2,:)-nodes4_s(25,:)).^2))
diff2 = sqrt(sum((nodes4_s(11,:)-nodes4_s(27,:)).^2))
diff3 = sqrt(sum((nodes4_s(15,:)-nodes4_s(16,:)).^2))
diff4 = sqrt(sum((nodes4_s(5,:)-nodes4_s(26,:)).^2))
diff5 = sqrt(sum((nodes4_s(8,:)-nodes4_s(6,:)).^2))
diff6 = sqrt(sum((nodes4_s(17,:)-nodes4_s(28,:)).^2))
diff7 = sqrt(sum((nodes4_s(20,:)-nodes4_s(18,:)).^2))


%L2-sum of all nodes
L2_sum_s = [nodeid4_s,zeros(max(nodeid4_s),1)];
for i=1:max(nodeid4_s)
    L2_sum_s(i,2)=sqrt(sum(nodes4_s(i,:).^2));
end
display(L2_sum_s);

%% Scaled filter sim - rand input
output4 = simulate(sfg4_scaled,random,1,[],[],[1 15]);

%figure;
%stem(output4);


%% Pipeline

sfg4_scaled = insertoperand(sfg4_scaled,'delay',8,4);
sfg4_scaled = insertoperand(sfg4_scaled,'delay',9,12);
%sfg4_scaled = insertoperand(sfg4_scaled,'delay',10,12);
%sfg4_scaled = insertoperand(sfg4_scaled,'delay',11,13);

output4_2 = simulate(sfg4_scaled,random,1,[],[],[1 15]);

figure;
stem(output4);
hold on;
stem(output4_2);
hold off;

%% LAST TASK - Flattening
plotprecedence(sfg4_scaled);

flat = flattensfg(sfg4_scaled);

plotprecedence(flat);
