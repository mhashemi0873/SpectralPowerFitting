function PowerSpectrum = lm_func (Xdata,param)

kappa=param(1);
Omega=param(2);
tau=param(3);

epsilon=1;
a=(2*pi*Omega/tan(2*pi*Omega*tau))-epsilon;
b=-2*pi*Omega./sin(2*pi*Omega*tau);

w=2*pi*Xdata;

PowerSpectrum=log((2*kappa)*(1./(((a+b*cos(tau*w)).^2)+((w+b*sin(tau*w)).^2))));






