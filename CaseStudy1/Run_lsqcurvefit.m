% Hashemi et al, Neuroinformatics 2018

clc
clear
format compact
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load Xdata.mat
load Ydata.mat
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
True_params=[0.1 5.0 3.0];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
LowerBound= [0,0,0];            
UpperBound= [10,10,10];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
x_start=LowerBound+rand(1,length(LowerBound)).*(UpperBound-LowerBound);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
%options = optimset('LevenbergMarquardt','on');
options = optimset('Display','','TolX', 1.0000e-100, 'TolFun', 1.0000e-1000,...
                    'MaxFunEvals', 1000, 'MaxIter', 1000);

options = gaoptimset('PlotFcns',...
  	      {@optimplotx,@optimplotfunccount,@optimplotfval,@optimplotresnorm});
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%tic;
tic;
[Estimated_params,resnorm,residual,exitflag,output,lambda] =lsqcurvefit(@func_dampedoscillator,x_start,Xdata,Ydata,LowerBound,UpperBound,options);  
toc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
FitnessValues=resnorm./((var(Ydata)).^2);
printing_params(Estimated_params)
fprintf('best-fit value is: %d\n ', min(FitnessValues));
plotting_fitting(@func_dampedoscillator, Xdata,Ydata, True_params, Estimated_params, FitnessValues)

