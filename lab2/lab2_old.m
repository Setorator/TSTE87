clc;clear;close all;
addpath /site/edu/da/TSTE87/matlab/

% INPUTS
N = 64;
impulse = [1, zeros(1,N-1)];
random = 2*rand(1,N)-1;

% The phase-correcting allpass filter

% Adaptor coefficients
a10 = 0.4573;
a11 = -0.2098;
a12 = 0.5695;
a13 = -0.2123;
a14 = 0.0952;
a15 = -0.2258;
a16 = -0.449;

sfga = [];

sfga = addoperand(sfga, 'in', 1, 1);
sfga = addoperand(sfga, 'twoport', 1, [ 1  3], [ 4  2], a10, 'symmetric');
sfga = addoperand(sfga, 'twoport', 2, [ 4  9], [10  5], a11, 'symmetric');
sfga = addoperand(sfga, 'twoport', 3, [ 6  8], [ 9  7], a12, 'symmetric');
sfga = addoperand(sfga, 'twoport', 4, [10 15], [16 11], a13, 'symmetric');
sfga = addoperand(sfga, 'twoport', 5, [12 14], [15 13], a14, 'symmetric');
sfga = addoperand(sfga, 'twoport', 6, [16 21], [22 17], a15, 'symmetric');
sfga = addoperand(sfga, 'twoport', 7, [18 20], [21 19], a16, 'symmetric');
sfga = addoperand(sfga, 'delay', 1,  2,  3);
sfga = addoperand(sfga, 'delay', 2,  5,  6);
sfga = addoperand(sfga, 'delay', 3,  7,  8);
sfga = addoperand(sfga, 'delay', 4, 11, 12);
sfga = addoperand(sfga, 'delay', 5, 13, 14);
sfga = addoperand(sfga, 'delay', 6, 17, 18);
sfga = addoperand(sfga, 'delay', 7, 19, 20);
sfga = addoperand(sfga, 'out', 1, 22);

% Bireciprocal low-pass filter for interpolator

% Adaptor coefficients (all even coefficients are zero)
a1 = -0.068129;
a3 = -0.242429;
a5 = -0.461024;
a7 = -0.678715;
a9 = -0.888980;

sfgb = [];

sfgb = addoperand(sfgb, 'in', 1, 1);
sfgb = addoperand(sfgb, 'twoport', 1, [2 5], [6 3], a3, 'symmetric');
sfgb = addoperand(sfgb, 'twoport', 2, [6 9], [10 7], a7, 'symmetric');
sfgb = addoperand(sfgb, 'twoport', 3, [1 13], [14 11], a1, 'symmetric');
sfgb = addoperand(sfgb, 'twoport', 4, [14 17], [18 15], a5, 'symmetric');
sfgb = addoperand(sfgb, 'twoport', 5, [18 21], [22 19], a9, 'symmetric');
sfgb = addoperand(sfgb, 'delay', 1, 1, 2);
sfgb = addoperand(sfgb, 'delay', 2, 3, 4);
sfgb = addoperand(sfgb, 'delay', 3, 4, 5);
sfgb = addoperand(sfgb, 'delay', 4, 7, 8);
sfgb = addoperand(sfgb, 'delay', 5, 8, 9);
sfgb = addoperand(sfgb, 'delay', 6, 11, 12);
sfgb = addoperand(sfgb, 'delay', 7, 12, 13);
sfgb = addoperand(sfgb, 'delay', 8, 15, 16);
sfgb = addoperand(sfgb, 'delay', 9, 16, 17);
sfgb = addoperand(sfgb, 'delay', 10, 19, 20);
sfgb = addoperand(sfgb, 'delay', 11, 20, 21);
sfgb = addoperand(sfgb, 'add', 1, [10 22], 23);
sfgb = addoperand(sfgb, 'out', 1, 23);


%--------------------------------
% TASK 1
%load('interpolatorallpass.m');
%load interpolatorbireciprocal.m;

%cascadedsfg = cascadesfg(sfga, sfgb);

% Simulate
[output1,outputids1,registers1,registerids1,nodes1,nodeids1] = simulate(sfga, impulse);
input2 = upsample(output1,2); %Upsample by 2
[output2,outputids2,registers2,registerids2,nodes2,nodeids2] = simulate(sfgb, input2);
input3 = upsample(output2,2); %Upsample by 2
[output3,outputids3,registers3,registerids3,nodes3,nodeids3] = simulate(sfgb, input3);

