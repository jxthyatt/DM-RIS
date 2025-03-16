tic
close all;warning off all; clear all; addpath('GMM'); addpath('FRGMM');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
PARA.epochs = 50; % Iteration
PARA.Initial = 2; %1: Kmean; 2: GMM
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Original image
PARA = genImage02(PARA); % 3 class
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[PARA.ysize,PARA.xsize,PARA.zsize] = size(PARA.I); figure; imshow(PARA.I); title('Original Image');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%add noise
PARA.Inoise = imnoise(PARA.I,'gaussian',0,0.1); figure; imshow(PARA.I); title('Noisy Image');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Initial PARA
PARA = initPARA(PARA); %Intial data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Stadard Gaussian Mixture
PARA = GMM(PARA);
[id, IDX] =  max(PARA.U');  IDX = (IDX-1)/(PARA.class_n-1); 
PARA.Segment = reshape(IDX,PARA.ysize,PARA.xsize);
figure; imshow(PARA.Segment); title('GMM');
%imwrite(~PARA.Segment,'/Users/xiating/Desktop/Î´ÃüÃûÎÄ¼þ¼Ð 10/010001.jpg');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Fast and Robust Spatially Constrained Gaussian Mixture Model (FRGMM)
PARA.win = 5; % 5x5 window
PARA.beta = 4; % beta
PARA = FRGMM(PARA);
[id, IDX] =  max(PARA.U');  IDX = (IDX-1)/(PARA.class_n-1); 
PARA.Segment = reshape(IDX,PARA.ysize,PARA.xsize);
figure; imshow(PARA.Segment); title('FRGMM');
%imwrite(PARA.Segment,'/Users/xiating/Desktop/PicDenoising/35-1Im_Original_result.jpg');
toc