function [c,ceq] = mynonlcon_GE(param)

alpha=param(3);
beta=param(4);
G1=param(5);
G2=param(6);
G3=param(7);

a3=1/((alpha^2)*beta);
a2=((2/(alpha*beta))+(1/(alpha^2)));
a1=((2+G2)/alpha)+(1/beta);
a0=(1+G2);

b2=0;
b1=-(G1/beta);
b0=(G3-G1);

z3=1;
z2=((a2^2)-(2*a1*a3))/(a3^2);
z1=((a1^2)-(2*a0*a2)-(b1^2))/(a3^2);
z0=((a0^2)-(b0^2))/(a3^2);

Delta=-4*z1^3+(z1^2*z2^2)+18*z2*z1*z0-(4*z0*(z2^3))-(27*z0^2);

C1=alpha-beta;
C2=a1+b1; 
C3=a0+b0;
C4=((a2+b2)*(a1+b1))-(a3*(a0+b0));

c(1)=-C2;
c(2)=-C4;
c(3)=-z0;
c(4)=Delta;

c=[c(1); c(2); c(3); c(4)];

ceq = [];
