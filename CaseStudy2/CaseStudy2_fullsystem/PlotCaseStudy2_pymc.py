# Hashemi et al, Neuroinformatics 2018

import matplotlib.pyplot as plt
import matplotlib as mpl
import numpy as np
import pymc


print('The estimated  value of kappa: {}, and the median value is {}'.format(kappa_trace[-1], np.median(kappa_trace)))
print('The estimated  value of a: {}, and the median value is {}'.format(a_trace[-1], np.median(a_trace)))
print('The estimated  value of b: {}, and the median value is {}'.format(b_trace[-1], np.median(b_trace)))
print('The estimated  value of tau: {}, and the median value is {}'.format(tau_trace[-1], np.median(tau_trace)))


l=-.3
r=1.15
################################################################################################
###############################################################################################
###############################################################################################
#Plot traces
kappa_trace = MDL.trace('kappa')[-niter:]
a_trace = MDL.trace('a')[-niter:]
b_trace = MDL.trace('b')[-niter:]
tau_trace = MDL.trace('tau')[-niter:]


plt.figure(figsize=(10, 6))
plt.subplot(4,1,1)
plt.plot(kappa_trace, color='b')
plt.xlabel('Iterations',fontsize=14)
plt.ylabel(r'$\kappa$',fontsize=24)
plt.xticks(fontsize=14)
plt.yticks([0.101,0.103,0.105],fontsize=14)
plt.axhline(y=kappa_est, linewidth=2, color = 'r')



plt.subplot(4,1,2)
plt.plot(a_trace, color='b')
plt.xlabel('Iterations',fontsize=14)
plt.ylabel(r'$a$',fontsize=24)
plt.xticks(fontsize=14)
plt.yticks([-18.8,-18.4,-18.1],fontsize=14)
plt.axhline(y=a_est, linewidth=2, color = 'r')


plt.subplot(4,1,3)
plt.plot(b_trace, color='b')
plt.xlabel('Iterations',fontsize=14)
plt.ylabel(r'$b$',fontsize=24)
plt.xticks(fontsize=14)
plt.yticks([-21.8,-21.5,-21.2],fontsize=14)
plt.axhline(y=b_est, linewidth=2, color = 'r')


plt.subplot(4,1,4)
plt.plot(tau_trace, color='b')
plt.xlabel('Iterations',fontsize=14)
plt.ylabel(r'$\tau$',fontsize=22)
plt.xticks(fontsize=14)
plt.yticks([0.1998, 0.2004, 0.201],fontsize=14)
plt.axhline(y=tau_est, linewidth=2, color = 'r')


plt.tight_layout(pad=1, w_pad=.1, h_pad=.0)
plt.savefig('TracesCase2.eps', format='eps')
################################################################################################
################################################################################################
#Plot Histogram of traces
kappa_trace = MDL.trace('kappa')[-burn:]
a_trace = MDL.trace('a')[-burn:]
b_trace = MDL.trace('b')[-100000:]
tau_trace = MDL.trace('tau')[-100000:]


plt.figure(figsize=(4, 8))
plt.subplot(4,1,1)
plt.hist(kappa_trace, color='b', bins=16, normed=True)
plt.ylabel('Counts',fontsize=14)
plt.xlabel(r'$\kappa$',fontsize=24)
plt.ylim([0, 850])
plt.xlim([0.101, 0.106])
plt.xticks([0.101,0.103,0.106],fontsize=14)
plt.yticks([0,400,800],fontsize=14)
plt.axvline(x=kappa_est,ymin=0, ymax = .98, linewidth=2, color = 'r')



plt.subplot(4,1,2)
plt.hist(a_trace, color='b', bins=17, normed=True);
plt.ylabel('Counts',fontsize=14)
plt.xlabel(r'$a$',fontsize=22);
plt.ylim([0, 5])
plt.xticks([-18.8,-18.4,-18.1],fontsize=14)
plt.yticks([0,2.5,5],fontsize=14)
plt.axvline(x=a_est,ymin=0, ymax = .94, linewidth=2, color = 'r')


plt.subplot(4,1,3)
plt.hist(b_trace, color='b', bins=17, normed=True);
plt.ylabel('Counts',fontsize=14)
plt.xlabel(r'$b$',fontsize=22);
plt.ylim([0, 5])
plt.xticks([-21.8,-21.5,-21.2],fontsize=14)
plt.yticks([0,2.5,5],fontsize=14)
plt.axvline(x=b_est,ymin=0, ymax = .94, linewidth=2, color = 'r')


plt.subplot(4,1,4)
plt.hist(tau_trace, color='b', bins=18, normed=True);
plt.ylabel('Counts',fontsize=14)
plt.xlabel(r'$\tau$',fontsize=24);
plt.xticks([0.1998, 0.2004, 0.201],fontsize=14) 
plt.ylim([0, 3100])
plt.yticks([0,1500,3000],fontsize=14)
plt.axvline(x=tau_est,ymin=0, ymax = .9, linewidth=2, color = 'r')


plt.tight_layout(pad=1, w_pad=.1, h_pad=.1)
#plt.savefig('HistCase24.eps', format='eps')



plt.figure(figsize=(7, 5))
plt.plot(xdata,ydata      ,'r', marker='None', ls='-', lw=1, label='Measured Signal')
plt.plot(xdata,Power_true ,'b', marker='None', ls='-', lw=4, label='True Signal')
plt.plot(xdata,Power_est  ,'g', marker='None', ls='--',lw=3, label='Estimated Signal')
plt.xlabel('Frequency (Hz)'); plt.ylabel('log (power spectrum (a.u.))');
plt.legend()

plt.legend(prop={'size':12})
plt.xlabel('Frequency (Hz)',fontsize=18)
plt.ylabel('log (power spectrum (a.u.))',fontsize=18)
plt.xlim([0, 20])
plt.xticks(fontsize = 15) 
plt.yticks(fontsize = 15) 
#plt.savefig('ModelCase24.eps', format='eps')



