function [c,ceq] = mynonlcon(param)

kappa=param(1);
Omega=param(2);
tau=param(3);

c(1)=-kappa;
c(2)=-Omega;
c(3)=-tau;

c=[c(1); c(2); c(3)];

ceq = [];
