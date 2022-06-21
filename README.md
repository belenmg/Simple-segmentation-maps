# Simple-segmentation-maps

We propose a geometry-aware topological analysis of a segmentation of an image into regions which might correspond, for example, to a geographical map or to segmented cells in a microscopic image of a biological packed tissue. The regions must live with the constraint that the centroid of each one lies inside the region itself.
We propose a novel simplicial complex modeling such data, for persistent homology computation, that better respects the geometry of the regions than existing techniques. More specifically, our approach joins benefits from previous models by encoding both, real neighbouring relations between the regions, as well as spatial distribution of the set of centroids. In addition, introduces geometric information regarding distances between centroids and boundaries delimiting each region.

The following software is required:

- Matlab
- Python

----------
0_Dataset/
----------
