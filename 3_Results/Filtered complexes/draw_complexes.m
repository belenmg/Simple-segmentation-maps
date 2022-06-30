
function  draw_complexes(complex,cm,vr,n)

%-------------------------------------------------------------------------
% INPUT: [complex] -> output .txt of the scripts Main_**.py of the proyect 
%                     FILTERED_COMPLEXES_PYTHON saved in the folder 
%                     2_Filtered complexes\**
%                     .
%        [cm] -> matrix with the centroids of the regions saved in the folder
%                1_Preprocessing\D_centroids\**
%
%        [vr] -> list of the labels of the used regions to construct the 
%                complexmatrix saved in the folder 
%                1_Preprocessing\C_Used regions\**
%
%        [n] -> number > 0 
%
% OUTPUT: draw of the simplices of the [complex] such that the value filter 
%         on this simplex is is less than or equal to [number].
%-------------------------------------------------------------------------

    for i = 1:size(complex,1)
        if complex(i,1)>-1 && complex(i,2)>-1 && complex(i,3)>-1 && complex(i,4)==-1 && complex(i,5)<n %triángulo
            e1 = find(cm(:,3)==complex(i,1));
            e2 = find(cm(:,3)==complex(i,2));
            e3 = find(cm(:,3)==complex(i,3));
            fill([cm(e1,1),cm(e2,1),cm(e3,1)],[cm(e1,2),cm(e2,2),cm(e3,2)],'-r','FaceAlpha',0.5);
            hold on
        end
        if complex(i,1)>-1 && complex(i,2)>-1 && complex(i,3)==-1 && complex(i,4)==-1 && complex(i,5)<n %arista
            e1 = find(cm(:,3)==complex(i,1));
            e2 = find(cm(:,3)==complex(i,2));
            plot([cm(e1,1),cm(e2,1)],[cm(e1,2),cm(e2,2)],'-black','linewidth',1);
            hold on
        end
    end

    for i = 1:size(cm,1)
        if ismember(cm(i,3),vr)
            plot(cm(i,1),cm(i,2),'.black','markersize',10)
            hold on
        end
    end
end