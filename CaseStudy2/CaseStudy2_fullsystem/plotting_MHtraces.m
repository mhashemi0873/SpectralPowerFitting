function [] = plotting_MHtraces(Samples, Estimated_params, LowerBound,UpperBound,Total_run,Burnin_run)

figure()
subplot(221)
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
subplot(222)
plot(Samples(:,2),'b--','Linewidth',2)
hold on
plot([0 Total_run+Burnin_run],[Estimated_params(2) Estimated_params(2)],'r','Linewidth',2)
hold on
plot([Burnin_run Burnin_run],[-LowerBound(2)-10 UpperBound(2)],'g--','Linewidth',2)
xlabel('Iteration','fontsize',14);ylabel('$a$','interpreter','latex', 'fontsize',18);
ylim([-30 -5]);
set(gca, 'fontsize',14);   
box on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(223)
plot(Samples(:,3),'b--','Linewidth',2)
hold on
plot([0 Total_run+Burnin_run],[Estimated_params(3) Estimated_params(3)],'r','Linewidth',2)
hold on
plot([Burnin_run Burnin_run],[-LowerBound(3)-10 UpperBound(3)],'g--','Linewidth',2)
xlabel('Iteration','fontsize',14);ylabel('$b$', 'interpreter','latex', 'fontsize',18);
ylim([-30 -5]);
set(gca, 'fontsize',16);
box on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(224)
plot(Samples(:,4),'b--','Linewidth',2)
hold on
plot([0 Total_run+Burnin_run],[Estimated_params(4) Estimated_params(4)],'r','Linewidth',2)
hold on
plot([Burnin_run Burnin_run],[-LowerBound(4)-10 UpperBound(4)],'g--','Linewidth',2)
xlabel('Iteration','fontsize',14);ylabel('$\tau$', 'interpreter','latex', 'fontsize',18);
ylim([0 0.4]);
set(gca, 'fontsize',16);
box on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure()
subplot(221)
hist(Samples(:,1))
ylabel('$\kappa$', 'interpreter','latex', 'fontsize',18);
set(gca, 'fontsize',14);  
box on
subplot(222)
hist(Samples(:,2))
ylabel('$a$', 'interpreter','latex', 'fontsize',18);
set(gca, 'fontsize',14);
subplot(223)
hist(Samples(:,3))
ylabel('$b$', 'interpreter','latex', 'fontsize',18);
set(gca, 'fontsize',14);
subplot(224)
hist(Samples(:,4))
ylabel('$\tau$', 'interpreter','latex', 'fontsize',18);
set(gca, 'fontsize',14);
end
