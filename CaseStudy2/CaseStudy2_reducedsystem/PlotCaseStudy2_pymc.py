# Hashemi et al, Neuroinformatics 2018

import matplotlib.pyplot as plt
import matplotlib as mpl
import numpy as np
import pymc



print('The estimated value of kappa: {}, and the median value is {}'.format(kappa_trace[-1], np.median(kappa_trace)))
print('The estimated value of tau: {}, and the median value is {}'.format(tau_trace[-1], np.median(tau_trace)))
print('The estimated value of Omega: {}, and the median value is {}'.format(Omega_trace[-1], np.median(Omega_trace)))



################################################################################################
# extract the traces and plot the results
pymc_traces = [MDL.trace('kappa')[-niter:],
               MDL.trace('Omega')[-niter:],
               MDL.trace('tau')[-niter:]]

################################################################################################
l=-.3
r=1.15
################################################################################################
def compute_sigma_level(trace1, trace2, nbins=20):
    """From a set of traces, bin by number of standard deviations"""
    L, xbins, ybins = np.histogram2d(trace1, trace2, nbins)
    L[L == 0] = 1E-16
    logL = np.log(L)

    shape = L.shape
    L = L.ravel()

    # obtain the indices to sort and unsort the flattened array
    i_sort = np.argsort(L)[::-1]
    i_unsort = np.argsort(i_sort)

    L_cumsum = L[i_sort].cumsum()
    L_cumsum /= L_cumsum[-1]
    
    xbins = 0.5 * (xbins[1:] + xbins[:-1])
    ybins = 0.5 * (ybins[1:] + ybins[:-1])

    return xbins, ybins, L_cumsum[i_unsort].reshape(shape)

################################################################################################    

def plot_Confidence1(ax, pymc_traces, scatter=False, **kwargs):
    """Plot traces and contours"""
    xbins, ybins, sig = compute_sigma_level(pymc_traces[1], pymc_traces[0])
    ax.contour(xbins, ybins, sig.T, levels=[0.0, 0.95], **kwargs)
    if scatter:
        ax.plot(pymc_traces[1], pymc_traces[0], ',b', alpha=0.1)
    ax.set_xlabel(r'$\Omega$',fontsize=24)
    ax.set_ylabel(r'$\kappa$',fontsize=24)
    ax.set_xlim([1.993, 2.005])
    ax.set_ylim([0.10, 0.106])
    ax.tick_params(axis='x', labelsize=14)    
    ax.tick_params(axis='y', labelsize=14)    
    ax.set_xticks([1.995,2.0,2.005])                                                       
    ax.set_yticks([0.1,0.103,0.106])
    ax.text(l,r, 'A', transform=ax.transAxes,
    fontsize=26,  va='top', ha='right')
    ax.plot([Omega_est],[kappa_est], 'ro')
################################################################################################    
    
def plot_Confidence2(ax, pymc_traces, scatter=False, **kwargs):
    """Plot traces and contours"""
    xbins, ybins, sig = compute_sigma_level(pymc_traces[2], pymc_traces[0])
    ax.contour(xbins, ybins, sig.T, levels=[0., 0.95], **kwargs)
    if scatter:
        ax.plot(pymc_traces[2], pymc_traces[0], ',b', alpha=0.1)
    ax.set_xlabel(r'$\tau$',fontsize=24)
    ax.set_ylabel(r'$\kappa$',fontsize=22)
    ax.set_xlim([0.198, 0.203])
    ax.set_ylim([0.10, 0.106])
    ax.tick_params(axis='x', labelsize=14)    
    ax.tick_params(axis='y', labelsize=14) 
    ax.set_xticks([0.198, 0.2, 0.202])  
    ax.set_yticks([0.1,0.103,0.106])
    ax.text(l,r, 'B', transform=ax.transAxes,
    fontsize=26,  va='top', ha='right')
    ax.plot([tau_est],[kappa_est], 'ro')
