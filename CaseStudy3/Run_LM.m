% Hashemi et al, Neuroinformatics 2018

clc
clear
format compact
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
data_name = 'Occipital_wake';
load (data_name)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
LowerBound=[1,0.01,5,5,.1,.1,.1];            
UpperBound=[40,.06,150,150,10,10,10]; 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x_start=LowerBound+rand(1,length(LowerBound)).*(UpperBound-LowerBound);
%x_start=[30 .04 70 10 1 1 .1 ];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
lambda0=0.001;
L1=11;
L2=9;
epsilon=1e-2; 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Nd=length(Ydata);
W =(length(Xdata)/sqrt(Ydata'*Ydata))*ones(1,Nd);
W=diag(W);
maxiter=1000;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tic;
[Estimated_params,FitnessValues]=LM(@lm_func,Xdata,x_start,LowerBound,UpperBound,Ydata,W,lambda0,L1,L2,epsilon,maxiter);
toc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
printing_params(Estimated_params(:,end))
fprintf('best-fit value is: %d\n ', min(FitnessValues));
CheckStability(data_name, Estimated_params)
plotting_fitting(@myfunc, Xdata,Ydata, [], Estimated_params, FitnessValues)


