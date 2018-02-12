function [c,ceq] = mynonlcon(param,Ydata_1)

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

c(1)=-C1;
c(2)=-C2;
c(3)=-C3;
c(4)=-C4;
c(5)=-z0;
c(6)=Delta;

h=param(1)-((1+param(6)+param(7)-param(5))*sqrt(exp(Ydata_1)));

c(7)=abs(h)-eps;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%c(1)=param(4)-param(3);
%c(2)=(param(3)*(param(5)-1))-(param(4)*(param(6)+2));
%c(3)=param(5)-param(6)-param(7)-1;
%c(4)=(-param(5)+param(6)-param(7)+1)-((2*param(3)+param(4))*(((param(6)+2)/param(3))+((1-param(5))/param(4))));
%c(5)=((param(3)^2*param(4))^2)*(((param(7)-param(5))^2)-((param(6)+1)^2));
%c(6)=-((1/param(3))*((1/param(3))+(2/param(4))))-(4*(param(2)^2)*(param(7)-param(5)))-(4*param(5)*param(2)/param(4));
%c(7)=abs((param(1)-((1+param(6)+param(7)-param(5))*sqrt(exp(Ydata_1)))))-eps;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

c=[c(1); c(2); c(3); c(4); c(5); c(6); c(7)];

ceq = [];
