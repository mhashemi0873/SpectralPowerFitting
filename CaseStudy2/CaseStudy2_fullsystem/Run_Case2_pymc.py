#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu Dec  1 17:52:24 2016

@author: meysamhashemi
"""
# Hashemi et al, Neuroinformatics 2018

import math 
import pymc
import numpy as np
import scipy.io as sio
import matplotlib.pyplot as plt; 

Xdata = sio.loadmat('Xdata.mat')['Xdata']
Ydata = sio.loadmat('Ydata.mat')['Ydata']


xdata=Xdata.T[0]
ydata=Ydata.T[0]

niter=200000
burn=20000

kappa_true = 0.1
tau_true=0.2;
Omega_true=2.0;


epsilon=1;
a_true=((2*np.pi)*Omega_true/np.tan((2*np.pi)*Omega_true*tau_true))-epsilon
b_true=-(2*np.pi)*Omega_true/np.sin((2*np.pi)*Omega_true*tau_true)

w=2*np.pi*xdata;


func_DelayLin= lambda w, kappa, a , b, tau: np.log((2*kappa)*(1./(((a+b*np.cos(tau*w))**2)+((w+b*np.sin(tau*w))**2))))



Power_true = func_DelayLin(w=w, kappa=kappa_true, a=a_true, b=b_true, tau=tau_true )


sigma=pymc.Uniform('sigma',0.0,100.0)
kappa  =  pymc.Uniform('kappa',    0.0, 20.0)
a = pymc.Uniform('a',  -50.0, 0.0)
b= pymc.Uniform('b',  -50.0, 0.0)
tau = pymc.Uniform('tau',  0.0, 20.0)



@pymc.deterministic
def y_model(w=w, kappa=kappa, a=a, b=b,  tau=tau):
    return np.log((2*kappa)*(1./(((a+b*np.cos(tau*w))**2)+((w+b*np.sin(tau*w))**2))))
    
    
y = pymc.Normal('y', mu=y_model, tau=1.0 / (sigma ** 2.0), value=ydata, observed=True)


DelayLin_model = dict(kappa=kappa,  a=a, b=b, tau=tau, sigma=sigma, y_model=y_model, y=y)


MDL = pymc.MCMC(DelayLin_model)    
MDL.sample(niter, burn)


kappa_trace = MDL.trace('kappa')[:]
a_trace = MDL.trace('a')[:]
b_trace = MDL.trace('b')[:]
tau_trace = MDL.trace('tau')[:]

kappa_est = np.median(kappa_trace)
a_est = np.median(a_trace)
b_est = np.median(b_trace)
tau_est = np.median(tau_trace)


Power_est = func_DelayLin(w=w, kappa=kappa_est, a=a_est, b=b_est, tau=tau_est )



runfile('PlotCaseStudy2_pymc.py')

