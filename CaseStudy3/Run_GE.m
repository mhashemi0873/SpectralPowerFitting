% Hashemi et al, Neuroinformatics 2018

clc
clear all
close all

global FITNESS_GA
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
data_name = 'Occipital_wake';
load (data_name)
[Prefactor,Nidx]= BiasedWeights(data_name);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
LowerBound=[1,0.01,5,5,.1,.1,.1];            
UpperBound=[40,.06,150,150,10,10,10];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
FitnessFunction=@(param) LSE_penalty(lm_func(Xdata,param),param,Xdata,Ydata,Prefactor,Nidx);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
numberOfVariables=length(LowerBound);
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
opts = gaoptimset('PlotFcns',...
  	             {@gaplotbestf,@gaplotbestindiv,@gaplotstopping,@gaplotdistance});
hybridopts = @fmincon;
opts = gaoptimset(opts,'Display','iter','OutputFcn',@outputfcn_GA,...
                       'PopulationSize',200,'Generations',200,'FitnessLimit',-inf,...
                       'TimeLimit',inf,'StallGenLimit', 1000,'StallTimeLimit',120,...
                       'TolFun',1e-10,'TolCon',1e-10,...
                       'HybridFcn',{@fminunc,hybridopts});
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tic;
[Estimated_params,fval,reason,Output,population,scores]= ga(FitnessFunction,numberOfVariables,Aineq,bineq,Aeq,beq,LowerBound,UpperBound,nonlcon,opts);
toc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fprintf('The number of generations was : %d\n', Output.generations);
fprintf('The number of function evaluations was : %d\n', Output.funccount);
fprintf('The best function value found was : %g\n', fval);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
FitnessValues=FITNESS_GA;
printing_params(Estimated_params)
fprintf('best-fit value is: %d\n ', min(FitnessValues));
CheckStability(data_name, Estimated_params)
plotting_fitting(@myfunc, Xdata,Ydata, [], Estimated_params, FitnessValues)


