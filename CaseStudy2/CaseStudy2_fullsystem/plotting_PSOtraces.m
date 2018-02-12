function [] = plotting_PSOtraces(Trace_TP, Trace_Gbest)

Trace_TP1=cell2mat(Trace_TP(1));
Trace_TP2=cell2mat(Trace_TP(2));
Trace_TP3=cell2mat(Trace_TP(3));
Trace_TP4=cell2mat(Trace_TP(4));


Trace_Gbest1=cell2mat(Trace_Gbest(1));
Trace_Gbest2=cell2mat(Trace_Gbest(2));
Trace_Gbest3=cell2mat(Trace_Gbest(3));
Trace_Gbest4=cell2mat(Trace_Gbest(4));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure()
set(gcf, 'Position', [500, 500, 600, 400])
subplot(221)
for i=1:size(Trace_TP1,1)
    hold on
plot(1:size(Trace_TP1,2),Trace_TP1(i,:),'*')

end

hold on
plot(Trace_Gbest1(1:end),'r','linewidth',2)
xlabel(' Iteration ','interpreter','tex','fontsize',18)
ylabel(' \kappa','interpreter','tex','fontsize',24)
set(gca, 'fontsize',16);
box on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(222)
for i=1:size(Trace_TP2,1)
    hold on
plot(1:size(Trace_TP2,2),Trace_TP2(i,:),'*')

end

hold on
plot(Trace_Gbest2(1:end),'r','linewidth',2)
xlabel(' Iteration ','interpreter','tex','fontsize',18)
ylabel(' a','interpreter','tex','fontsize',24)
set(gca, 'fontsize',16); 
box on  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(223)
for i=1:size(Trace_TP3,1)
    hold on
plot(1:size(Trace_TP3,2),Trace_TP3(i,:),'*')

end
hold on
plot(Trace_Gbest3(1:end),'r','linewidth',2)
xlabel(' Iteration ','interpreter','tex','fontsize',18)
ylabel(' b','interpreter','tex','fontsize',24)
set(gca, 'fontsize',16); 
box on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(224)
for i=1:size(Trace_TP4,1)
    hold on
plot(1:size(Trace_TP4,2),Trace_TP4(i,:),'*')

end
hold on
plot(Trace_Gbest4(1:end),'r','linewidth',2)
xlabel(' Iteration ','interpreter','tex','fontsize',18)
ylabel(' \tau','interpreter','tex','fontsize',24)
set(gca, 'fontsize',16); 
box on
end