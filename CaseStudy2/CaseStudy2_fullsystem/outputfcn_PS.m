function [stop, options ,optchanged] = outputfcn_PS(optimvalues,options,flag)

global FITNESS_PS

optchanged = false;

stop = false;

switch flag
case 'iter'

Fitness= optimvalues.fval;
Itr=optimvalues.iteration;

FITNESS_PS (Itr)=Fitness;
 
end
