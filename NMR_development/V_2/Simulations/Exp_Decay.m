clc
clear all

size = 1750;
d = 5;
t = (0:d/(size-10):d)';
fs = (size-10)/d;
T21 = 1.1;
T22 = 0.9;
T23 = 1.3;
mO = 0.33*exp(-t./T21) + 0.33*exp(-t./T22) + 0.33*exp(-t./T22);

Y = zeros(size-9,1);

for i = 1:(size-9)
   Y(i,:) = mO(i,:) + rand()/40;
end

f1 = fit(t,Y,'exp2')

plot(t,Y)
grid
axis([0 5 0 1])
grid 
title('Synthetic Signal with Noise')
xlabel('Time (s)')
ylabel('Voltage (V)')