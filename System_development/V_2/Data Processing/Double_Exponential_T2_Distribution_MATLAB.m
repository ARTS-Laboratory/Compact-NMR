clc
clear all

t2 = (0:0.0001:1.5)';

name1 = 'JP-5';
sd1 = 0.018;
u1 = 0.337;
sd11 = 0.00124;
u11 = 0.8712;
n1 = normpdf(t2,u1,sd1) + normpdf(t2,u11,sd11);

name2 = 'Jet-A';
sd2 = 0.018;
u2 = -1;
sd21 = 8.4E-4;
u21 = 0.92;
n2 = normpdf(t2,u2,sd2) + normpdf(t2,u21,sd21);

name3 = 'JP-8';
sd3 = 0.015;
u3 = -1;
sd31 = 9.5E-4;
u31 = 0.97;
n3 = normpdf(t2,u3,sd3) + normpdf(t2,u31,sd31);

name4 = 'Shell CPK';
sd4 = 0.02;
u4 = -1;
sd41 = 9.8E-4;
u41 = 0.99;
n4 = normpdf(t2,u4,sd4) + normpdf(t2,u41,sd41);

name5 = 'Shell SPK';
sd5 = 0.013;
u5 = -1;
sd51 = 0.001;
u51 = 1.015;
n5 = normpdf(t2,u5,sd5) + normpdf(t2,u51,sd51);

name6 = 'Gevo-ATJ'; 
sd6 = 0.02;
u6 = -1;
sd61 = 8E-4;
u61 = 0.89;
n6 = normpdf(t2,u6,sd6) + normpdf(t2,u61,sd61);

name7 = 'Toluene'; 
sd7 = 0.04;
u7 = 0.14685;
sd71 = 0.002;
u71 = 0.97648;
n7 = normpdf(t2,u71,sd71) ;

plot(t2,n1,'b',t2,n2,'k',t2,n3,'r',t2,n4,'m',t2,n5,'g',t2,n6,'c')
grid
%axis([0 1.25 0 100])
legend(name1,name2,name3,name4,name5,name6)
title('Two Term T2 Value Distribution - MATLAB')
xlabel('T2 Time Constant (s)')

narr = zeros(size(n1,1),7);
narr(:,1) = t2;
narr(:,2) = n1;
narr(:,3) = n2;
narr(:,4) = n3;
narr(:,5) = n4;
narr(:,6) = n5;
narr(:,7) = n6;



