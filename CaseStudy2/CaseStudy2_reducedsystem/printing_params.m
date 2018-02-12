function [] = printing_params(y)

vals = linspace(1,length(y),length(y));

vars = {'kappa', 'Omega', 'tau'};

for i = vals
    eval([vars{i} '=  y(i)'])
end

end