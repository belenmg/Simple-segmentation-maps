
%-------------------------------------------------------------------------
% This script: 
% 
% I.   Reads an image .png from the folders 0_Dataset/**
% 
% II.  Applies the thinning function [thinning.m] to the negative of the 
%      image, that is, in black the regions and in with the boundary 
%      between them. 
% 
% III. Save the negative of the thinned image in the folders 
%      1_Preprocessing/A_Thinned images/**.
%-------------------------------------------------------------------------

imgs = dir('../0_Dataset/');
n = length(imgs);

for k = 3:n
    if isfile(imgs(k).name)
    else
        s = strcat('../0_Dataset/',imgs(k).name,'/*.png');
        imgs_k = dir(s);
        n_k = length(imgs_k);

        for i = 1:n_k
            path_I = strcat('../0_Dataset/',imgs(k).name,'/',imgs_k(i).name);
            I = imread(path_I);
            I_thinned = thinning(not(I),100);
            I_thinned = not(I_thinned);
            path_I_thinned = strcat('../1_Preprocessing/A_Thinned images/',imgs(k).name,'/',imgs_k(i).name);
            imwrite(I_thinned,path_I_thinned);
        end
    end
end

