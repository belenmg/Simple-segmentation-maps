%-------------------------------------------------------------------------
% This script: 
% 
% I.   Reads an labelled image (.txt) from the folders 
%      1_Preprocessing/B_Labelled images/** 
%
% II.  Obtains a matrix M with the centroids of all the regions. 
%      Each row of M is [a b c] where a and b are the column and the row (x e y) 
%      of the centroid of the region with label c. 
%
% III. Save the matrix M in the folders 1_Preprocessing/D_Centroids/**.
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

        for i = 1:n_k
            path_regions = strcat('../1_Preprocessing/B_Labelled images/',imgs(k).name,'/',imgs_k(i).name);
            regions = load(path_regions);
            s = regionprops(regions,'centroid');
            cm = cat(1,s.Centroid);
            cm2 = [];
            for j = 1:size(cm,1)
                cm2 = [cm2; cm(j,1) cm(j,2) j];
            end
            path_cm = strcat('../1_Preprocessing/D_Centroids/',imgs(k).name,'/',erase(imgs_k(i).name,'_labels.txt'),'_cm.txt');
            writematrix(cm2,path_cm,'Delimiter',' ');
        end
    end
end

