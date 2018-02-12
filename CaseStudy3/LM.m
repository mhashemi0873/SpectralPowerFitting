function[p_est,Fitness]=LM(func,Xdata,p_int,p_min,p_max,Ydata,W,lambda,L1,L2,epsilon,maxiter)

p_int=p_int(:);  	
p_min=p_min(:); 
p_max=p_max(:); 	
 
Nparams=length(p_int);

Fitness=zeros(1,maxiter);
p_est=zeros(Nparams,maxiter);

iteration=1;

e= 1e8;			
e_old = e;					
p=p_int;

while iteration<maxiter+1;
    
J=JacobianCentral(func,Xdata,p);

y_hat=func(Xdata,p);

Jt=J';
H=Jt*W*J;
dy=Ydata-y_hat;

    h=(H+lambda*diag(diag(Jt*W*J)))\((Jt*dy));

    p_new = p + h;                     
    p_new = min(max(p_min,p_new),p_max);         
    f_new=func(Xdata,p_new);
    e_new=LSE(f_new,Ydata);
    
    rho = (e - e_new) / ( 2*h' * (lambda * h + Jt*W*dy) );
     
    if rho> epsilon
    lambda = lambda/L2;
 	e_old = e;
  	p = p_new;
    else	
    lambda = lambda*L1;
    e = e_old;			
    p_new=p;
    end
   
    Fitness(iteration)=e_new;
    p_est(:,iteration)=p;    
    iteration=iteration+1;
end

end
