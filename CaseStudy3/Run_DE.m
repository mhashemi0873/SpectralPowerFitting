% Hashemi et al, Neuroinformatics 2018

clc
clear
format compact
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
data_name = 'Occipital_wake';
load (data_name)
[Prefactor,Nidx]= BiasedWeights(data_name);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
LowerBound=[1,0.01,5,5,.1,.1,.1];            
UpperBound=[40,.06,150,150,10,10,10];           
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Np=length(LowerBound);
Nd=length(Xdata);
Maxiter=1000;
tolerance=0.001;
problem_parameters=[Np,Maxiter,tolerance];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Ns=100;
CR=0.2368;
F=0.6702;
behavioral_parameters=[Ns,CR,F];   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
FitnessFunction=@(param)(LSE_penalty(myfunc(param,Xdata),param,Xdata,Ydata,Prefactor,Nidx));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%tic;
tic;
[Estimated_params, FitnessValues] = DE(FitnessFunction, LowerBound, UpperBound,problem_parameters, behavioral_parameters);
toc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%True_params=[0.1 5.0 3.0];
printing_params(Estimated_params)
fprintf('best-fit value is: %d\n ', min(FitnessValues));
CheckStability(data_name, Estimated_params)
plotting_fitting(@myfunc, Xdata,Ydata, [], Estimated_params, FitnessValues)

