function f =LSE_biased(myfunc, param, Xdata,Ydata,Prefactor,Nidx)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%f=sum((abs(Ydata - myfunc)./var(Ydata)).^2); % Standard objective function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cst1=Prefactor(1);
cst2=Prefactor(2);
cst3=Prefactor(3);
cst4=Prefactor(4);
cst5=Prefactor(5);
cst6=Prefactor(6);
cst7=Prefactor(7);
cst8=Prefactor(8);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
n1=Nidx(1);
n2=Nidx(2);
n3=Nidx(3);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
frequency=Xdata;
power_expr=Ydata;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
obj=abs((power_expr - ((myfunc)))./var(power_expr)).^2;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
data_der=diff(power_expr)./diff(frequency);
model_der=diff((myfunc))./diff(frequency);
obj_der=abs((data_der - model_der)./var(power_expr)).^2;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Manually biased objective function:
f = (cst1*sum(obj(1:n1)))'+(cst2*sum(obj(n1:n2)))'+(cst3*sum(obj(n2:n3)))'+(cst4*sum(obj(n3:end)))'+...
    (cst5*sum(obj_der(1:n1)))'+(cst6*sum(obj_der(n1:n2)))'+(cst7*sum(obj_der(n2:n3)))'+(cst8*sum(obj_der(n3:end)))'; 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end