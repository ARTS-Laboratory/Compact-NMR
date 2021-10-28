clc
clear all

t2 = (0:0.0001:1.5)';

name1 = 'JP-8 (1)';
sd1 = 0.01;
u1 = 0.37;
n1 = normpdf(t2,u1,sd1);
sd11 = 0.0553;
u11 = 0.9833;
n11 = normpdf(t2,u11,sd11);
n1 = n1 + n11;


name2 = 'JP-8 (2)';
sd2 = 0.0165;
u2 = 0.41;
n2 = normpdf(t2,u2,sd2);
sd22 = 0.0755;
u22 = 0.9891;
n22 = normpdf(t2,u22,sd22);
n2 = n2 + n22;

name3 = 'JP-8 (3)';
sd3 = 0.01;
u3 = 0.3;
n3 = normpdf(t2,u3,sd3);
sd31 = 0.0553;
u31 = 0.9718;
n31 = normpdf(t2,u31,sd31);
n3 = n3 + n31;

name4 = 'JP-5 (4)';
sd4 = 0.0117;
u4 = 0.7849;
n4 = normpdf(t2,u4,sd4);
sd41 = 0.0721;
u41 = 1.174;
n41 = normpdf(t2,u41,sd41);
n4 = n4 + n41;

name5 = 'Shell CPK';
sd5 = 0.22913;
u5 = 0.37406;
n5 = normpdf(t2,u5,sd5);
sd51 = 0.03385;
u51 = 1.0032;
n51 = normpdf(t2,u51,sd51);
n5 = n5 + n51;

name6 = 'Gevo-ATJ'; 
sd6 = 0.14526;
u6 = 0.26154;
n6 = normpdf(t2,u6,sd6);
sd61 = 0.01184;
u61 = 0.90647;
n61 = normpdf(t2,u61,sd61);
n6 = n6 + n61;

name7 = 'Heptane'; 
sd7 = 0.04495;
u7 = 0.1274;
n7 = normpdf(t2,u7,sd7);
sd71 = 0.00188;
u71 = 1.0093;
n71 = normpdf(t2,u71,sd71);
n7 = n7 + n71;

plot(t2,n1,'b',t2,n2,'r',t2,n3,'m',t2,n4,'k')
grid
%axis([0 1.25 0 100])
legend(name1,name2,name3,name4)
title('Two Term T2 Value Distribution')
xlabel('T2 Time Constant (s)')



