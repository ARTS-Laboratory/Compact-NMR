clc
clear all

t2 = (0.5:0.0001:2)';

name1 = 'Dodecane';
sd1 = 0.0018;
u1 = -0.337;
sd11 = 0.003;
u11 = 0.92;
n1 = normpdf(t2,u1,sd1) + normpdf(t2,u11,sd11);

name2 = 'n-Octane';
sd2 = 0.00503;
u2 = 0.906;
sd21 = 0.0072;
u21 = 1.19;
n2 = normpdf(t2,u2,sd2) + normpdf(t2,u21,sd21);

name3 = 'iso-Octane';
sd3 = 0.00562;
u3 = 0.962;
sd31 = 0.00804;
u31 = 1.25;
n3 = normpdf(t2,u3,sd3) + normpdf(t2,u31,sd31);

name4 = 'Heptane';
sd4 = 0.00543;
u4 = 0.884;
sd41 = 0.00711;
u41 = 1.15;
n4 = normpdf(t2,u4,sd4) + normpdf(t2,u41,sd41);

name5 = 'Toluene';
sd5 = 0.00139;
u5 = -0.97;
sd51 = 0.001;
u51 = 1.4;
n5 = normpdf(t2,u5,sd5) + normpdf(t2,u51,sd51);

name6 = 'Heptane'; 
sd6 = 8.96E-4;
u6 = -0.922;
sd61 = 0.001;
u61 = 1.00;
n6 = normpdf(t2,u6,sd6) + normpdf(t2,u61,sd61);

name7 = 'Conc. Toluene & Heptane'; 
sd7 = 0.002;
u7 = 0.97;
sd71 = 0.002;
u71 = 1.41;
n7 = normpdf(t2,u71,sd71) + normpdf(t2,u7,sd7);

plot(t2,n5,'b',t2,n6,'k',t2,n7,'r')
grid
%axis([0 1.25 0 100])
legend(name5,name6,name7)
%set(gca,'XDir','reverse')
title('Two Term T2 Value Distribution - MATLAB')
xlabel('T2 Time Constant (s)')




