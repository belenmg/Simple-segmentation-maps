%-------------------------------------------------------------------------
% Hit-or-miss transform: operation that detects a given configuration in a 
% binary image, using the morphological erosion operator and a pair of 
% disjoint structuring elements. 
%-------------------------------------------------------------------------


function J = thinning(I,n)
%-------------------------------------------------------------------------
% INPUT:  Binary image I  
%         n = number of times that Hit-or-miss transform is applied.
% OUTPUT: Thinned image J 
%-------------------------------------------------------------------------

    % Consider the eight composite structuring elements:

    se1_1 = [0 0 0;0 1 0;1 1 1];
    se2_1 = [1 1 1;0 0 0;0 0 0];

    se1_2 = [0 0 0;1 1 0;1 1 0];
    se2_2 = [0 1 1;0 0 1;0 0 0];

    se1_3 = [1 0 0;1 1 0;1 0 0];
    se2_3 = [0 0 1;0 0 1;0 0 1];

    se1_4 = [1 1 0;1 1 0;0 0 0];
    se2_4 = [0 0 0;0 0 1;0 1 1];

    se1_5 = [1 1 1;0 1 0;0 0 0];
    se2_5 = [0 0 0;0 0 0;1 1 1];

    se1_6 = [0 1 1;0 1 1;0 0 0];
    se2_6 = [0 0 0;1 0 0;1 1 0];

    se1_7 = [0 0 1;0 1 1;0 0 1];
    se2_7 = [1 0 0;1 0 0;1 0 0];

    se1_8 = [0 0 0;0 1 1;0 1 1];
    se2_8 = [1 1 0;1 0 0;0 0 0];

    se1 = [se1_1 se1_2 se1_3 se1_4 se1_5 se1_6 se1_7 se1_8];
    se2 = [se2_1 se2_2 se2_3 se2_4 se2_5 se2_6 se2_7 se2_8];

    % The thinning of an image I is obtained by cyclically iterating until 
    % convergence (it is applied n times):

    for i = 1:n
        for j = 1:8
            I1 = bwhitmiss(I,se1(:,3*j-2:3*j),se2(:,3*j-2:3*j));
            I = I-I1; 
        end
    end

    J = I;
end