function [] = printing_params(y)

vals = linspace(1,length(y),length(y));

vars = {'kappa', 'gamma', 'f_0'};

for i = vals
    eval([vars{i} '=  y(i)'])
end

end