stem(output3);

%Freq respons
[h1,w1] = freqz(output1);
[h2,w2] = freqz(output2);
%figure
%plot(w1/pi, db(h1));

[h3,w3] = freqz(output3);
figure
hold on;
plot(w2/pi,db(h2));
plot(w3/pi,db(h3));
hold off;

% Quantized coeffs
a1 = quant(a1,2^-(11));
a3 = quant(a3,2^-(11));
a5 = quant(a5,2^-(11));
a7 = quant(a7,2^-(11));
a9 = quant(a9,2^-(11));

a10 = quant(a10,2^-(11));
a11 = quant(a11,2^-(11));
a12 = quant(a12,2^-(11));
a13 = quant(a13,2^-(11));
a14 = quant(a14,2^-(11));
a15 = quant(a15,2^-(11));
a16 = quant(a16,2^-(11));

% NEW SIM
[output1,outputids1,registers1,registerids1,nodes1,nodeids1] = simulate(sfga, impulse);
input2 = upsample(output1,2); %Upsample by 2
[output2,outputids2,registers2,registerids2,nodes2,nodeids2] = simulate(sfgb, input2);
input3 = upsample(output2,2); %Upsample by 2
[output3,outputids3,registers3,registerids3,nodes3,nodeids3] = simulate(sfgb, input3);

[h22,w22] = freqz(output2);
%figure
%plot(w1/pi, db(h1));

[h32,w32] = freqz(output3);
figure
hold on;
plot(w1/pi,abs(h3));
plot(w3/pi,abs(h32));
hold off;

% Random input signal
[output1,outputids1,registers1,registerids1,nodes1,nodeids1] = simulate(sfga, random);
input2 = upsample(output1,2); %Upsample by 2
[output2,outputids2,registers2,registerids2,nodes2,nodeids2] = simulate(sfgb, input2);
input3 = upsample(output2,2); %Upsample by 2
[output3,outputids3,registers3,registerids3,nodes3,nodeids3] = simulate(sfgb, input3);

%figure
plotprecedence(sfgb);

figure
stem(registers3(11,:));

figure
hold on;
stem(nodes3(10,:));
stem(nodes3(22,:));
hold off;


%----------------------------
% TASK 2

sfgb2 = [];

sfgb2 = addoperand(sfgb2, 'in', 1, 1);
sfgb2 = addoperand(sfgb2, 'twoport', 1, [1 3], [4 2], a3, 'symmetric');
sfgb2 = addoperand(sfgb2, 'twoport', 2, [4 6], [7 5], a7, 'symmetric');
sfgb2 = addoperand(sfgb2, 'twoport', 3, [1 9], [10 8], a1, 'symmetric');
sfgb2 = addoperand(sfgb2, 'twoport', 4, [10 12], [13 11], a5, 'symmetric');
sfgb2 = addoperand(sfgb2, 'twoport', 5, [13 15], [16 14], a9, 'symmetric');
sfgb2 = addoperand(sfgb2, 'delay', 1, 2, 3);
sfgb2 = addoperand(sfgb2, 'delay', 2, 5, 6);
sfgb2 = addoperand(sfgb2, 'delay', 3, 8, 9);
sfgb2 = addoperand(sfgb2, 'delay', 4, 11, 12);
sfgb2 = addoperand(sfgb2, 'delay', 5, 14, 15);
sfgb2 = addoperand(sfgb2, 'out', 1, 7);
sfgb2 = addoperand(sfgb2, 'out', 2, 16);

plotprecedence(sfgb2);

% Random input signal
[output1,outputids1,registers1,registerids1,nodes1,nodeids1] = simulate(sfga, random);
%input2 = upsample(output1,2); %Upsample by 2
input2 = output1;
[output2,outputids2,registers2,registerids2,nodes2,nodeids2] = simulate(sfgb2, input2);
input3 = [upsample(output2(1,:),2),0] + [0,upsample(output2(2,:),2)];
%input3 = upsample(output2,2); %Upsample by 2
[output3,outputids3,registers3,registerids3,nodes3,nodeids3] = simulate(sfgb2, input3);
output = [upsample(output3(1,:),2),0] + [0,upsample(output3(2,:),2)];


[h_t2,w_t2] = freqz(output);
figure
plot(w_t2/pi,abs(h_t2));
%plot(w33/pi,abs(h33));



