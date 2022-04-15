clc
clear all

t2 = 0:0.0001:2;

name1 = 'JP-8';
sd1 = 0.0017;
u1 = 0.956;
n1 = normpdf(t2,u1,sd1);

name2 = 'Jet-A';
sd2 = 0.00151;
u2 = 0.89755;
n2 = normpdf(t2,u2,sd2);

name3 = 'JP-5';
sd3 = 0.00134;
u3 = 0.82875;
n3 = normpdf(t2,u3,sd3);

name4 = 'Shell SPK';
sd4 = 0.00198;
u4 = 1.01431;
n4 = normpdf(t2,u4,sd4);

name5 = 'Shell CPK';
sd5 = 0.00182;
u5 = 0.96745;
n5 = normpdf(t2,u5,sd5);

name6 = 'Gevo-ATJ'; 
sd6 = 0.00145;
u6 = 0.88956;
n6 = normpdf(t2,u6,sd6);

plot(t2,n1,'b',t2,n2,'r',t2,n3,'k',t2,n4,'m',t2,n5,'c',t2,n6,'g')
grid
axis([0.75 1.1 0 300])
legend(name1,name2,name3,name4,name5,name6)
title('T2 Distribution - Single Exponential Fit - 10/25/21')
xlabel('T2 Time Constant (s)')



