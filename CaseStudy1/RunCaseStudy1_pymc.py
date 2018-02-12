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
burn=10000


kappa_true = 0.1
gamma_true=5.;
f0_true=3.;

w=2*np.pi*xdata;


func_damposc= lambda w, kappa, gamma,f0: np.log((2*kappa)*(1/((((w**2)-((2*np.pi*f0)**2))**2)+((gamma*w)**2))))

Power_true = func_damposc(w=w, kappa=kappa_true, gamma=gamma_true, f0=f0_true )


sigma = pymc.Uniform('sigma',  0.0, 100.0)
kappa =   pymc.Uniform('kappa',    0.0, 20.0)
gamma= pymc.Uniform('gamma', 0.0, 20.0)
f0=pymc.Uniform('f0',0.0, 20.0)


@pymc.deterministic
def y_model(w=w, kappa=kappa, gamma=gamma, f0=f0):
    return np.log((2.0*kappa)*(1/((((w**2.0)-((2*np.pi*f0)**2))**2.0)+((gamma*w)**2.0))))
    
    
y = pymc.Normal('y', mu=y_model, tau=1.0 / (sigma ** 2.0), value=ydata, observed=True)


DampedOscil_model = dict(kappa=kappa, gamma=gamma, f0=f0, sigma=sigma, y_model=y_model, y=y)


MDL = pymc.MCMC(DampedOscil_model)    
MDL.sample(niter, burn)


kappa_trace = MDL.trace('kappa')[:]
gamma_trace = MDL.trace('gamma')[:]
f0_trace = MDL.trace('f0')[:]

kappa_est = np.median(kappa_trace)
gamma_est = np.median(gamma_trace)
f0_est= np.median(f0_trace)


Power_est = func_damposc(w=w, kappa=kappa_est, gamma=gamma_est, f0=f0_est )




runfile('PlotCaseStudy1_pymc.py')