function [] = plotting_MHtraces(Samples, Estimated_params, LowerBound,UpperBound,Total_run,Burnin_run)

figure()
subplot(311)
plot(Samples(:,1),'b--','Linewidth',2)
hold on
plot([0 Total_run+Burnin_run],[Estimated_params(1) Estimated_params(1)],'r','Linewidth',2)
hold on
plot([Burnin_run Burnin_run],[-LowerBound(1)-10 UpperBound(1)],'g--','Linewidth',2)
xlabel('Iteration','fontsize',14);ylabel('$\kappa$', 'interpreter','latex','fontsize',18);
ylim([0. 0.2]);
set(gca, 'fontsize',14);  
box on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(312)
plot(Samples(:,2),'b--','Linewidth',2)
hold on
plot([0 Total_run+Burnin_run],[Estimated_params(2) Estimated_params(2)],'r','Linewidth',2)
hold on
plot([Burnin_run Burnin_run],[-LowerBound(2)-10 UpperBound(2)],'g--','Linewidth',2)
xlabel('Iteration','fontsize',14);ylabel('$\gamma$','interpreter','latex', 'fontsize',18);
ylim([0 15]);
set(gca, 'fontsize',14);   
box on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(313)
plot(Samples(:,3),'b--','Linewidth',2)
hold on
plot([0 Total_run+Burnin_run],[Estimated_params(3) Estimated_params(3)],'r','Linewidth',2)
hold on
plot([Burnin_run Burnin_run],[-LowerBound(3)-10 UpperBound(3)],'g--','Linewidth',2)
xlabel('Iteration','fontsize',14);ylabel('$f_0$', 'interpreter','latex', 'fontsize',18);
ylim([2 4]);
set(gca, 'fontsize',16);
box on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure()
subplot(311)
hist(Samples(:,1))
ylabel('$\kappa$', 'interpreter','latex', 'fontsize',18);
set(gca, 'fontsize',14);  
box on
subplot(312)
hist(Samples(:,2))
ylabel('$\gamma$', 'interpreter','latex', 'fontsize',18);
set(gca, 'fontsize',14);
subplot(313)
hist(Samples(:,3))
ylabel('$f_0$', 'interpreter','latex', 'fontsize',18);
set(gca, 'fontsize',14);
end
