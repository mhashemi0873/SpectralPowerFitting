function [Samples,FitnessValues] = MH(y,x0,genfunc,LB,UB,Total_run,Burnin_run)

N=length(y);
d=length(x0);

p=x0;
xhi0=((feval(genfunc,x0)));

oldp=x0;
oldxhi=xhi0;

for i=1:Total_run+Burnin_run
    
    for k=1:d
        
        p(k)=oldp(k)+randn;
        xhi=((feval(genfunc,p)));
        
        p(k) = max(min(p(k),UB(k)),LB(k));

        delta_xhi=xhi-oldxhi;
        r=min(1,exp(-delta_xhi));

        if(rand<=r)
           oldp(k)=p(k);
           oldxhi=xhi;
        else
           p(k)=oldp(k);
           xhi=oldxhi;
        end
        
    end
    
    FitnessValues(i)=feval(genfunc,p);
    keepp(i,:)=oldp;
    
end 

Samples=keepp(1:end,:);




