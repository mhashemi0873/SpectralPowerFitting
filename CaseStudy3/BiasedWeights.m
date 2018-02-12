function [Prefactor, Nidx] = BiasedWeights(data_name)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if strcmp(data_name, 'Occipital_wake')
    Prefactor=[30 1 10 1 60 1 100 1];
    Nidx=[5 12 25];
end    
  
%%%f = (30*sum(obj(1:5)))'+(1*sum(obj(5:12)))'+(10*sum(obj(12:25)))'+(1*sum(obj(25:end)))'+(60*sum(dobj(1:5)))'+(1*sum(dobj(5:12)))'+(100*sum(dobj(12:25)))'+(1*sum(dobj(25:end)))'; 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if  strcmp(data_name, 'Occipital_anesthesia')
    Prefactor=[50 1 15 1 50 1 30 1];
    Nidx=[3 15 25];
end
%%%%f = (50*sum(obj(1:3)))'+(1*sum(obj(3:15)))'+(15*sum(obj(15:25)))'+(1*sum(obj(25:end)))'+(50*sum(dobj(1:3)))'+(1*sum(dobj(3:15)))'+(30*sum(dobj(15:25)))'+(1*sum(dobj(25:end)))';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if  strcmp(data_name, 'Frontal_wake')
    Prefactor=[15 1 20 1 10 1 20 1];
    Nidx=[10 20 35];
end
%%%%f = (15*sum(obj(1:10)))'+(1*sum(obj(10:20)))'+(20*sum(obj(20:35)))'+(1*sum(obj(35:end)))'+(10*sum(dobj(1:10)))'+(1*sum(dobj(10:20)))'+(20*sum(dobj(20:35)))'+(1*sum(dobj(35:end)))'; 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if  strcmp(data_name, 'Frontal_anesthesia')
    Prefactor=[10 1 20 1 10 1 20 1];
    Nidx=[10 20 35];
%%%%f = (10*sum(obj(1:10)))'+(1*sum(obj(10:20)))'+(20*sum(obj(20:35)))'+(1*sum(obj(35:end)))'+(10*sum(dobj(1:10)))'+(1*sum(dobj(10:20)))'+(20*sum(dobj(20:35)))'+(1*sum(dobj(35:end)))'; 
end
end