function PARA = initPARA(PARA)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initial fuzzy partition
PARA.Flag=1;
data_n = PARA.ysize*PARA.xsize; PARA.data_n = data_n;
if (PARA.Initial==1)
    for i = 1 : PARA.zsize
        tmp = PARA.Inoise(:,:,i);
        PARA.data(:,i) = tmp(:);
    end
    U = zeros(PARA.class_n, data_n);
    [IDX,C] = kmeans(PARA.data,PARA.class_n, 'Start','cluster', ...
        'Maxiter',1000, ...
        'EmptyAction','singleton', ...
        'Display','off'); % Ci(nx1) - cluster indeices; C(k,d) - cluster centroid (i.e. mean)
    for i = 1 : PARA.class_n
        U(i,find(IDX==i)) = 1;
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if (PARA.Initial==2)
    for i = 1 : PARA.zsize
        tmp = PARA.Inoise(:,:,i);
        PARA.data(:,i) = tmp(:);
    end
    PARA=GMM(PARA);
    [id, IDX] =  max(PARA.PEM,[], 2);
    for i = 1 : PARA.class_n
        U(i,find(IDX==i)) = 1;
    end
end
PARA.U0 = U; PARA.U = U';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
