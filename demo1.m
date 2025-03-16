close all;warning off all; clear all; 
addpath('img'); addpath('lib');
addpath('GMM'); addpath('FRGMM');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
PARA.epochs = 50; % Iteration
PARA.Initial = 2; %1: Kmean; 2: GMM
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Original image
PARA = genImage01(PARA); % 3 class
[PARA.ysize,PARA.xsize,PARA.zsize] = size(PARA.I); figure; imshow(PARA.I); title('Original Image');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%add noise
PARA.Inoise = PARA.I; figure; imshow(PARA.Inoise); title('Noisy Image');
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Fast and Robust Spatially Constrained Gaussian Mixture Model (FRGMM)
PARA.win = 3; % 5x5 window
PARA.beta = 4; % beta
PARA = FRGMM(PARA);
[id, IDX] =  max(PARA.U');  IDX = (IDX-1)/(PARA.class_n-1); 
PARA.Segment = reshape(IDX,PARA.ysize,PARA.xsize);
figure; imshow(PARA.Segment); title('FRGMM');
