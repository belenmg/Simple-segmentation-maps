%--------------------------------------------------------------------------
% Draw barcodes without normalizing
%--------------------------------------------------------------------------

type1 = 'cell images\'; 
type2 = 'Simple images\';

type = type2;

% Region complex

t = strcat('..\3_Results\Barcodes\Region complexes\',type,'txt\*.txt');
imgs = dir(t);
n = length(imgs);

for i = 1:n
    s_bar = strcat('..\3_Results\Barcodes\Region complexes\',type,'txt\',imgs(i).name);
    B = load(s_bar);
    B = sortrows(B,2);
    B0 = [];
    B1 = [];
    for j = 1:size(B,1)
        if B(j,1)==0 && B(j,3)~=inf
            B0 = [B0 B(j,3)];
        elseif B(j,1)==1
            B1 = [B1 B(j,3)];
        end
    end
    m0 = round(max(B0))+1;
    m1 = round(max(B1))+1;
    m = max(m0,m1);

    figure()
    plot([0,m],[0,0],'-r','LineWidth',2);
    hold on
    k = 1;
    for t = 1:size(B,1)
        if B(t,1)==0 && B(t,3)~=inf
            plot([0,B(t,3)],[k,k],'-r','LineWidth',2);
            hold on
            k = k+1;
        end
    end
    for t = 1:size(B,1)
        if B(t,1)==1
            plot([B(t,2),B(t,3)],[k,k],'-b','LineWidth',2);
            hold on
            k = k+1;
        end
    end
    hold off
 
    s_fig = strcat('..\3_Results\Barcodes\Region complexes\',type,'png\',erase(imgs(i).name,'.txt'),'.png');
    saveas(gcf,s_fig);
end

% Alpha complex

t = strcat('..\3_Results\Barcodes\Alpha complexes\',type,'txt\*.txt');
imgs = dir(t);
n = length(imgs);

for i = 1:n
    s_bar = strcat('..\3_Results\Barcodes\Alpha complexes\',type,'txt\',imgs(i).name);
    B = load(s_bar);
    B = sortrows(B,2);
    B0 = [];
    B1 = [];
    for j = 1:size(B,1)
        if B(j,1)==0 && B(j,3)~=inf
            B0 = [B0 B(j,3)];
        elseif B(j,1)==1
            B1 = [B1 B(j,3)];
        end
    end
    m0 = round(max(B0))+1;
    m1 = round(max(B1))+1;
    m = max(m0,m1);

    figure()
    plot([0,m],[0,0],'-r','LineWidth',2);
    hold on
    k = 1;
    for t = 1:size(B,1)
        if B(t,1)==0 && B(t,3)~=inf
            plot([0,B(t,3)],[k,k],'-r','LineWidth',2);
            hold on
            k = k+1;
        end
    end
    for t = 1:size(B,1)
        if B(t,1)==1
            plot([B(t,2),B(t,3)],[k,k],'-b','LineWidth',2);
            hold on
            k = k+1;
        end
    end
    hold off
 
    s_fig = strcat('..\3_Results\Barcodes\Alpha complexes\',type,'png\',erase(imgs(i).name,'.txt'),'.png');
    saveas(gcf,s_fig);
end

close all