################################################################################################    
    
def plot_Confidence3(ax,  pymc_traces, scatter=False, **kwargs):
    """Plot traces and contours"""
    xbins, ybins, sig = compute_sigma_level(pymc_traces[2], pymc_traces[1])
    ax.contour(xbins, ybins, sig.T, levels=[0., 0.95], **kwargs)
    if scatter:
       ax.plot(pymc_traces[2], pymc_traces[1], ',b', alpha=0.1)
    ax.set_xlabel(r'$\tau$',fontsize=24)
    ax.set_ylabel(r'$\Omega$',fontsize=22)
    ax.set_xlim([0.198, 0.203])
    ax.set_ylim([1.993, 2.005])
    ax.tick_params(axis='x', labelsize=14)    
    ax.tick_params(axis='y', labelsize=14) 
    ax.set_xticks([0.198, 0.2, 0.202]) 
    ax.set_yticks([1.995,2.0,2.005])                                                       
    ax.text(l, r, 'C', transform=ax.transAxes,
    fontsize=26,  va='top', ha='right')
    ax.plot([tau_est],[Omega_est], 'ro')
################################################################################################    

def plot_Confidences( trace, colors='k'):
    """Plot both the trace and the model together"""
    fig, ax = plt.subplots(1,3, figsize=(11, 3.2))
    plot_Confidence1(ax[0], trace, True, colors=colors)
    plot_Confidence2(ax[1], trace, True, colors=colors)
    plot_Confidence3(ax[2], trace, True, colors=colors)
    plt.tight_layout(pad=1.3, w_pad=.1, h_pad=.0)
    
plot_Confidences(pymc_traces)
#plt.savefig('Confidencecase2.png', format='png')
###############################################################################################
###############################################################################################
#Plot traces
kappa_trace = MDL.trace('kappa')[-burn:]
Omega_trace = MDL.trace('Omega')[-burn:]
tau_trace = MDL.trace('tau')[-burn:]

plt.figure(figsize=(10, 6))
plt.subplot(3,1,1)
plt.plot(kappa_trace, color='b')
plt.xlabel('Iterations',fontsize=14)
plt.ylabel(r'$\kappa$',fontsize=24)
plt.xticks(fontsize=14)
plt.yticks([0.101,0.103,0.105],fontsize=14)
plt.axhline(y=kappa_est, linewidth=2, color = 'r')



plt.subplot(3,1,2)
plt.plot(Omega_trace, color='b')
plt.xlabel('Iterations',fontsize=14)
plt.ylabel(r'$\Omega$',fontsize=24)
plt.xticks(fontsize=14)
plt.yticks([1.995,2.0,2.005],fontsize=14)
plt.axhline(y=Omega_est, linewidth=2, color = 'r')


plt.subplot(3,1,3)
plt.plot(tau_trace, color='b')
plt.xlabel('Iterations',fontsize=14)
plt.ylabel(r'$\tau$',fontsize=22)
plt.xticks(fontsize=14)
plt.yticks([0.1998, 0.2004, 0.201],fontsize=14)
plt.axhline(y=tau_est, linewidth=2, color = 'r')


plt.tight_layout(pad=1, w_pad=.1, h_pad=.0)
#plt.savefig('TracesCase2.png', format='png')
################################################################################################
################################################################################################
#Plot Histogram of traces

plt.figure(figsize=(4, 8))
plt.subplot(3,1,1)
plt.hist(kappa_trace, color='b', bins=20, normed=True)
plt.ylabel('Counts',fontsize=14)
plt.xlabel(r'$\kappa$',fontsize=24)
plt.ylim([0, 830])
plt.xlim([0.101, 0.106])
plt.xticks([0.101,0.103,0.106],fontsize=14)
plt.yticks([0,400,800],fontsize=14)
plt.axvline(x=kappa_est,ymin=0, ymax = .98, linewidth=2, color = 'r')



