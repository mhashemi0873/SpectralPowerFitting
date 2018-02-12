function PowerSpectrum = func_delaylinear(param,Xdata)

kappa=param(1);
a=param(2);
b=param(3);
tau=param(4);


w=2*pi*Xdata;

PowerSpectrum=log((2*kappa)*(1./(((a+b*cos(tau*w)).^2)+((w+b*sin(tau*w)).^2))));


end
