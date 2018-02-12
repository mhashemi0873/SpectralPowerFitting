% Hashemi et al, Neuroinformatics 2018

clc
clear
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load Xdata.mat
load Ydata.mat
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
True_params=[0.1 2.0 0.2];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
LowerBound=[0,0,0];            
UpperBound=[10,10,10];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Npnt = length(Xdata);				  
Npar=length(LowerBound);
W=1/(var(Ydata)^2);
%W = (length(Xdata)/sqrt(Ydata'*Ydata));
W=W*ones(1,Npnt);
W=diag(W);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
kappa_hat=0.1032;
Omega_hat=1.9992;
tau_hat=0.2004;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
params_hat=[kappa_hat,Omega_hat,tau_hat];
y_hat=(LSE(func_delaylinear(params_hat,Xdata),Ydata));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ii=1;
for kappa=0:.01:1
    x1(ii)=kappa;
    params=[kappa,Omega_hat,tau_hat];
    y1(ii)=(LSE(func_delaylinear(params,Xdata),Ydata));
    ii=ii+1;
end
Y1=1./(y1/y_hat);

subplot(221)
hold on
plot(x1,Y1,'Linewidth',2)
hold on
xlabel(' $\kappa $','interpreter','latex','fontsize',24)
ylabel(' N.F. ','interpreter','latex','fontsize',20)
xlim([0 1])
ylim([0 1])
set(gca, 'fontsize',16);
box on


startingVals1 = [.1 .1 .1 ];
[bestX1,resids1,J1,COVB1,mse1] =nlinfit(x1,Y1,'Gaussian_dist',startingVals1);
A1=bestX1(1);
mu1=bestX1(2);
sigma1=bestX1(3);
hold on
plot(x1,Gaussian_dist(bestX1,x1),'r--','LineWidth',1.5)
plot(kappa_hat,1,'o','markerf','g','Markersize',10);
box on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ii=1;
for Omega=0:.01:10
    x2(ii)=Omega;
    params=[kappa_hat,Omega,tau_hat];
    y2(ii)=(LSE(func_delaylinear(params,Xdata),Ydata));
    ii=ii+1;
end
Y2=1./(y2/y_hat);

subplot(222)
hold on
plot(x2,Y2,'Linewidth',2)
hold on
xlabel(' $\Omega $','interpreter','latex','fontsize',24)
ylabel(' N.F. ','interpreter','latex','fontsize',20)
xlim([1.5 2.5])
ylim([0 1])
set(gca, 'fontsize',16);


startingVals2 = [2 2 2 ];
[bestX2,resids2,J2,COVB2,mse2] =nlinfit(x2,Y2,'Gaussian_dist',startingVals2);
A2=bestX2(1);
mu2=bestX2(2);
sigma2=bestX2(3);
hold on
plot(x2,Gaussian_dist(bestX2,x2),'r--','LineWidth',1.5)
plot(Omega_hat,1,'o','markerf','g','Markersize',10);
box on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ii=1;
for tau=0:.01:1
    x3(ii)=tau;
    params=[kappa_hat,Omega_hat,tau];
    y3(ii)=(LSE(func_delaylinear(params,Xdata),Ydata));
    ii=ii+1;
end
Y3=1./(y3/y_hat);

subplot(223)
hold on
plot(x3,Y3,'Linewidth',2)
hold on
xlabel(' $\tau $','interpreter','latex','fontsize',24)
ylabel(' N.F.','interpreter','latex','fontsize',20)
xlim([0 1])
ylim([0 1])
set(gca, 'fontsize',16); 


startingVals3 = [.2 .2 .2 ];
 
[bestX3,resids3,J3,COVB3,mse3] =nlinfit(x3,Y3,'Gaussian_dist',startingVals3);
A3=bestX3(1);
mu3=bestX3(2);
sigma3=bestX3(3);
hold on
plot(x3,Gaussian_dist(bestX3,x3),'r--','LineWidth',1.5)
plot(tau_hat,1,'o','markerf','g','Markersize',10);
box on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(224)
Sigma=1./[sigma1 sigma2 sigma3 ];
bar(Sigma,'facecolor',[.8 .8 .8]);
box on
Population = {'$\kappa$','$\Omega$','$\tau$','interpreter','latex'};
set(gca, 'XTickLabel', Population,'fontsize',24);
[hx,hy] = format_ticks(gca,{'$\kappa$','$\Omega$','$\tau$'});
%xlabel('$$ Model~Parameters$$','interpreter','latex','fontsize',20);
ylabel('$$ Std.$$','interpreter','latex','fontsize',20)
set(gca, 'fontsize',16)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(2)
[r1,s1]=min(y1);
subplot(221)
hold on
plot(x1,y1,'Linewidth',2)
hold on
plot(kappa_hat,r1,'dr','markerf','r','Markersize',10);
xlabel(' $\kappa $','interpreter','latex','fontsize',24)
ylabel(' F.F ','interpreter','latex','fontsize',20)
xlim([0 1])
ylim([0 4000])
set(gca, 'fontsize',16);
box on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[r2,s2]=min(y2);
subplot(222)
hold on
plot(x2,y2,'Linewidth',2)
hold on
plot(Omega_hat,r2,'dr','markerf','r','Markersize',10);
xlabel(' $\Omega $','interpreter','latex','fontsize',24)
ylabel(' F.F ','interpreter','latex','fontsize',20)
xlim([1.5 2.5])
ylim([0 4000])
set(gca, 'fontsize',16);
box on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[r3,s3]=min(y3);
subplot(223)
hold on
plot(x3,y3,'Linewidth',2)
hold on
plot(tau_hat,r3,'dr','markerf','r','Markersize',10);
xlabel(' $\tau $','interpreter','latex','fontsize',24)
ylabel(' F.F','interpreter','latex','fontsize',20)
xlim([0 1])
ylim([0 4000])
set(gca, 'fontsize',16); 
box on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Cost_function=@(params_hat)(LSE(func_delaylinear(params_hat,Xdata),Ydata));
[Hes,err] = hessian(Cost_function,params_hat);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Sensitivity_Hess=sqrt([ Hes(1,1) Hes(2,2) Hes(3,3)]);
subplot(224)
bar((Sensitivity_Hess),'facecolor',[.8 .8 .8]); 
box on
Population = {'$\kappa$', '$\Omega$', '$\tau$','interpreter','latex'};
set(gca, 'XTickLabel', Population,'fontsize',24);
set(gca, 'fontsize',16);
[hx,hy] = format_ticks(gca,{'$\kappa$','$\Omega$','$\tau$'});
%xlabel('$$ Model~Parameters$$','interpreter','latex','fontsize',24);
ylabel('$$ Sensitivity$$','interpreter','latex','fontsize',20)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
J=JacobianCentral(@lm_func,Xdata,params_hat);
Jt=J';
H=Jt*W*J;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(3)

Sensitivity_Jac=sqrt([H(1,1) H(2,2) H(3,3)]);
bar(Sensitivity_Jac,'facecolor',[.8 .8 .8]); 
box on
Population = {'$\kappa$', '$\Omega$', '$\tau$','interpreter','latex'};
set(gca, 'XTickLabel', Population,'fontsize',24);
set(gca, 'fontsize',16);
[hx,hy] = format_ticks(gca,{'$\kappa$','$\Omega$','$\tau$'});
%xlabel('$$ Model~Parameters$$','interpreter','latex','fontsize',24);
ylabel('$$ Sensitivity~ using~ Jacobian$$','interpreter','latex','fontsize',20)