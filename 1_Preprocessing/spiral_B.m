%-------------------------------------------------------------------------
% This is a modification of the script spiral.m in
% https://github.com/Cimagroup/topo-summaries-for-packed-tissues by Manuel
% Soriano Trigueros
%-------------------------------------------------------------------------

function list = spiral_B(regions, number)
%-------------------------------------------------------------------------
% INPUT: an image segmentated in regions [regions] and the number of cells 
%        we want to obtain [number].
%
% OUTPUT: a [list] with the [number] of regions obtained following the 
%         spiral  algorithm. If [number] is greater than the number of valid 
%         regions or number = 0, [list] is the list of all the valid 
%         regions.
%-------------------------------------------------------------------------

[extreme1, extreme2] = size(regions);

%-------------------------------------------------------------------------
% Consider valid_regions as the list with all the labels of the input 
% [regions] except the label 0 (boundary pixels) and the labels of the 
% regions of the boundary of the image.
%-------------------------------------------------------------------------

valid_regions = reshape(regions,[1,size(regions,1)*size(regions,2)]);
valid_regions = unique(valid_regions); % remove duplicate labels
valid_regions(valid_regions==0) = [];  % remove the label 0 

% remove the labels of the first and last rows.
for i = 1:extreme2
    valid_regions(valid_regions == regions(1,i)) = [];
    valid_regions(valid_regions == regions(extreme1,i)) = [];
end
% remove the labels of the first and last columns.
for i = 1:extreme1
    valid_regions(valid_regions == regions(i,1)) = [];
    valid_regions(valid_regions == regions(i,extreme2)) = [];
end

n = length(valid_regions);
%-------------------------------------------------------------------------

pos1 = floor(extreme1/2);
pos2 = floor(extreme2/2);

if number > n || number == 0
    list = valid_regions;
else
    j = 1;
    list = zeros(1, number);

    % (pos1,pos2) will be the starting point of our algorithm.
    if regions(pos1,pos2) ~= 0
        list(j) = regions(pos1,pos2);
        j = j + 1;
    end

    % We look for cells rounding our starting point and stop when arriving
    % desired number of cells or to the boundaries of the image.
    i = 1;
    while j <= number && pos1 < extreme1 && pos2 < extreme2 ...
            && pos1>0 && pos2>0
        Xaux = 1;
        Yaux = 1;
        while Yaux <= i && j <= number && pos2 < extreme2 ...
                && pos1>0 && pos2>0
            pos2 = pos2 + (-1)^(i+1);
            Yaux = Yaux+1;
            if regions(pos1,pos2)~=0 && ~ismember(regions(pos1,pos2),list)... 
                    && ismember(regions(pos1,pos2),valid_regions)
                list(j)=regions(pos1,pos2);
                j = j + 1;
            end
        end
        while Xaux <= i && j <= number && pos1 < extreme1 ...
                && pos2 < extreme2
        pos1 = pos1 + (-1)^(i+1);
        Xaux = Xaux+1;
            if regions(pos1,pos2)~=0 && ~ismember(regions(pos1,pos2),list)...
                    && ismember(regions(pos1,pos2),valid_regions) 
                list(j)=regions(pos1,pos2);
                j = j + 1;
            end
        end
        i = i+1;
    end

end

end

