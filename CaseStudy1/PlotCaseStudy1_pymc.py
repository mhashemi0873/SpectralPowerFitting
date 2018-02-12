# Hashemi et al, Neuroinformatics 2018
import matplotlib.pyplot as plt
import matplotlib as mpl
import numpy as np
import pymc




print('The estimated value of kappa: {}, and the median value is {}'.format(kappa_trace[-1], np.median(kappa_trace)))
print('The estimated value of gamma: {}, and the median value is {}'.format(gamma_trace[-1], np.median(gamma_trace)))
print('The estimated value of f0: {}, and the median value is {}'.format(f0_trace[-1], np.median(f0_trace)))

################################################################################################
# extract the traces and plot the results
pymc_traces = [MDL.trace('kappa')[-niter:],
               MDL.trace('gamma')[-niter:],
               MDL.trace('f0')[-niter:]]

################################################################################################
l=-.3
r=1.15
################################################################################################

def compute_sigma_level(trace1, trace2, nbins=20):
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
    ax.set_xlabel(r'$\gamma$',fontsize=24)
    ax.set_ylabel(r'$\kappa$',fontsize=24)
    ax.set_xlim([4.3, 4.8])
    ax.set_ylim([0.10, 0.106])
    ax.tick_params(axis='x', labelsize=14)    
    ax.tick_params(axis='y', labelsize=14)    
    ax.set_xticks([4.3,4.55,4.8])                                                       
    ax.set_yticks([0.1,0.103,0.106])
    ax.text(l,r, 'A', transform=ax.transAxes,
    fontsize=26,  va='top', ha='right')
    ax.plot([gamma_est],[kappa_est], 'ro')


################################################################################################    
    
def plot_Confidence2(ax, pymc_traces, scatter=False, **kwargs):
    """Plot traces and contours"""
    xbins, ybins, sig = compute_sigma_level(pymc_traces[2], pymc_traces[0])
    ax.contour(xbins, ybins, sig.T, levels=[0., 0.95], **kwargs)
    if scatter:
        ax.plot(pymc_traces[2], pymc_traces[0], ',b', alpha=0.1)
    ax.set_xlabel(r'$f_0$',fontsize=24)
    ax.set_ylabel(r'$\kappa$',fontsize=22)
    ax.set_xlim([2.98, 3.02])
    ax.set_ylim([0.10, 0.106])
    ax.tick_params(axis='x', labelsize=14)    
    ax.tick_params(axis='y', labelsize=14) 
    ax.set_xticks([2.98,3.0,3.02])   
    ax.set_yticks([0.1,0.103,0.106])
    ax.text(l,r, 'B', transform=ax.transAxes,
    fontsize=26,  va='top', ha='right')
    ax.plot([f0_est],[kappa_est], 'ro')

################################################################################################    
       
def plot_Confidence3(ax,  pymc_traces, scatter=False, **kwargs):
    """Plot traces and contours"""
    xbins, ybins, sig = compute_sigma_level(pymc_traces[2], pymc_traces[1])
    ax.contour(xbins, ybins, sig.T, levels=[0., 0.95], **kwargs)
    if scatter:
       ax.plot(pymc_traces[2], pymc_traces[1], ',b', alpha=0.1)
    ax.set_xlabel(r'$f_0$',fontsize=24)
    ax.set_ylabel(r'$\gamma$',fontsize=22)
    ax.set_xlim([2.98, 3.02])
    ax.set_ylim([4.3, 4.8])
    ax.tick_params(axis='x', labelsize=14)    
    ax.tick_params(axis='y', labelsize=14) 
    ax.set_xticks([2.98,3.0,3.02])   
    ax.set_yticks([4.3,4.55,4.8]) 
    ax.text(l, r, 'C', transform=ax.transAxes,
    fontsize=26,  va='top', ha='right')
    ax.plot([f0_est],[gamma_est], 'ro')
                                        

################################################################################################    
     
def plot_Confidences( trace, colors='k'):
    """Plot both the trace and the model together"""
    fig, ax = plt.subplots(1,3, figsize=(11, 3.4))
    plot_Confidence1(ax[0], trace, True, colors=colors)
    plot_Confidence2(ax[1], trace, True, colors=colors)
    plot_Confidence3(ax[2], trace, True, colors=colors)
    plt.tight_layout(pad=1.1, w_pad=.1, h_pad=.0)

###############################################################################################

plot_Confidences(pymc_traces)

