function PowerSpectrum = myfunc(param,Xdata)

frequency=Xdata;
w=2*pi*frequency;

gama=1./param(3);
eta=1./param(4);
Le=(1i*gama*w)+1;
Li= (1i*eta*w)+1;

Numerator=-param(1)*(exp(-1i*param(2)*w)).*Li;
Denominator=(Le.*((Le.*Li)+param(6)))+((exp(-2*1i*param(2)*w)).*(param(7)-(param(5).*Li)));

G=abs(Numerator)./abs(Denominator);

PowerSpectrum=log(G.^2);

end