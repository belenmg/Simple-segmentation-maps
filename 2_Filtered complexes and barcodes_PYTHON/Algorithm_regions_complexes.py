# -*- coding: utf-8 -*-
"""
Created on Tue Jun  7 10:23:27 2022

@author: belenmg
"""

from itertools import combinations
import numpy as np
import math as mt

#######################################################################################
def region_complex(I,cm): 
    
    # INPUT: 
    # I = labelled image 
    # cm = matrix with the centroids 
    
    rows, columns = I.shape
    
    rows_boundary_pixels = np.where(I == 0)[0]
    columns_boundary_pixels = np.where(I == 0)[1]
    n = len(rows_boundary_pixels) 
    
    # zero padding
    I2 = I
    l1 = np.zeros((1, I2.shape[1])) 
    l2 = np.zeros((I2.shape[0]+2,1))
    I2 = np.vstack([l1,I2,l1])
    I2 = np.append(I2,l2,axis = 1)
    I2 = np.append(l2,I2,axis = 1) 
    
    # Initialize
    F_simplices = []
    F_filter_value = []
    F_pixel = []
    
    for k1 in range(n):
        
        i = rows_boundary_pixels[k1]
        j = columns_boundary_pixels[k1]
        
        # Labels in the 3x3 neighborhood of the pixel (i,j)
        E3 = [I2[i][j],I2[i][j+1],I2[i][j+2],I2[i+1][j],I2[i+1][j+1],I2[i+1][j+2],
              I2[i+2][j],I2[i+2][j+1],I2[i+2][j+2]]
               
        E3 = list(set(E3)) 
        E3.remove(0)           
        
        # d = distances of the pixel (i,j) to each centroid with label in E3.
        d = []        
        for k2 in range(len(E3)):
            label = E3[k2]
            row_label = np.where(cm[:,2] == label)[0][0]
            cm_label = [cm[row_label][1]-1,cm[row_label][0]-1]
            d_label = mt.sqrt((cm_label[0]-i)**2 + (cm_label[1]-j)**2)
            d.append(d_label)
        
        # Edges:     
        A = list(combinations(range(len(E3)), 2))
        
        for s in range(len(A)): 

            lk1 = E3[A[s][0]]
            lk2 = E3[A[s][1]]            
            edge = [lk1,lk2] 
            
            dk1 = d[A[s][0]]
            dk2 = d[A[s][1]] 
            dmax = max([dk1,dk2])
            
            if sorted(edge) in F_simplices: 
                pos = F_simplices.index(sorted(edge))
                dprima = F_filter_value[pos]
                if dmax < dprima: 
                    F_filter_value[pos] = dmax
                    F_pixel[pos] = [i,j]
            else:
                F_simplices.append(sorted(edge)) 
                F_filter_value.append(dmax)
                F_pixel.append([i,j])
                
        # Triangles
        T = list(combinations(range(len(E3)), 3))
       
        for s in range(len(T)):            
            lk1 = E3[T[s][0]]
            lk2 = E3[T[s][1]]
            lk3 = E3[T[s][2]]            
            triangle = [lk1,lk2,lk3]
            
            dk1 = d[T[s][0]]
            dk2 = d[T[s][1]]  
            dk3 = d[T[s][2]]
            dmax = max([dk1,dk2,dk3])
            
            if sorted(triangle) in F_simplices: 
                pos = F_simplices.index(sorted(triangle))
                dprima = F_filter_value[pos]
                if dmax < dprima: 
                    F_filter_value[pos] = dmax
                    F_pixel[pos] = [i,j]
            else:
                F_simplices.append(sorted(triangle)) 
                F_filter_value.append(dmax)
                F_pixel.append([i,j])
            
        # Tetrahedra
        if len(E3)==4:             
            F_simplices.append(sorted(E3))
            F_filter_value.append(max(d)) 
            F_pixel.append([i,j])
            
        #############################################################   
        
        if i < rows-1 and j < columns-1 and I2[i+1][j+2]==0 and I2[i+2][j+1]==0 and I2[i+2][j+2]==0:
    
            E4 = [I2[i][j],I2[i][j+1],I2[i][j+2],I2[i][j+3],
                  I2[i+1][j],I2[i+1][j+1],I2[i+1][j+2],I2[i+1][j+3],
                  I2[i+2][j],I2[i+2][j+1],I2[i+2][j+2],I2[i+2][j+3],
                  I2[i+3][j],I2[i+3][j+1],I2[i+3][j+2],I2[i+3][j+3]]
            
            E4 = list(set(E4)) 
            E4.remove(0) 
            
            d = []        
            for k2 in range(len(E4)):
                label = E4[k2]
                row_label = np.where(cm[:,2] == label)[0][0]
                cm_label = [cm[row_label][1]-1,cm[row_label][0]-1]
                d_label = mt.sqrt((cm_label[0]-(i+1/2))**2 + (cm_label[1]-(j+1/2))**2)
                d.append(d_label)
            
            # Edges   
            A = list(combinations(range(len(E4)), 2))
            
            for s in range(len(A)): 
                
                lk1 = E4[A[s][0]]
                lk2 = E4[A[s][1]]            
                edge = [lk1,lk2]              
    
                dk1 = d[A[s][0]]
                dk2 = d[A[s][1]]        
                dmax = max([dk1,dk2])
            
                if sorted(edge) in F_simplices: 
                    pos = F_simplices.index(sorted(edge))
                    dprima = F_filter_value[pos]
                    if dmax < dprima: 
                        F_filter_value[pos] = dmax
                        F_pixel[pos] = [i,j]
                else:
                    F_simplices.append(sorted(edge)) 
                    F_filter_value.append(dmax)
                    F_pixel.append([i,j])
                    
            # Triangles
            T = list(combinations(range(len(E4)), 3))
       
            for s in range(len(T)):            
                lk1 = E4[T[s][0]]
                lk2 = E4[T[s][1]]
                lk3 = E4[T[s][2]]            
                triangle = [lk1,lk2,lk3]
            
                dk1 = d[T[s][0]]
                dk2 = d[T[s][1]]  
                dk3 = d[T[s][2]]
                dmax = max([dk1,dk2,dk3])
                
                if sorted(triangle) in F_simplices: 
                    pos = F_simplices.index(sorted(triangle))
                    dprima = F_filter_value[pos]
                    if dmax < dprima: 
                        F_filter_value[pos] = dmax
                        F_pixel[pos] = [i,j]
                else:            
                    F_simplices.append(sorted(triangle)) 
                    F_filter_value.append(dmax)
                    F_pixel.append([i,j])  
                
        # Tetrahedra
            F_simplices.append(sorted(E4))
            F_filter_value.append(max(d)) 
            F_pixel.append([i,j])
              
    return F_simplices,F_filter_value,F_pixel

###################################################################################

def valid_region_complex(valid_regions,F_simplices,F_filter_value,F_pixel):
    
    F_simplices2 = []
    F_filter_value2 = [] 
    F_pixel2 = []
    
    for i in range(len(F_simplices)):
        simplex = F_simplices[i]
        L = [simplex[i] for i in range(len(simplex)) if simplex[i] in valid_regions]
        if len(L) == len(simplex):
            F_simplices2.append(F_simplices[i])
            F_filter_value2.append(F_filter_value[i])
            F_pixel2.append(F_pixel[i])  
            
    vertices = [[e] for e in valid_regions[0]]
    F_simplices2.extend(vertices)
    
    values = [0] * len(vertices)
    F_filter_value2.extend(values)    
    
    return F_simplices2, F_filter_value2, F_pixel2

#######################################################################################

