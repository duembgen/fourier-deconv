#! /usr/bin/env python3
# -*- coding: utf-8 -*-
"""
plot-tools.py: Some useful functions for plotting. 
"""

import matplotlib.pyplot as plt
import matplotlib as mpl

FOLDER = 'plots/'

def full_frame(width=None, height=None):
    ''' Nearly completely remove all borders from a plot. '''
    mpl.rcParams['savefig.pad_inches'] = 0
    figsize = None if width is None else (width, height)
    fig = plt.figure(figsize=figsize)
    ax = plt.axes([0,0,1,1], frameon=False)
    ax.get_xaxis().set_visible(False)
    ax.get_yaxis().set_visible(False)
    plt.autoscale(tight=True)
    return fig, ax
    
def plot_matrix(A, saveas='', cmap='RdBu', vmin=None, vmax=None):
    fig, ax = full_frame(A.shape[1], A.shape[0])
    ax.matshow(A, cmap=cmap, vmin=vmin, vmax=vmax)
    
    if saveas != '':
        plt.savefig(FOLDER + saveas)
