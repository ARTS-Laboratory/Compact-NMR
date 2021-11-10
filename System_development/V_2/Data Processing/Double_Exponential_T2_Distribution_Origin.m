clc
clear all

t2 = 0:0.0001:1.75;

name1 = 'Shell CPK - a=0.2';
sd1 = 0.000376;
u1 = 0.9;
sd11 = 0.00273;
u11 = 1.4;
n1 = normpdf(t2,u1,sd1) + normpdf(t2,u11,sd11);

name2 = 'Shell CPK - a=0.4';
sd2 = 5.28E-4;
u2 = 0.85;
sd21 = 0.00122;
u21 = 1.21;
n2 = normpdf(t2,u2,sd2) + normpdf(t2,u21,sd21);

name3 = 'Shell CPK - a=0.6';
sd3 = 0.000682;
u3 = 0.8;
sd31 = 0.000685;
u31 = 1.13;
n3 = normpdf(t2,u3,sd3) + normpdf(t2,u31,sd31);

name4 = 'Shell CPK - a=0.8';
sd4 = 0.000883;
u4 = 0.711;
sd41 = 0.000364;
u41 = 1.07;
n4 = normpdf(t2,u4,sd4) + normpdf(t2,u41,sd41);

name5 = 'Toluene';
sd5 = 0.00205;
u5 = 1.08;
sd51 = 0.00244;
u51 = 1.64;
n5 = normpdf(t2,u5,sd5) + normpdf(t2,u51,sd51);

name6 = 'Heptane'; 
sd6 = 0.00145;
u6 = 0.853;
sd61 = 0.00122;
u61 = 1.12;
n6 = normpdf(t2,u6,sd6) + normpdf(t2,u61,sd61);

name7 = 'n-Octane'; 
sd7 = 0.00174;
u7 = 0.95;
sd71 = 0.00145;
u71 = 1.18;
n7 = normpdf(t2,u7,sd7) + normpdf(t2,u71,sd71);

plot(t2,n5,'b',t2,n6,'k',t2,n7,'r')
grid
%axis([0 1.25 0 80])
legend(name5,name6,name7)
title('Biexponential T2 Value Distribution - Origin Curve Fitting')
xlabel('T2 Time Constant (s)')

narr = zeros(size(n1,2),7);
narr(:,1) = t2';
narr(:,2) = n1';
narr(:,3) = n2';
narr(:,4) = n3';
narr(:,5) = n4';
narr(:,6) = n5';
narr(:,7) = n6';



