function PowerSpectrum = lm_func (Xdata,param)

kappa=param(1);
gamma=param(2);
f_0=param(3);

w=2*pi*Xdata;

PowerSpectrum=log((2*kappa)*(1./((((w.^2)-((2*pi*f_0)^2)).^2)+((gamma.*w).^2))));






