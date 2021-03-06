%-------------------------------------------------------------------------
% This script: 
%
% I.   Reads an labelled image (.txt) from the folders
%      1_Preprocessing/B_Labelled images/**
%
% II.  Applies the function [spiral_B.m] to the labelled image: 
%      list = spiral_B(regions, number) -> returns a list with the labels 
%      of the regions considered for the later construction of the 
%      complexes -> [regions] is the labelled image and [number] is the 
%      number of labels. We consider number = 0 for the simple segmentation 
%      maps (this is, list constains the labels of all the valid regions) 
%      and number = 187 for the cell images.
% 
% III. Save the list in the folders 1_Preprocessing/C_Used regions/**.
%-------------------------------------------------------------------------

imgs = dir('../1_Preprocessing/B_Labelled images/');
n = length(imgs);

for k = 3:n
    if isfile(imgs(k).name)
    else
        % imgs(k).name = Cell images
        % imgs(k).name = Simple images
        s = strcat('../1_Preprocessing/B_Labelled images/',imgs(k).name,'/*.txt');
        imgs_k = dir(s);
        n_k = length(imgs_k);

        if isequal(imgs(k).name,'Cell images')
            number = 187;
        else
            number = 0;
        end

        for i = 1:n_k
            path_regions = strcat('../1_Preprocessing/B_Labelled images/',imgs(k).name,'/',imgs_k(i).name);
            regions = load(path_regions);
            list = spiral_B(regions, number);
            path_list = strcat('../1_Preprocessing/C_Used regions/',imgs(k).name,'/',erase(imgs_k(i).name,'_labels.txt'),'_used_regions.txt');
            writematrix(list,path_list,'Delimiter',' ');
        end
    end
end

