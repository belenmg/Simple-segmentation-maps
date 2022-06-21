%-------------------------------------------------------------------------
% This script: 
%
% I.   Reads an thinned image (.png) from the folders
%      1_Preprocessing/A_Thinned images/**
%
% II.  Applies MATLAB function [bwlabel] to the thinned image: 
%      L = bwlabel(I,n) -> returns a matrix L, of the same size as I, 
%      containing labels for the regions in I. In this case, n = 4 
%      (4-connected regions).
% 
% III. Save the labbeled image (.txt) in the folders 
%      1_Preprocessing/B_Labelled images/**.
%-------------------------------------------------------------------------

imgs = dir('../1_Preprocessing/A_Thinned images/');
n = length(imgs);

for k = 3:n
    if isfile(imgs(k).name)
    else
        % imgs(k).name = Cell images
        % imgs(k).name = Simple images
        s = strcat('../1_Preprocessing/A_Thinned images/',imgs(k).name,'/*.png');
        imgs_k = dir(s);
        n_k = length(imgs_k);

        for i = 1:n_k
            path_I = strcat('../1_Preprocessing/A_Thinned images/',imgs(k).name,'/',imgs_k(i).name);
            I = imread(path_I);
            L = bwlabel(I,4);
            path_L = strcat('../1_Preprocessing/A_Thinned images/',imgs(k).name,'/',erase(imgs_k(i).name,'.png'),'_labels.txt');
            writematrix(L,path_L,'Delimiter',' ');
        end
    end
end


