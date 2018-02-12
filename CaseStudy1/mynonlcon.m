function [c,ceq] = mynonlcon(param)

kappa=param(1);
gamma=param(2);
f_0=param(3);

c(1)=-kappa;
c(2)=-gamma;
c(3)=-f_0;

c=[c(1); c(2); c(3)];

ceq = [];