#plt.savefig('Confidencecase1.eps', format='eps')
###############################################################################################
###############################################################################################
#Plot traces
kappa_trace = MDL.trace('kappa')[-burn:]
gamma_trace = MDL.trace('gamma')[-burn:]
f0_trace = MDL.trace('f0')[-burn:]
###############################################################################################

plt.figure(figsize=(10, 6))
plt.subplot(3,1,1)
plt.plot(kappa_trace, color='b')
plt.xlabel('Iterations',fontsize=14)
plt.ylabel('$\kappa$',fontsize=24)
plt.xticks(fontsize=14)
plt.yticks([0.101,0.103,0.105],fontsize=14)
plt.axhline(y=kappa_est, linewidth=2, color = 'r')


plt.subplot(3,1,2)
plt.plot(gamma_trace, color='b')
plt.xlabel('Iterations',fontsize=14)
plt.ylabel('$\gamma$',fontsize=24)
plt.xticks(fontsize=14)
plt.yticks([4.3,4.55,4.8],fontsize=14)
plt.axhline(y=gamma_est, linewidth=2, color = 'r')


plt.subplot(3,1,3)
plt.plot(f0_trace, color='b')
plt.xlabel('Iterations',fontsize=14)
plt.ylabel('$f_0$',fontsize=22)
plt.xticks(fontsize=14)
plt.yticks([2.98,3.0,3.02],fontsize=14)
plt.axhline(y=f0_est, linewidth=2, color = 'r')


plt.tight_layout(pad=1, w_pad=.1, h_pad=.0)
#plt.savefig('TracesCase1.png', format='png')
################################################################################################
################################################################################################
#Plot Histogram of traces

plt.figure(figsize=(4, 8))
plt.subplot(3,1,1)
plt.hist(kappa_trace, color='b', bins=20, normed=True)
plt.ylabel('Counts',fontsize=14)
plt.xlabel('$\kappa$',fontsize=22)
plt.xticks([0.101,0.103,0.105],fontsize=14)
plt.yticks([40,600,1200],fontsize=14)
plt.axvline(x=kappa_est,ymin=0, ymax = .95, linewidth=2, color = 'r')



plt.subplot(3,1,2)
plt.hist(gamma_trace, color='b', bins=22, normed=True);
plt.ylabel('Counts',fontsize=14)
plt.xlabel('$\gamma$',fontsize=22);
plt.xticks([4.3,4.55,4.8],fontsize=14)
plt.yticks([0,5,10],fontsize=14)
plt.axvline(x=gamma_est,ymin=0, ymax = .95, linewidth=2, color = 'r')


plt.subplot(3,1,3)
plt.hist(f0_trace, color='b', bins=20, normed=True);
plt.ylabel('Counts',fontsize=14)
plt.xlabel('$f_0$',fontsize=20);
plt.xticks([2.98,3.0,3.02],fontsize=14) 
plt.yticks([0,70,140],fontsize=14)
plt.axvline(x=f0_est,ymin=0, ymax = .95, linewidth=2, color = 'r')


plt.tight_layout(pad=1, w_pad=.1, h_pad=.0)
#plt.savefig('HistCase1.png', format='png')
################################################################################################
################################################################################################
#pymc.Matplot.plot(MDL)
################################################################################################    
#################################################################################################
kappa_min=MDL.kappa.stats()['quantiles'][2.5]
kappa_max=MDL.kappa.stats()['quantiles'][97.5]
gamma_min=MDL.gamma.stats()['quantiles'][2.5]
gamma_max=MDL.gamma.stats()['quantiles'][97.5]
f0_min=MDL.f0.stats()['quantiles'][2.5]
f0_max=MDL.f0.stats()['quantiles'][97.5]


y_true= func_damposc(w=w,kappa=kappa_true,gamma=gamma_true,f0=f0_true )
y_est = func_damposc(w=w,kappa=kappa_est, gamma=gamma_est, f0=f0_est )
y_min = func_damposc(w=w,kappa=kappa_min, gamma=gamma_min, f0=f0_min )
y_max = func_damposc(w=w,kappa=kappa_max, gamma=gamma_max, f0=f0_max  )

################################################################################################
   
def plot_MCMC_model(xdata, ydata,y_true,y_est,y_min,y_max):
    """Plot the linear model and 2sigma contours"""
    plt.plot(xdata,ydata ,'b', marker='None', ls='-', lw=1, label='Measured Signal')
    plt.plot(xdata,y_true,'r', marker='None', ls='-', lw=4, label='True Signal')
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
#plt.savefig('ModelCase1.eps', format='eps')

###############################################################################################