% Stochastic Damped Harmonic Oscillator
% Author: Meysam HASHEMI.  Hashemi et al, Neuroinformatics 2018
clc
clear 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
kappa = .1;
gamma =5;
f_0=3;
omega=2*pi*f_0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
realization = 10;
Fs = 1000;                     
dt = 1/Fs;                     
L = 100000;                                 
NFFT = 2^nextpow2(L);           
f = Fs/2*linspace(0,1,NFFT/2+1);
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%                  
v1= zeros(realization,L);
v2= zeros(realization,L);

v1(:,1) = 0.1; 
v2(:,1) = 0.1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i=1:realization
    
    
    for j=1:L
        
        v1(i,j+1)=  v1(i,j) + dt*v2(i,j); 
        v2(i,j+1) = v2(i,j) + dt*(-omega^2*v1(i,j)-gamma*v2(i,j))+sqrt(2*kappa*dt)*randn; 
    end
    
    
    M=length(v1);
    H = (1 - cos(2*pi*(1:M)'/(M+1)));   %H = hanning(M);
 
    vh(i,:) = v1(i,:).*H' ; 
  
    Y(i,:) = abs(fft(vh(i,:),NFFT)).^2 *(dt/NFFT);
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
PowerSpec = mean(Y);
z=PowerSpec(1:NFFT/2+1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Fr=f(1:2001);
PowerSpec_Numerical=log(PowerSpec(1:2001));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dF=Fr(2)-Fr(1);
FI=Fr(1);
FN=Fr(end);
freq=FI:dF:FN;

w=FI:dF:FN;
w=w*2*pi;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Denaminator=(omega^2-w.^2)+1i*gamma*w;
%Re=real(Denaminator);Im=imag(Denaminator);
%Ginv=1./Denaminator;
%PowerSpec_Analytical=(2*D)*Ginv.*conj(Ginv);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
PowerSpec_Analytical=(2*kappa)*(1./((((w.^2)-(omega^2)).^2)+((gamma.*w).^2)));
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