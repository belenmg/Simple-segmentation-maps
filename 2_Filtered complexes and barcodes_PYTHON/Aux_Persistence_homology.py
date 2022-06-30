# -*- coding: utf-8 -*-
"""
Created on Tue Jun  7 13:23:12 2022

@author: belenmg
"""

import gudhi as gd
import gudhi.representations

################################################################

def homology(F_simplices, F_filter_value):
    
    st = gd.SimplexTree()

    for i in range(len(F_simplices)):
        st.insert(F_simplices[i], filtration = F_filter_value[i])

    perst = st.persistence(persistence_dim_max=True)
    
    return perst