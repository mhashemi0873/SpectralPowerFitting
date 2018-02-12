% Hashemi et al, Neuroinformatics 2018

clc
clear
format compact
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load Xdata;
load Ydata;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Prefactor=[50 1 20 1 100 1 100 1];
Nidx=[60 170 420];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
LowerBound=[1,0.01,5,5,.1,.1,.1];            
UpperBound=[40,.06,150,150,10,10,10]; 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Npnt = length(Xdata);				 
Nparam=length(LowerBound);
W=1/(var(Ydata)^2);
%W = (length(Xdata)/sqrt(Ydata'*Ydata));
W=W*ones(1,Npnt);
W=diag(W);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
D_hat =27.0183;
tau_hat = 0.0408;
beta_e_hat = 69.1045;
beta_i_hat = 8.9958;
G_ese_hat =0.6852;
G_srs_hat = 0.4538;
G_esre_hat = 0.135;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
param_hat=[D_hat,tau_hat,beta_e_hat,beta_i_hat,G_ese_hat,G_srs_hat,G_esre_hat];
y_hat=LSE_biased(myfunc(param_hat,Xdata),param_hat,Xdata,Ydata,Prefactor,Nidx);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ii=1;
for D=0:1:100
    x1(ii)=D;
    param=[D,tau_hat,beta_e_hat,beta_i_hat,G_ese_hat,G_srs_hat,G_esre_hat];
    y1(ii)=LSE_biased(myfunc(param,Xdata),param,Xdata,Ydata,Prefactor,Nidx);
    ii=ii+1;
end
Y1=1./(y1/y_hat);

subplot(421)
hold on
plot(x1,Y1,'Linewidth',2)
hold on
xlabel(' $D $','interpreter','latex','fontsize',14)
ylabel(' N.F. ','interpreter','latex','fontsize',14)
%ylim([0 1])
set(gca, 'fontsize',12);

startingVals1 = [30 30 10 ];
[bestX1,resids1,J1,COVB1,mse1] =nlinfit(x1(1:35),Y1(1:35),'Gaussian_dist',startingVals1);
A1=bestX1(1);
mu1=bestX1(2);
sigma1=bestX1(3);
hold on
plot(x1,Gaussian_dist(bestX1,x1),'r--','LineWidth',2)
plot(D_hat,1,'o','markerf','g','Markersize',8);
box on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ii=1;
for tau=0:.001:.1
    x2(ii)=tau;
    param=[D_hat,tau,beta_e_hat,beta_i_hat,G_ese_hat,G_srs_hat,G_esre_hat];
    y2(ii)=LSE_biased(myfunc(param,Xdata),param,Xdata,Ydata,Prefactor,Nidx);

    ii=ii+1;
end
Y2=1./(y2/y_hat);


subplot(422)
hold on
plot(x2,Y2,'Linewidth',2)
hold on
xlabel(' $\tau $','interpreter','latex','fontsize',14)
ylabel(' N.F. ','interpreter','latex','fontsize',14)
%ylim([0 1])
set(gca, 'fontsize',12);

startingVals2 = [.01 0.04 .01 ];
[bestX2,resids2,J2,COVB2,mse2] =nlinfit(x2,Y2,'Gaussian_dist',startingVals2);
A2=bestX2(1);
mu2=bestX2(2);
sigma2=bestX2(3);
hold on
plot(x2,Gaussian_dist(bestX2,x2),'r--','LineWidth',2)
plot(tau_hat,1,'o','markerf','g','Markersize',8);
box on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ii=1;
for beta_e=0:1:200
    x3(ii)=beta_e;
    param=[D_hat,tau_hat,beta_e,beta_i_hat,G_ese_hat,G_srs_hat,G_esre_hat];
    y3(ii)=LSE_biased(myfunc(param,Xdata),param,Xdata,Ydata,Prefactor,Nidx);

    ii=ii+1;
end
Y3=1./(y3/y_hat);


subplot(423)
hold on
plot(x3,Y3,'Linewidth',2)
hold on
xlabel(' $\beta_e $','interpreter','latex','fontsize',14)
ylabel(' N.F.','interpreter','latex','fontsize',14)
%ylim([0 1])
set(gca, 'fontsize',12); 

 
startingVals3 = [30 70 10 ];
 
[bestX3,resids3,J3,COVB3,mse3] =nlinfit(x3(1:80),Y3(1:80),'Gaussian_dist',startingVals3);
A3=bestX3(1);
mu3=bestX3(2);
sigma3=bestX3(3);
hold on
plot(x3,Gaussian_dist(bestX3,x3),'r--','LineWidth',2)
plot(beta_e_hat,1,'o','markerf','g','Markersize',8);
box on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ii=1;
for beta_i=0:1:100
    x4(ii)=beta_i;
    param=[D_hat,tau_hat,beta_e_hat,beta_i,G_ese_hat,G_srs_hat,G_esre_hat];
    y4(ii)=LSE_biased(myfunc(param,Xdata),param,Xdata,Ydata,Prefactor,Nidx);

    ii=ii+1;
end
Y4=1./(y4/y_hat);


subplot(424)
hold on
plot(x4,Y4,'Linewidth',2)
hold on
xlabel(' $\beta_i $','interpreter','latex','fontsize',14)
ylabel(' N.F.','interpreter','latex','fontsize',14)
ylim([0 1])

set(gca, 'fontsize',12);

startingVals4 = [30 10 10 ];
[bestX4,resids4,J4,COVB4,mse4] =nlinfit(x4(1:18),Y4(1:18),'Gaussian_dist',startingVals4);
A4=bestX4(1);
mu4=bestX4(2);
sigma4=bestX4(3);
hold on
plot(x4,Gaussian_dist(bestX4,x4),'r--','LineWidth',2)
plot(beta_i_hat,round(max(Y4)),'o','markerf','g','Markersize',8);
box on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ii=1;
for  G_ese=0:.01:5
    x5(ii)=G_ese;
    param=[D_hat,tau_hat,beta_e_hat,beta_i_hat,G_ese,G_srs_hat,G_esre_hat];
    y5(ii)=LSE_biased(myfunc(param,Xdata),param,Xdata,Ydata,Prefactor,Nidx);

    ii=ii+1;
end
Y5=1./(y5/y_hat);

subplot(425)
hold on
plot(x5,Y5,'Linewidth',2)
hold on
xlabel(' $G_{ese} $','interpreter','latex','fontsize',14)
ylabel(' N.F. ','interpreter','latex','fontsize',14)
ylim([0 1])
set(gca, 'fontsize',12);

startingVals5 = [30 .6 10 ];
[bestX5,resids5,J5,COVB5,mse5] =nlinfit(x5(1:300),Y5(1:300),'Gaussian_dist',startingVals5);
A5=bestX5(1);
mu5=bestX5(2);
sigma5=bestX5(3);
hold on
plot(x5,Gaussian_dist(bestX5,x5),'r--','LineWidth',2)
plot(G_ese_hat,round(max(Y5)),'o','markerf','g','Markersize',8);
box on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ii=1;
for G_srs=0:.01:5
    x6(ii)=G_srs;
    param=[D_hat,tau_hat,beta_e_hat,beta_i_hat,G_ese_hat,G_srs,G_esre_hat];
    y6(ii)=LSE_biased(myfunc(param,Xdata),param,Xdata,Ydata,Prefactor,Nidx);

    ii=ii+1;
end
Y6=1./(y6/y_hat);

subplot(426)
hold on
plot(x6,Y6,'Linewidth',2)
hold on
xlabel(' $G_{srs} $','interpreter','latex','fontsize',14)
ylabel(' N.F. ','interpreter','latex','fontsize',14)
ylim([0 1])
set(gca, 'fontsize',12);

startingVals6 = [30 .4 10 ];
[bestX6,resids6,J1,COVB6,mse6] =nlinfit(x6(1:90),Y6(1:90),'Gaussian_dist',startingVals6);
A6=bestX6(1);
mu6=bestX6(2);
sigma6=bestX6(3);
hold on
plot(x6,Gaussian_dist(bestX6,x6),'r--','LineWidth',2)
plot(G_srs_hat,round(max(Y6)),'o','markerf','g','Markersize',8);
box on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ii=1;
for G_esre=0:.01:2
    x7(ii)=G_esre;
    param=[D_hat,tau_hat,beta_e_hat,beta_i_hat,G_ese_hat,G_srs_hat,G_esre];
    y7(ii)=LSE_biased(myfunc(param,Xdata),param,Xdata,Ydata,Prefactor,Nidx);

    ii=ii+1;
end
Y7=1./(y7/y_hat);
G_esre_hat=0.1;

subplot(427)
hold on
plot(x7,Y7,'Linewidth',2)
hold on
xlabel(' $G_{esre} $','interpreter','latex','fontsize',14)
ylabel(' N.F. ','interpreter','latex','fontsize',12)
ylim([0 1])
set(gca, 'fontsize',12);

startingVals7 = [30 .1 10 ];
[bestX7,resids7,J7,COVB7,mse7] =nlinfit(x7(1:35),Y7(1:35),'Gaussian_dist',startingVals7);
A7=bestX7(1);
mu7=bestX7(2);
sigma7=bestX7(3);
hold on
plot(x7,Gaussian_dist(bestX7,x7),'r--','LineWidth',2)
plot(G_esre_hat,round(max(Y7)),'o','markerf','g','Markersize',8);
box on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(428)
sigma4=6.;
sigma7=.23;
Sigma=1./[sigma1 sigma2 sigma3 sigma4 sigma5 sigma6 sigma7];

bar(Sigma,'facecolor',[.7 .7 .7]);
box on
Population = {'\sigma_1', '\sigma_2', '\sigma_3','\sigma_4','\sigma_5','\sigma_6','\sigma_7','interpreter','latex'};
set(gca, 'XTickLabel', Population,'fontsize',14);

%[hx,hy] = format_ticks(gca,{'D','\tau','\beta_e','\beta_i','G_{ese}','G_{srs}','G_{esre}'});
set( gca(), 'XTickLabel', Population )
rotateXLabels( gca(), 0 )
xlabel('$$ Model~paramameters$$','interpreter','latex','fontsize',14);
ylabel('$$ Std.$$','interpreter','latex','fontsize',14)
set(gca, 'fontsize',12);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(2)
[r1,s1]=min(y1);
subplot(421)
hold on
plot(x1,y1,'Linewidth',2)
hold on
plot(D_hat,r1,'dr','markerf','r','Markersize',8);
xlabel(' $D$','interpreter','latex','fontsize',14)
ylabel(' F.F ','interpreter','latex','fontsize',12)
ylim([0 5000])
set(gca, 'fontsize',14);
box on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[r2,s2]=min(y2);
subplot(422)
hold on
plot(x2,y2,'Linewidth',2)
hold on
plot(tau_hat,r2,'dr','markerf','r','Markersize',8);
xlabel(' $\tau $','interpreter','latex','fontsize',14)
ylabel(' F.F ','interpreter','latex','fontsize',12)
ylim([0 4000])
set(gca, 'fontsize',12);
box on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[r3,s3]=min(y3);
subplot(423)
hold on
plot(x3,y3,'Linewidth',2)
hold on
plot(beta_e_hat,r3,'dr','markerf','r','Markersize',8);
xlabel(' $\beta_e $','interpreter','latex','fontsize',14)
ylabel(' F.F','interpreter','latex','fontsize',12)
ylim([0 5000])
set(gca, 'fontsize',12); 
box on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[r4,s4]=min(y4);
subplot(424)
hold on
plot(x4,y4,'Linewidth',2)
hold on
plot(beta_i_hat,r4,'dr','markerf','r','Markersize',8);
xlabel(' $\beta_i $','interpreter','latex','fontsize',14)
ylabel(' F.F','interpreter','latex','fontsize',12)
ylim([0 2000])
set(gca, 'fontsize',12); 
box on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[r5,s5]=min(y5);
subplot(425)
hold on
plot(x5,y5,'Linewidth',2)
hold on
plot(G_ese_hat,r5,'dr','markerf','r','Markersize',8);
xlabel(' $G_{ese} $','interpreter','latex','fontsize',14)
ylabel(' F.F','interpreter','latex','fontsize',12)
ylim([0 1300])
set(gca, 'fontsize',14); 
box on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[r6,s6]=min(y6);
subplot(426)
hold on
plot(x6,y6,'Linewidth',2)
hold on
plot(G_srs_hat,r6,'dr','markerf','r','Markersize',8);
xlabel(' $G_{srs} $','interpreter','latex','fontsize',14)
ylabel(' F.F','interpreter','latex','fontsize',12)
ylim([0 2000])
set(gca, 'fontsize',12); 
box on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[r7,s7]=min(y7);
subplot(427)
hold on
plot(x7,y7,'Linewidth',2)
hold on
plot(G_esre_hat,r4,'dr','markerf','r','Markersize',8);
xlabel(' $G_{esre} $','interpreter','latex','fontsize',14)
ylabel(' F.F','interpreter','latex','fontsize',12)
ylim([0 800])
set(gca, 'fontsize',12); 
box on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Fitness_function=@(param)    LSE_biased(myfunc(param,Xdata),param, Xdata,Ydata,Prefactor,Nidx);

[Hes,err] = hessian(Fitness_function,param_hat);

Sensitivity=sqrt([ Hes(1,1) Hes(2,2) Hes(3,3) Hes(4,4)  Hes(5,5)  Hes(6,6) Hes(7,7)]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(428)
bar(Sensitivity,'facecolor',[.7 .7 .7]); 
box on
Population = {'D', '\tau', '\beta_e','\beta_i','G_{ese}','G_{srs}','G_{esre}','interpreter','latex'};
set(gca, 'XTickLabel', Population,'fontsize',10);

%[hx,hy] = format_ticks(gca,{'D','\tau','\alpha','\beta','G_{ese}','G_{srs}','G_{esre}'});
set( gca(), 'XTickLabel', Population )
rotateXLabels( gca(), 60 )
xlabel('$$ Model~paramameters$$','interpreter','latex','fontsize',12);
ylabel('$$ Sen.$$','interpreter','latex','fontsize',14)
set(gca, 'fontsize',14);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
S1=1./[ sigma1  sigma3 sigma4 0 0 0  ];
S2=1./[ sigma5 sigma6  sigma7];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Sensitivity1=sqrt([ Hes(1,1)  Hes(3,3) Hes(4,4)  0 0 0]);
Sensitivity2=sqrt([ Hes(5,5) Hes(6,6) Hes(7,7) ]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x1=[1 2 3 4 5 6];
x2=[4 5 6];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(3)
subplot(211)
[ax,h1,h2] = plotyy(x1, Sensitivity1,x2, Sensitivity2, 'bar', 'bar');
set(h1, 'FaceColor', [0 0 1], 'BarWidth', .6)
set(h2, 'FaceColor', [1 0 0], 'BarWidth', .8)
set(gca, 'XTickLabel', [])
box on
Population = {'D', '\beta_e','\beta_i','G_{ese}','G_{srs}','G_{esre}','interpreter','latex'};
set( ax(1), 'XTickLabel', [] )
set( ax(2), 'XTickLabel', [] )
set( ax(1), 'XTickLabel', Population,'fontsize',14 )
rotateXLabels( gca(), 45 ) 
set(ax(1),'XColor','k','YColor',[0 0 1], 'fontsize',24);
set(ax(2),'XColor','k','YColor',[1 0 0], 'fontsize',24);
%xlabel('$$ Model~paramameters$$','interpreter','latex','fontsize',16);
set(get(ax(1),'Ylabel'),'String','$$ Sensitivity$$','Interpreter','latex','fontsize',24)
set(get(ax(2),'Ylabel'),'String','$$ Sensitivity$$','Interpreter','latex','fontsize',24)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(212)
[ax,h1,h2] = plotyy(x1, S1,x2, S2, 'bar', 'bar');
set(h1, 'FaceColor', [0 0 1], 'BarWidth', .6)
set(h2, 'FaceColor', [1 0 0], 'BarWidth', .8)
set(gca, 'XTickLabel', [])
box on

Population = {'D', '\beta_e','\beta_i','G_{ese}','G_{srs}','G_{esre}','interpreter','latex'};
set( ax(1), 'XTickLabel', [] )
set( ax(2), 'XTickLabel', [] )
set( ax(1), 'XTickLabel', Population,'fontsize',14 )
rotateXLabels( gca(), 45 )
set(ax(1),'XColor','k','YColor',[0 0 1], 'fontsize',24);
set(ax(2),'XColor','k','YColor',[1 0 0], 'fontsize',24);
%xlabel('$$ Model~paramameters$$','interpreter','latex','fontsize',16);
set(get(ax(1),'Ylabel'),'String','$$ Std.$$','Interpreter','latex','fontsize',24)
set(get(ax(2),'Ylabel'),'String','$$ Std.$$','Interpreter','latex','fontsize',24)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

