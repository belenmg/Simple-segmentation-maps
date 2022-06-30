#!/usr/bin/env python
# coding: utf-8

# In[ ]:


# -*- coding: utf-8 -*-
"""
Created on Tue Jun  7 13:34:30 2022

@author: belenmg
"""

from itertools import combinations 
import numpy as np
from scipy.spatial import Delaunay
import math as mt

######################################################################################

def alpha_complex(I,cm):    
    
    F_simplices = []
    F_filter_value = []
    
    cm_2 = np.delete(cm,2,axis=1) 
    
    DT =  Delaunay(cm_2)
    
    dt = DT.simplices 
                      
    for t in range(len(dt)):
        
        tri = dt[t] 
        
        d = [] 
        
        A = list(combinations(range(3), 2)) # A = [(0,1),(0,2),(1,2)]
        
        for s in range(len(A)):
            
            row_cm_vert1 = tri[A[s][0]] # tri[0]
            row_cm_vert2 = tri[A[s][1]] # tri[1]
            edge = [cm[row_cm_vert1][2],cm[row_cm_vert2][2]] 
            
            cm1 = [cm[row_cm_vert1][0]-1,cm[row_cm_vert1][1]-1]
            cm2 = [cm[row_cm_vert2][0]-1,cm[row_cm_vert2][1]-1]
            d_e = mt.sqrt((cm1[0]-cm2[0])**2 + (cm1[1]-cm2[1])**2)
            d.append(d_e)
            
            if sorted(edge) not in F_simplices:                
                F_simplices.append(sorted(edge)) 
                F_filter_value.append(d_e/2)
        
        region1 = cm[tri[0]][2]
        region2 = cm[tri[1]][2]
        region3 = cm[tri[2]][2]
        
        semiperimeter = (d[0] + d[1] + d[2])/2
        r = d[0]*d[1]*d[2]/4.0/mt.sqrt(semiperimeter*(semiperimeter-d[0])*(semiperimeter-d[1])*(semiperimeter-d[2]))
        
        F_simplices.append(sorted([region1,region2,region3]))
        F_filter_value.append(r)
        
    return F_simplices, F_filter_value


#######################################################################################

def valid_alpha_complex(valid_regions,F_simplices,F_filter_value):
    
    F_simplices2 = []
    F_filter_value2 = [] 
    
    for i in range(len(F_simplices)):
        simplex = F_simplices[i]
        L = [simplex[i] for i in range(len(simplex)) if simplex[i] in valid_regions]
        if len(L) == len(simplex):
            F_simplices2.append(F_simplices[i])
            F_filter_value2.append(F_filter_value[i])
            
    vertices = [[e] for e in valid_regions[0]]
    F_simplices2.extend(vertices)
    
    values = [0] * len(vertices)
    F_filter_value2.extend(values)  
      
    return F_simplices2, F_filter_value2  

#######################################################################################

