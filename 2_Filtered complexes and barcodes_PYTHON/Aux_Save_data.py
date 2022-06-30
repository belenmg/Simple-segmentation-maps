# -*- coding: utf-8 -*-
"""
Created on Tue Jun  7 12:17:16 2022

@author: belenmg
"""

import numpy as np


def save_complex(path, F_simplices, F_filter):
    
    S = np.array([[F_simplices[0][0],F_simplices[0][1],-1,-1,F_filter[0]]])    
    for i in range(1,len(F_simplices)):
        if len(F_simplices[i])==1:
            S = np.append(S,[[F_simplices[i][0],-1,
                              -1,-1,0]],axis=0)
        elif len(F_simplices[i])==2:
            S = np.append(S,[[F_simplices[i][0],F_simplices[i][1],
                              -1,-1,F_filter[i]]],axis=0)
        elif len(F_simplices[i])==3:
            S = np.append(S,[[F_simplices[i][0],F_simplices[i][1],
                              F_simplices[i][2],-1,F_filter[i]]],axis=0)
        else:
            S = np.append(S,[[F_simplices[i][0],F_simplices[i][1],
                              F_simplices[i][2],F_simplices[i][3],F_filter[i]]],axis=0)
        
    np.savetxt(path,S,fmt='%d %d %d %d %f')
    
    
def save_perst(path, perst):
    
    A = list(map(lambda x : np.array([x[0], x[1][0], x[1][1]]), perst))
    A = np.matrix(A)
    np.savetxt(path,A,fmt='%d %f %f')