function [] = plotting_fitting( myfunc, Xdata,Ydata, True_params, Estimated_params, FitnessValues)

if isempty(True_params)
    Estimated_Signal=myfunc(Estimated_params,Xdata);
    bestfitness=min(FitnessValues);
    
    figure();
    set(gcf, 'Position', [500, 500, 800, 600])
    plot(Xdata,Ydata,'r--','linewidth',2);
    hold on;
    plot(Xdata,Estimated_Signal,'b','linewidth',4);
    xlabel('Frequency (Hz)','interpreter','latex','fontsize',18);
    ylabel('log(power spectrum (a.u.))','interpreter','latex','fontsize',18);
    set(gca, 'fontsize',16);
    text(.58,.7,['$Best~Fitness= ' num2str(ceil(bestfitness*1000)/1000) '$'],'FontSize',18,...
        'FontWeight','bold','HorizontalAlignment',...
        'Left','Units', 'Normalized', 'interpreter','latex');
    h=legend('Measured Signal','Estimated Signal','Location','northeast');
    rect = [0.6, 0.78, .2, .02];
    set(h, 'Position', rect)
    set(h,'FontSize',18);
    legend boxoff 
    set(gca,'Box','on');

else
    True_Signal=myfunc(True_params,Xdata);
    Estimated_Signal=myfunc(Estimated_params,Xdata);
    bestfitness=min(FitnessValues);
    
    figure();
    set(gcf, 'Position', [500, 500, 800, 600])
    plot(Xdata,Ydata,'r--','linewidth',2);
    hold on;
    plot(Xdata,True_Signal,'-b','linewidth',6)
    hold on;
    plot(Xdata,Estimated_Signal,'--g','linewidth',2);
    xlabel('Frequency (Hz)','interpreter','latex','fontsize',18);
    ylabel('log(power spectrum (a.u.))','interpreter','latex','fontsize',18);
    set(gca, 'fontsize',16);
    text(.58,.7,['$Best~Fitness= ' num2str(ceil(bestfitness*1000)/1000) '$'],'FontSize',18,...
        'FontWeight','bold','HorizontalAlignment',...
        'Left','Units', 'Normalized', 'interpreter','latex');
    h=legend('Measured Signal','True Signal','Estimated Signal','Location','northeast');
    rect = [0.6, 0.78, .2, .02];
    set(h, 'Position', rect)
    set(h,'FontSize',18);
    legend boxoff 
    set(gca,'Box','on');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%                    
    if length(FitnessValues)>1
        figure();
        plot(FitnessValues,'b')
        xlabel('Function evaluations','interpreter','latex','fontsize',18)
        ylabel('Fitness value','interpreter','latex','fontsize',18)
        set(gca, 'xscale', 'log')
        set(gca, 'yscale', 'log')
        set(gca, 'fontsize',16);   
    end
end

end