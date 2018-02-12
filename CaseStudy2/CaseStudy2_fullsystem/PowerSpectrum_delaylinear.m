% Stochastic Linear Delayed Oscillator
% Author: Meysam HASHEMI. % Hashemi et al, Neuroinformatics 2018

clc
clear 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Stability Conditions:
%%% if b>0 then  a<-b
%%% if b<0 then a<-b*cos(omega*tau) : omega=-bsin(omega*tau)%%  0<omega< pi/tau
%%%   or
%%%  a<-b and tau*sqrt(b^2-a^2)< acos(-a/b)

%%%% omega^2=b^2-a^2 %%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
kappa = .1;
Omega=2.0;
tau=.2;
epsilon=1;
a=(2*pi*Omega/tan(2*pi*Omega*tau))-epsilon;
b=-2*pi*Omega./sin(2*pi*Omega*tau);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
realization = 10;
Fs = 1000;                     
dt = 1/Fs;                     
L = 100000;                            
NFFT = 2^nextpow2(L);           
f = Fs/2*linspace(0,1,NFFT/2+1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%                   
v0=1.0;
v= zeros(realization,L);
v(:,1) = v0; 

delay=tau/dt;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:realization
    
    for j=1:delay+1
        v(i,j)=v0;
    end
    
    for j=delay+1:L
        v(i,j+1) = v(i,j) + dt*(a*v(i,j)+b*v(i,j-delay))+sqrt(2*kappa*dt)*randn; 
    end
    
    
    M=length(v);
    H = (1 - cos(2*pi*(1:M)'/(M+1)));   %H = hanning(M);
 
    vh(i,:) = v(i,:).*H' ; 
  
    Y(i,:) = abs(fft(vh(i,:),NFFT)).^2 *(dt/NFFT);
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
PowerSpec = mean(Y);
z=PowerSpec(1:NFFT/2+1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Fr=f(1:3001);
PowerSpec_Numerical=log(PowerSpec(1:3001));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dF=Fr(2)-Fr(1);
FI=Fr(1);
FN=Fr(end);
freq=FI:dF:FN;

w=FI:dF:FN;
w=w*2*pi;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
PowerSpec_Analytical=(2*kappa)*(1./(((a+b*cos(tau*w)).^2)+((w+b*sin(tau*w)).^2)));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
plot(Fr,PowerSpec_Numerical,'--r', 'linewidth',2);
hold on
hold on
plot(freq,log(PowerSpec_Analytical)+.2*randn(1,numel(freq)), '--g', 'linewidth',1);
plot(freq,log(PowerSpec_Analytical), '-b', 'linewidth',4);

h=legend('Numerical PowerSpectrum','Analytical PowerSpectrum+Noise', 'Analytical PowerSpectrum','Location','northeast');
set(h,'FontSize',14);
legend boxoff 
xlabel('Frequency (Hz)','interpreter','latex','fontsize',18);
ylabel('Power spectrum (a.u.)','interpreter','latex','fontsize',18);
set(gca, 'fontsize',18);
xlim([0 20])
box on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%