% Hashemi et al, Neuroinformatics 2018

clc
clear all
close all
global FITNESS_PS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load Xdata.mat
load Ydata.mat
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
True_params=[0.1 5.0 3.0];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
LowerBound=[0,0,0];            
UpperBound=[10,10,10];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
FitnessFunction=@(param) LSE(func_dampedoscillator(param,Xdata),Ydata);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
numberOfVariables=length(LowerBound);
A=[];
b=[];
Aeq=[];
beq=[];
nonlcon=[]; 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x_start=LowerBound+rand(1,length(LowerBound)).*(UpperBound-LowerBound);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%      
options = psoptimset( 'Display','iter','OutputFcn',@outputfcn_PS,...
                      'MaxIter',1000, 'MaxFunEvals',Inf,...
                      'TimeLimit',inf,'TolBind',1e-100,'TolCon',1e-100,'TolFun',1e-100,'TolMesh',1e-100,'TolX',1e-100,...
                      'PlotInterval',1,'PlotFcn',...
                       {@psplotbestf, @psplotmeshsize,@psplotfuncount,@psplotbestx});
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tic;
[Estimated_params,fval,exitflag,output]=patternsearch(FitnessFunction,x_start,A,b,Aeq,beq,LowerBound,UpperBound,nonlcon,options);
toc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fprintf('The number of generations was : %d\n', output.iterations);
fprintf('The number of function evaluations was : %d\n', output.funccount);
fprintf('The best function value found was : %g\n', fval);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
FitnessValues=[FitnessFunction(x_start) FITNESS_PS];
printing_params(Estimated_params)
fprintf('best-fit value is: %d\n ', min(FitnessValues));
plotting_fitting(@func_dampedoscillator, Xdata,Ydata, True_params, Estimated_params, FitnessValues)

