# Simple-segmentation-maps

We propose a geometry-aware topological analysis of a segmentation of an image into regions which might correspond, for example, to a geographical map or to segmented cells in a microscopic image of a biological packed tissue. The regions must live with the constraint that the centroid of each one lies inside the region itself.
We propose a novel simplicial complex modeling such data, for persistent homology computation, that better respects the geometry of the regions than existing techniques. More specifically, our approach joins benefits from previous models by encoding both, real neighbouring relations between the regions, as well as spatial distribution of the set of centroids. In addition, introduces geometric information regarding distances between centroids and boundaries delimiting each region.

The following software is required:

- Matlab
- Python

----------
0_Dataset/
----------

INPUT IMAGES: 

Binary images (.png) representing the partition of the plane in regions. In white, each region and in black, the boundary between them. There are two subfolders:

- Simple images: Synthetic images representing a tessellation of the plane or pieces of cellular tissue.
- Cell  images:  Images of cellular tissue.

---------------
1_Preprocesing/
---------------

A_Thinned_images.m takes the images .png of 0_Dataset, applies the function thinning.m and saves the thinned resulting images .png in the folder A_Thinned images.

           auxiliar functions: thinning.m

B_Labelled_images.m takes the thinned images .png of 'A_Thinned images' and applies the MATLAB function bwlabel to get a matrix L (.txt file) containing labels for the 4-connected regions in the initial image. The .txt file resulting are saved in the folder B_Labelled images.

C_Uded_regions.m takes the labelled images (.txt) of 'B_Labelled images' and applies the function spiral_B.m to get a list with the labels of the regions considered for the later construction of the complexes, considering number = 0 for the simple images and number = 187 for the cell images.

           auxiliar functions: spiral_B.m
           
D_Centroids.m takes the labelled images (.txt) of 'B_Labelled images' and applies the MATLAB function regionprops to get the centroids of each region. The results are saved in the folder D_Centroid.


-------------------------------------------
2_2_Filtered complexes and barcodes_PYTHON/
-------------------------------------------

Aux_Read_txt.py file contain two functions:

          read_txt takes a .txt file and returns a matrix wih the elements of the file converted to int.
Aux_Save_data.py 

