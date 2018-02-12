function G = Gaussian_dist(param,x)

G=(param(1)/(param(3)*sqrt(2*pi)))* exp( -(x-param(2)).^2 / (2*param(3).^2) );

end