plt.subplot(3,1,2)
plt.hist(Omega_trace, color='b', bins=22, normed=True);
plt.ylabel('Counts',fontsize=14)
plt.xlabel(r'$\Omega$',fontsize=22);
plt.ylim([0, 360])
plt.xticks([1.995,2.00,2.005],fontsize=14)
plt.yticks([0,200,350],fontsize=14)
plt.axvline(x=Omega_est,ymin=0, ymax = .94, linewidth=2, color = 'r')


plt.subplot(3,1,3)
plt.hist(tau_trace, color='b', bins=22, normed=True);
plt.ylabel('Counts',fontsize=14)
plt.xlabel(r'$\tau$',fontsize=24);
plt.xticks([0.1998, 0.2004, 0.201],fontsize=14) 
plt.ylim([0, 3100])
plt.yticks([0,1500,3000],fontsize=14)
plt.axvline(x=tau_est,ymin=0, ymax = .9, linewidth=2, color = 'r')


plt.tight_layout(pad=1, w_pad=.1, h_pad=.1)
#plt.savefig('HistCase1.png', format='png')

################################################################################################
################################################################################################
#pymc.Matplot.plot(MDL)
################################################################################################    
#################################################################################################


y_true= func_DelayLin(w=w, kappa=kappa_true, a=a_true, b=b_true, tau=tau_true )
y_est = func_DelayLin(w=w, kappa=kappa_est,  a=a_est,  b=b_est,  tau=tau_est )


kappa_min=MDL.kappa.stats()['quantiles'][2.5]
kappa_max=MDL.kappa.stats()['quantiles'][97.5]
Omega_min=MDL.Omega.stats()['quantiles'][2.5]
Omega_max=MDL.Omega.stats()['quantiles'][97.5]
tau_min=MDL.tau.stats()['quantiles'][2.5]
tau_max=MDL.tau.stats()['quantiles'][97.5]

a_min=((2*np.pi)*Omega_min/np.tan((2*np.pi)*Omega_min*tau_min))-epsilon
b_min=-(2*np.pi)*Omega_min/np.sin((2*np.pi)*Omega_min*tau_min)

a_max=((2*np.pi)*Omega_max/np.tan((2*np.pi)*Omega_max*tau_max))-epsilon
b_max=-(2*np.pi)*Omega_max/np.sin((2*np.pi)*Omega_max*tau_max)


y_true= func_DelayLin(w=w, kappa=kappa_true, a=a_true, b=b_true, tau=tau_true )
y_est = func_DelayLin(w=w, kappa=kappa_est,  a=a_est, b=b_est,   tau=tau_est )
y_min = func_DelayLin(w=w, kappa=kappa_min,  a=a_min, b=b_min,   tau=tau_min )
y_max = func_DelayLin(w=w, kappa=kappa_max,  a=a_max, b=b_max,   tau=tau_max )

################################################################################################
   
def plot_MCMC_model(xdata, ydata,y_true,y_est,y_min,y_max):
    """Plot the linear model and 2sigma contours"""
    plt.plot(xdata,ydata ,'r', marker='None', ls='-', lw=1, label='Measured Signal')
    plt.plot(xdata,y_true,'b', marker='None', ls='-', lw=4, label='True Signal')
    plt.plot(xdata,y_est  ,'g', marker='None', ls='--',lw=3, label='Estimated Signal')
    plt.fill_between(xdata, y_min, y_max, color='0.5', alpha=0.5,label=' Confidence region')

    plt.legend(prop={'size':12})
    plt.xlabel('Frequency (Hz)',fontsize=18)
    plt.ylabel('log (power spectrum (a.u.))',fontsize=18)
    plt.xticks(fontsize = 15) 
    plt.yticks(fontsize = 15) 
################################################################################################
    
plt.figure(4)
plot_MCMC_model(xdata, ydata,y_true,y_est,y_min,y_max)
#plt.savefig('ModelCase2.png', format='png')




