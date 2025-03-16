function PARA = genImage03(PARA)
addpath('img');
addpath('img');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tmp = sprintf('PARA.I = imread(''%d.JPG'');',PARA.ID); eval(tmp);
PARA.I = mat2gray(PARA.I);
PARA.ClassValue = [0:1/(PARA.class_n-1):1];
