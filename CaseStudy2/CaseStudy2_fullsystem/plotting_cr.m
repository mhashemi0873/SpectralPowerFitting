function [] = plotting_cr(FitnessFunction, myfunc, Xdata,Ydata, True_params, Estimated_params, FitnessValues, IC, r)

Xdata=Xdata';
Ydata=Ydata';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
zeroRows = any(IC==0, 2);
IC(zeroRows, :) = [];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
y1=IC(:,1)';
y2=IC(:,2)';
y3=IC(:,3)';
y4=IC(:,4)';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
param_1=Estimated_params(1);
param_2=Estimated_params(2);
param_3=Estimated_params(3);
param_4=Estimated_params(4);
pararameters=[param_1 param_2 param_3 param_4 ];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Npnt = length(Xdata);				  
Npar=length(pararameters);
W=1/(var(Ydata)^2);
%W = (length(Xdata)/sqrt(Ydata'*Ydata));
W=W*ones(1,Npnt);
W=diag(W);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
J=JacobianComplex(@lm_func,Xdata,pararameters);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
J12=[J(:,1) J(:,2)];
J13=[J(:,1) J(:,3)];
J14=[J(:,1) J(:,4)];
J23=[J(:,2) J(:,3)];
J24=[J(:,2) J(:,4)];
J34=[J(:,3) J(:,4)];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
A12_Jac=J12'*W*J12;
A13_Jac=J13'*W*J13;
A14_Jac=J14'*W*J14;
A23_Jac=J23'*W*J23;
A24_Jac=J24'*W*J24;
A34_Jac=J34'*W*J34;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Jt=J';
H=Jt*W*J;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[Hes,err] = hessian(FitnessFunction,pararameters);

A12_Hess=0.5*[Hes(1,1) Hes(1,2); Hes(2,1) Hes(2,2)];
A13_Hess=0.5*[Hes(1,1) Hes(1,3); Hes(3,1) Hes(3,3)];
A14_Hess=0.5*[Hes(1,1) Hes(1,4); Hes(4,1) Hes(4,4)];
A23_Hess=0.5*[Hes(2,2) Hes(2,3); Hes(3,2) Hes(3,3)];
A24_Hess=0.5*[Hes(2,2) Hes(2,4); Hes(4,2) Hes(4,4)];
A34_Hess=0.5*[Hes(3,3) Hes(3,4); Hes(4,3) Hes(4,4)];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure()

subplot(231)
c12 = [param_1;param_2 ];  
plot(y1, y2, 'o');
plotting_ellipse(A12_Jac,c12,r, '-r')
plotting_ellipse(A12_Hess,c12,r, '--g')

xlabel(' $\kappa$ ','interpreter','latex','fontsize',24)
ylabel(' $a$','interpreter','latex','fontsize',24)
set(gca, 'fontsize',16); 
view(-90, 90) 
set(gca, 'ydir', 'reverse'); 
set(gca, 'fontsize',16);
axis square
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(232)
c13 = [param_1;param_3 ];  
plot(y1, y3, 'o');
plotting_ellipse(A13_Jac,c13,r, '-r')
plotting_ellipse(A13_Hess,c13,r, '--g')

xlabel('$\kappa $','interpreter','latex','fontsize',24)
ylabel(' $b$','interpreter','latex','fontsize',24)
set(gca, 'fontsize',16);
view(-90, 90) 
set(gca, 'ydir', 'reverse');
set(gca, 'fontsize',16);
axis square
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(233)
c14 = [param_1;param_4 ];  
plot(y1, y4, 'o');
plotting_ellipse(A14_Jac,c14,r, '-r')
plotting_ellipse(A14_Hess,c14,r, '--g')

xlabel('$\kappa $','interpreter','latex','fontsize',24)
ylabel(' $\tau$','interpreter','latex','fontsize',24)
set(gca, 'fontsize',16);
view(-90, 90) 
set(gca, 'ydir', 'reverse');
set(gca, 'fontsize',16);
axis square
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(234)
c23 = [param_2;param_3 ];  
plot(y2, y3, 'o');
plotting_ellipse(A23_Jac,c23,r,'-r')
plotting_ellipse(A23_Hess,c23,r,'--g')

xlabel('$a$ ','interpreter','latex','fontsize',24)
ylabel(' $b$','interpreter','latex','fontsize',24)
set(gca, 'fontsize',16);
view(-90, 90) 
set(gca, 'ydir', 'reverse');
set(gca, 'fontsize',16);
axis square
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(235)
c24 = [param_2;param_4 ];  
plot(y2, y4, 'o');
plotting_ellipse(A24_Jac,c24,r,'-r')
plotting_ellipse(A24_Hess,c24,r,'--g')

xlabel('$a$ ','interpreter','latex','fontsize',24)
ylabel(' $\tau$','interpreter','latex','fontsize',24)
set(gca, 'fontsize',16);
view(-90, 90) 
set(gca, 'ydir', 'reverse');
set(gca, 'fontsize',16);
axis square
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(236)
c34 = [param_3;param_4 ];  
plot(y3, y4, 'o');
plotting_ellipse(A34_Jac,c34,r,'-r')
plotting_ellipse(A34_Hess,c34,r,'--g')

xlabel('$b$ ','interpreter','latex','fontsize',24)
ylabel(' $\tau$','interpreter','latex','fontsize',24)
set(gca, 'fontsize',16);
view(-90, 90) 
set(gca, 'ydir', 'reverse');
set(gca, 'fontsize',16);
axis square

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Jt=J';
H=Jt*W*J;
covar = inv(H);
covar2 = 2*inv(Hes);
sigma_p = sqrt(diag(covar)); 
corr = covar ./ [sigma_p*sigma_p']
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
str = { 'kappa', 'a', 'b', 'tau','interpreter', 'latex'};
figure()
imagesc(abs(corr));
colorbar
title('Correlation', 'fontsize',24)
set(gca,'FontSize', 16);
set(gca,'xaxisLocation','bottom')
set(gca, 'XTickLabel',str, 'XTick',1:numel(str),'fontsize',20)
set(gca, 'YTickLabel',str, 'YTick',1:numel(str),'fontsize',20)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
sigma_y = sqrt(diag(J * covar * J'));	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
y_fit=(myfunc(Estimated_params,Xdata));
y_fitplus=y_fit+1.96*sigma_y';
y_fitminus=y_fit-1.96*sigma_y';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
True_Signal=myfunc(True_params,Xdata);
Estimated_Signal=myfunc(Estimated_params,Xdata);
bestfitness=min(FitnessValues);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure()
set(gcf, 'Position', [500, 500, 800, 600])
fill( [Xdata fliplr(Xdata)],  [y_fitplus fliplr(y_fitminus)], [0.8 .8 .8],'EdgeColor','none');
hold on;
plot(Xdata,Ydata,'r--','linewidth',2);
hold on;
plot(Xdata,True_Signal,'-b','linewidth',6)
hold on;
plot(Xdata,Estimated_Signal,'--g','linewidth',2);
set(gca, 'fontsize',16);
xlabel('Frequency (Hz)','interpreter','latex','fontsize',18);
ylabel('log(power spectrum (a.u.))','interpreter','latex','fontsize',18);
text(.4,.65,['$Best~Fitness= ' num2str(ceil(bestfitness*1000)/1000) '$'],'FontSize',18,...
             'FontWeight','bold','HorizontalAlignment','Left','Units', 'Normalized', 'interpreter','latex');
h=legend('95% Confidence interval','Measured Signal','True Signal',' Estimated Signal','Location','northeast');
rect = [0.6, 0.78, .2, .02];
set(h, 'Position', rect)
set(h,'FontSize',18);
legend boxoff 
set(gca,'Box','on');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure()
Res=Ydata-y_fit;
plot(Res,'b','linewidth',1)
set(gca, 'fontsize',16);
title('Residuals of Inference', 'fontsize',24)
ylabel(' Residuals ','interpreter','latex','fontsize',20)
xlabel(' Number of iterations','interpreter','latex','fontsize',20)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        function[]= plotting_ellipse(A,c,r, color)
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        [eigenvec, eigenval ] = eig(A);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Get the index of the largest eigenvector
        [largest_eigenvec_ind_c, largest_eigenvec_ind_r] = find(eigenval == max(max(eigenval)));
        largest_eigenvec = eigenvec(:, largest_eigenvec_ind_c);

        eigenval(~eigenval) = nan;
        [smallest_eigenvec_ind_c, smallest_eigenvec_ind_r] = find(eigenval == min(min(eigenval)));
        smallest_eigenvec = eigenvec(:, smallest_eigenvec_ind_c);

        % Get the largest eigenvalue
        largest_eigenval = max(max(eigenval));
        % Get the largest eigenvalue
        smallest_eigenval = min(min(eigenval));
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Get the smallest eigenvector and eigenvalue
        if(largest_eigenvec_ind_c == 1)
            smallest_eigenval = max(eigenval(:,2));
            smallest_eigenvec = eigenvec(:,2);
        else
            smallest_eigenval = max(eigenval(:,1));
            smallest_eigenvec = eigenvec(1,:);
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Calculate the angle between the x-axis and the largest eigenvector
        phi = atan2(largest_eigenvec(2), largest_eigenvec(1));

        % This angle is between -pi and pi.
        % Let's shift it such that the angle is between 0 and 2pi
        if(phi < 0)
            phi = phi + 2*pi;
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        theta = linspace(0,2*pi,100);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        X0=c(1);
        Y0=c(2);
        ra=sqrt(r/largest_eigenval);
        rb=sqrt(r/smallest_eigenval);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %Define a rotation matrix
        R = [ cos(phi) sin(phi); -sin(phi) cos(phi) ];

        Q=[ ra*cos( theta); rb*sin( theta)]';

        %let's rotate the ellipse to some angle phi
        r_ellipse = Q * R;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        hold on
        g=plot(c(1),c(2),'o','markersize', 8);
        set(g,'MarkerEdgeColor','r','MarkerFaceColor','r')
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        hold on
        set(gcf, 'Position', [500, 500, 800, 400])
        plot(r_ellipse(:,1) + X0,r_ellipse(:,2) + Y0,color,'linewidth',4)
        hold on;
        end
end

