% Hashemi et al, Neuroinformatics 2018

clc
clear
close all
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
nVar=7;                
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
data_name = 'Occipital_wake';
load (data_name)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
LowerBound=[1,0.01,5,5,.1,.1,.1];            
UpperBound=[40,.06,150,150,10,10,10]; 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
opts.LBounds = 0; opts.UBounds = 200; 
opts.DispModulo=Inf;
opts.DispFinal='off';
opts.LogTime=100;
opts.StopFitness=1e-20;
opts.TolFun=1e-20;
opts.TolHistFun=1e-20;
opts.TolX=1e-20;
opts.StopOnStagnation='off';
opts.StopOnWarnings='no';
%opts.Noise.on = 1
opts.MaxIter=1000;
X0=opts.LBounds+(opts.UBounds-opts.LBounds)*rand(nVar,1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tic;
[Estimated_params,fmin,counteval,stopflag,out,bestever]=cmaes('LSE2', X0, 1.5,opts)
toc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
load outcmaesxrecentbest.dat
output=outcmaesxrecentbest;
Iter=output(:,2);
FitnessValues=output(:,3);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
printing_params(Estimated_params)
fprintf('best-fit value is: %d\n ', min(FitnessValues));
CheckStability(data_name, Estimated_params)
plotting_fitting(@myfunc, Xdata,Ydata, [], Estimated_params, FitnessValues)
