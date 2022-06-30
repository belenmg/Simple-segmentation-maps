%--------------------------------------------------------------------------
% Draw the thinned inicial image and the complex on it.
%--------------------------------------------------------------------------

type1 = 'Cell images\'; 
type2 = 'Simple images\';

type = type1;

% Region complex

t1 = strcat('..\1_Preprocessing\A_Thinned images\',type,'*.png');
d1 = dir(t1);
t2 = strcat('..\3_Results\Filtered complexes\Region complexes\',type,'txt\*.txt');
d2 = dir(t2);
t3 = strcat('..\1_Preprocessing\C_Sample of regions\',type,'*.txt');
d3 = dir(t3);
t4 = strcat('..\1_Preprocessing\D_centroids\',type,'*.txt');
d4 = dir(t4);

n = length(d1);

instant = 10000;

for i = 1:n
    s_img = strcat('..\1_Preprocessing\A_Thinned images\',type,d1(i).name);
    s_complex = strcat('..\3_Results\Filtered complexes\Region complexes\',type,'txt\',d2(i).name);
    s_vr = strcat('..\1_Preprocessing\C_Used regions\',type,d3(i).name);
    s_cm = strcat('..\1_Preprocessing\D_Centroids\',type,d4(i).name);
    im = imread(s_img);
    complex = load(s_complex);
    vr = load(s_vr);
    cm = load(s_cm);
    
    figure()
    imshow(im)
    hold on
    draw_complexes(complex,cm,vr,instant)
    hold off

    s_fig = strcat('..\3_Results\Filtered complexes\Region complexes\',type,'png\',erase(d1(i).name,'.png'),'_region_complex.png');
    saveas(gcf,s_fig);
end

% Alpha complex

t2 = strcat('..\2_Filtered complexes\Alpha complexes\',type,'txt\*.txt');
d2 = dir(t2);

for i = 1:n
    s_img = strcat('..\1_Preprocessing\A_Thinned images\',type,d1(i).name);
    s_complex = strcat('..\3_Results\Filtered complexes\Alpha complexes\',type,'txt\',d2(i).name);
    s_vr = strcat('..\1_Preprocessing\C_Used regions\',type,d3(i).name);
    s_cm = strcat('..\1_Preprocessing\D_Centroids\',type,d4(i).name);
    im = imread(s_img);
    complex = load(s_complex);
    vr = load(s_vr);
    cm = load(s_cm);
    
    figure()
    imshow(im)
    hold on
    draw_complexes(complex,cm,vr,instant)
    hold off

    s_fig = strcat('..\3_Results\Filtered complexes\Alpha complexes\',type,'png\',erase(d1(i).name,'.png'),'_alpha_complex.png');
    saveas(gcf,s_fig);
end

close all