% Hashemi et al, Neuroinformatics 2018

clc
clear all
close all
global FITNESS_PS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
data_name = 'Occipital_wake';
load (data_name)
[Prefactor,Nidx]= BiasedWeights(data_name);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
LowerBound=[1,0.01,5,5,.1,.1,.1];            
UpperBound=[40,.06,150,150,10,10,10];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
FitnessFunction=@(param) LSE_penalty(lm_func(Xdata,param),param,Xdata,Ydata,Prefactor,Nidx);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
numberOfVariables=length(LowerBound);
A=[];
b=[];
Aineq=[];
bineq=[];
Aeq=[];
beq=[];
nonlcon= [] ;
% Aineq		          = [0 0  0  0  0  0  0;
%                        0 0  0  0  0  0  0;
%                        0 0 -1  1  0  0  0;
%                        0 0  0  0  0  0  0;
%                        0 0  0  0  1 -1 -1;
%                        0 0  0  0  0  0  0;
%                        0 0  0  0  0  0  0];
%                    
% bineq		= [0;0;0;0;1;0;0];
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
CheckStability(data_name, Estimated_params)
plotting_fitting(@myfunc, Xdata,Ydata, [], Estimated_params, FitnessValues)

