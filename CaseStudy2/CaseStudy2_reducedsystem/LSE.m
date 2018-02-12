function S =LSE(myfunc,Ydata)

S=sum((abs(Ydata - myfunc)./var(Ydata)).^2);

end
