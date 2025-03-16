function PARA = genImage02(PARA)
addpath('img'); PARA.class_n = 2;
PARA.I = imread('310007.JPG');


PARA.I = double(mat2gray(PARA.I));
PARA.I(find(PARA.I>=0.4)) = 1;
PARA.I(find(PARA.I<0.4)) = 0;

PARA.ClassValue = unique(PARA.I(:));
PARA.realImg = 0;
%figure; imshow(PARA.I )


