function [] = plotting_MHtraces(Samples, Estimated_params, LowerBound,UpperBound,Total_run,Burnin_run)

figure()
subplot(421)
plot(Samples(:,1),'b--','Linewidth',2)
hold on
plot([0 Total_run+Burnin_run],[Estimated_params(1) Estimated_params(1)],'r','Linewidth',2)
hold on
plot([Burnin_run Burnin_run],[-LowerBound(1)-10 UpperBound(1)],'g--','Linewidth',2)
xlabel('Iteration','fontsize',14);ylabel('$D$', 'interpreter','latex','fontsize',18);
%ylim([0. 20]);
set(gca, 'fontsize',14);  
box on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(422)
plot(Samples(:,2),'b--','Linewidth',2)
hold on
plot([0 Total_run+Burnin_run],[Estimated_params(2) Estimated_params(2)],'r','Linewidth',2)
hold on
plot([Burnin_run Burnin_run],[-LowerBound(2)-10 UpperBound(2)],'g--','Linewidth',2)
xlabel('Iteration','fontsize',14);ylabel('$\tau$','interpreter','latex', 'fontsize',18);
%ylim([0 .1]);
set(gca, 'fontsize',14);   
box on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(423)
plot(Samples(:,3),'b--','Linewidth',2)
hold on
plot([0 Total_run+Burnin_run],[Estimated_params(3) Estimated_params(3)],'r','Linewidth',2)
hold on
plot([Burnin_run Burnin_run],[-LowerBound(3)-10 UpperBound(3)],'g--','Linewidth',2)
xlabel('Iteration','fontsize',14);ylabel('$\beta_e$', 'interpreter','latex', 'fontsize',18);
%ylim([50 150]);
set(gca, 'fontsize',16);
box on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(424)
plot(Samples(:,4),'b--','Linewidth',2)
hold on
plot([0 Total_run+Burnin_run],[Estimated_params(4) Estimated_params(4)],'r','Linewidth',2)
hold on
plot([Burnin_run Burnin_run],[-LowerBound(4)-10 UpperBound(4)],'g--','Linewidth',2)
xlabel('Iteration','fontsize',14);ylabel('$\beta_i$', 'interpreter','latex', 'fontsize',18);
%ylim([0 200]);
set(gca, 'fontsize',16);
box on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(425)
plot(Samples(:,5),'b--','Linewidth',2)
hold on
plot([0 Total_run+Burnin_run],[Estimated_params(5) Estimated_params(5)],'r','Linewidth',2)
hold on
plot([Burnin_run Burnin_run],[-LowerBound(5)-10 UpperBound(5)],'g--','Linewidth',2)
xlabel('Iteration','fontsize',14);ylabel('$G_{ese}$', 'interpreter','latex', 'fontsize',18);
%ylim([0 .5]);
set(gca, 'fontsize',16);
box on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(426)
plot(Samples(:,6),'b--','Linewidth',2)
hold on
plot([0 Total_run+Burnin_run],[Estimated_params(6) Estimated_params(6)],'r','Linewidth',2)
hold on
plot([Burnin_run Burnin_run],[-LowerBound(6)-10 UpperBound(6)],'g--','Linewidth',2)
xlabel('Iteration','fontsize',14);ylabel('$G_{srs}$', 'interpreter','latex', 'fontsize',18);
%ylim([0 1]);
set(gca, 'fontsize',16);
box on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(427)
plot(Samples(:,7),'b--','Linewidth',2)
hold on
plot([0 Total_run+Burnin_run],[Estimated_params(7) Estimated_params(7)],'r','Linewidth',2)
hold on
plot([Burnin_run Burnin_run],[-LowerBound(7)-10 UpperBound(7)],'g--','Linewidth',2)
xlabel('Iteration','fontsize',14);ylabel('$G_{esre}$', 'interpreter','latex', 'fontsize',18);
%ylim([0 .1]);
set(gca, 'fontsize',16);
box on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure()
subplot(421)
hist(Samples(:,1))
ylabel('$D$', 'interpreter','latex', 'fontsize',18);
set(gca, 'fontsize',14);  
box on
subplot(422)
hist(Samples(:,2))
ylabel('$\tau$', 'interpreter','latex', 'fontsize',18);
set(gca, 'fontsize',14);
subplot(423)
hist(Samples(:,3))
ylabel('$\beta_e$', 'interpreter','latex', 'fontsize',18);
set(gca, 'fontsize',14);
subplot(424)
hist(Samples(:,4))
ylabel('$\beta_i$', 'interpreter','latex', 'fontsize',18);
set(gca, 'fontsize',14);  
box on
subplot(425)
hist(Samples(:,5))
ylabel('$G_{ese}$', 'interpreter','latex', 'fontsize',18);
set(gca, 'fontsize',14);
subplot(426)
hist(Samples(:,6))
ylabel('$G_{srs}$', 'interpreter','latex', 'fontsize',18);
set(gca, 'fontsize',14);
subplot(427)
hist(Samples(:,7))
ylabel('$G_{esre}$', 'interpreter','latex', 'fontsize',18);
set(gca, 'fontsize',14);
end
