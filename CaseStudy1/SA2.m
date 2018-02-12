function [Samples,FitnessValues] = SA2(y,x0,genfunc,LB,UB,Total_run,Burnin_run)

t0 = 10;
tend = .000000001;
frac = (tend/t0)^(1.0/(Total_run-1.0));
T= t0;

N=length(y);
d=length(x0);

p=x0;
xhi=(feval(genfunc,p));


for i=1:Total_run+Burnin_run
    
    for k=1:d
        
            oldp=p;
            oldxhi=xhi;

            p(k)=p(k)+randn;
            xhi=(feval(genfunc,p));
        
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
    
    T = frac * T;

    FitnessValues(i)=feval(genfunc,p);
    keepp(i,:)=p;    
end
Samples=keepp(1:end,:);




