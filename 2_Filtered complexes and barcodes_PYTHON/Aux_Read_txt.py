# -*- coding: utf-8 -*-
"""
Created on Tue Jun  7 10:10:45 2022

@author: belenmg
"""

import numpy as np

##################################################################

def read_txt(file):
    
    A = []
    
    with open(file) as fname: 
        lines = fname.readlines()
        for line in lines:
            A.append(line.split())
    
    #file.close()

    for i in range(len(A)):
        for j in range(len(A[0])):
            A[i][j] = int(A[i][j])
            
    return np.array(A)

##################################################################

def read_txt2(file):
    
    A = []
    
    with open(file) as fname: 
        lines = fname.readlines()
        for line in lines:
            A.append(line.split())
    
    #file.close()
            
    for i in range(len(A)):
        for j in range(len(A[0])):
            A[i][j] = float(A[i][j])
            
    return np.array(A)

