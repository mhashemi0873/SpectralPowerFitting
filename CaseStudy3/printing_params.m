function [] = printing_params(y)

vals = linspace(1,length(y),length(y));

vars = {'D', 'tau', 'beta_e', 'beta_i', 'G_ese', 'G_srs', 'G_esre'};

for i = vals
    eval([vars{i} '=  y(i)'])
end

end