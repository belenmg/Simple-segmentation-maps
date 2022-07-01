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
           
D_Centroids.m takes the labelled images (.txt) of 'B_Labelled images' and applies the MATLAB function regionprops to get the centroids of each region. The results are saved in the folder D_Centroids.


-------------------------------------------
2_Filtered complexes and barcodes_PYTHON/
-------------------------------------------

Aux_Read_txt.py contain two functions:

          read_txt -> INPUT: .txt file. 
                      OUTPUT: matrix wtih the elements of the file converted to int.
          read_txt2 -> INPUT: .txt file 
                       OUTPUT: matrix with the elements of the file converted to float.
          
Algorithm_regions_complexes.py contain two functions to compute our filtered simplicial complex:

          region_complex -> INPUT: A labelled image I (B_Labelled images) and the centroids cm of each region of I (D_Centroids)
                            OUTPUT: F_simplices, F_filter_value, F_pixel -> simplices, filter value for each simplex and boundary pixel where the filter value is      obtained, respectively.
          
          valid_region_complex -> INPUT: List of the valid regions (C_Used regions) and outputs of the previous function region_complex.
                                  OUTPUT: F_simplices, F_filter_value, F_pixel -> simplices, filter value for each simplex and boundary pixel where the filter value is obtained, respectively, considering only the labels of the valid regions. 
   
Algorithm_alpha_complexes.py contain two functions similar to the previous ones to compute the alpha complex.

Aux_Persistence_homology.py contains a function:

          homology -> INPUT: F_simplices, F_filter_value (outputs of the functions valid_region_complex and alpha_region_complex)
                      OUTPUT: Persistence homology (barcode) of the complex.
          
Aux_Save_data.py contain two functions to save the previous results:

          save_complex -> INPUT: path (where we want to save the complex), F_simplices and F_filter_value. 
                     
          save_perst takes -> INPUT: path (where we want to save the barcode) and output of the function homology.
          
-------------------------------------------

JUPYTER NOTEBOOKS to get the results save in the folder 3_Results:

Get_region_complexes_and_barcodes.ipynb

Get_alpha_complexes_and_barcodes.ipynb

----------
3_Results/
----------

Folder Filtered complexes: contain the region and alpha filtered complexes in both txt (outputs of the python functions) and png. For the png, use the MATLAB script Representing_complexes.m

          auxiliar functions: draw_complexes.m
          
Folder Barcodes: contain the persistence homology of the region and alpha filtered complexes in both txt (outputs of the python functions) and png. For the png, use the MATLAB script Representing_barcodes.m.

          
