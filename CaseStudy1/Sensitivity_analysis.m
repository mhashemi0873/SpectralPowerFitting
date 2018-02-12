% Hashemi et al, Neuroinformatics 2018

clc
clear
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load Xdata.mat
load Ydata.mat
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
True_params=[0.1 5.0 3.0];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
kappa_hat=0.101;
gamma_hat=4.5;
f0_hat=3.0011;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
params_hat=[kappa_hat,gamma_hat,f0_hat];
y_hat=(LSE(func_dampedoscillator(params_hat,Xdata),Ydata));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ii=1;
for kappa=0:.01:10
    x1(ii)=kappa;
    params=[kappa,gamma_hat,f0_hat];
    y1(ii)=(LSE(func_dampedoscillator(params,Xdata),Ydata));
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
for gamma=0:.1:20
    x2(ii)=gamma;
    params=[kappa_hat,gamma,f0_hat];
    y2(ii)=(LSE(func_dampedoscillator(params,Xdata),Ydata));
    ii=ii+1;
end
Y2=1./(y2/y_hat);

subplot(222)
hold on
plot(x2,Y2,'Linewidth',2)
hold on
xlabel(' $\gamma $','interpreter','latex','fontsize',24)
ylabel(' N.F. ','interpreter','latex','fontsize',20)
xlim([0 20])
ylim([0 1])
set(gca, 'fontsize',16);


startingVals2 = [4 4.5 4 ];
[bestX2,resids2,J2,COVB2,mse2] =nlinfit(x2,Y2,'Gaussian_dist',startingVals2);
A2=bestX2(1);
mu2=bestX2(2);
sigma2=bestX2(3);
hold on
plot(x2,Gaussian_dist(bestX2,x2),'r--','LineWidth',1.5)
plot(gamma_hat,1,'o','markerf','g','Markersize',10);
box on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ii=1;
for omega=0:.1:10
    x3(ii)=omega;
    params=[kappa_hat,gamma_hat,omega];
    y3(ii)=(LSE(func_dampedoscillator(params,Xdata),Ydata));
    ii=ii+1;
end
Y3=1./(y3/y_hat);

subplot(223)
hold on
plot(x3,Y3,'Linewidth',2)
hold on
xlabel(' $f_0 $','interpreter','latex','fontsize',24)
ylabel(' N.F.','interpreter','latex','fontsize',20)
xlim([0 10])
ylim([0 1])
set(gca, 'fontsize',16); 


startingVals3 = [3 3 3 ];
 
[bestX3,resids3,J3,COVB3,mse3] =nlinfit(x3,Y3,'Gaussian_dist',startingVals3);
A3=bestX3(1);
mu3=bestX3(2);
sigma3=bestX3(3);
hold on
plot(x3,Gaussian_dist(bestX3,x3),'r--','LineWidth',1.5)
plot(f0_hat,1,'o','markerf','g','Markersize',10);
box on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(224)
Sigma=1./[sigma1 sigma2 sigma3 ];
bar(Sigma,'facecolor',[.8 .8 .8]);
box on
Population = {'$\kappa$','$\gamma$','$f_0$','interpreter','latex'};
set(gca, 'XTickLabel', Population,'fontsize',24);
[hx,hy] = format_ticks(gca,{'$\kappa$','$\gamma$','$f_0$'});
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
xlim([-1 10])
ylim([0 100])
set(gca, 'fontsize',16);
box on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[r2,s2]=min(y2);
subplot(222)
hold on
plot(x2,y2,'Linewidth',2)
hold on
plot(gamma_hat,r2,'dr','markerf','r','Markersize',10);
xlabel(' $\gamma $','interpreter','latex','fontsize',24)
ylabel(' F.F ','interpreter','latex','fontsize',20)
xlim([0 10])
ylim([0 100])
set(gca, 'fontsize',16);
box on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[r3,s3]=min(y3);
subplot(223)
hold on
plot(x3,y3,'Linewidth',2)
hold on
plot(f0_hat,r3,'dr','markerf','r','Markersize',10);
xlabel(' $f_0 $','interpreter','latex','fontsize',24)
ylabel(' F.F','interpreter','latex','fontsize',20)
xlim([0 10])
ylim([0 100])
set(gca, 'fontsize',16); 
box on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Cost_function=@(params_hat)(LSE(func_dampedoscillator(params_hat,Xdata),Ydata));
[Hes,err] = hessian(Cost_function,params_hat);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Sensitivity_Hess=sqrt([ Hes(1,1) Hes(2,2) Hes(3,3)]);
subplot(224)
bar((Sensitivity_Hess),'facecolor',[.8 .8 .8]); 
box on
Population = {'$\kappa$', '$\gamma$', '$f_0$','interpreter','latex'};
set(gca, 'XTickLabel', Population,'fontsize',24);
set(gca, 'fontsize',16);
[hx,hy] = format_ticks(gca,{'$\kappa$','$\gamma$','$f_0$'});
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
Population = {'$\kappa$', '$\Omega$', '$f_0$','interpreter','latex'};
set(gca, 'XTickLabel', Population,'fontsize',24);
set(gca, 'fontsize',16);
[hx,hy] = format_ticks(gca,{'$\kappa$','$\gamma$','$f_0$'});
%xlabel('$$ Model~Parameters$$','interpreter','latex','fontsize',24);
ylabel('$$ Sensitivity~ using~ Jacobian$$','interpreter','latex','fontsize',20)