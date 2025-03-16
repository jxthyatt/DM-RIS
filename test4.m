SEG = imread('/Users/xiating/Desktop/新的论文/图11/1/FCN.jpg');
GT = imread('/Users/xiating/Desktop/新的论文/图11/1/GT.jpg');
 
% binarize
SEG = im2bw(SEG, 0.1);
GT = im2bw(GT, 0.1);
 
dr = Dice_Ratio(SEG, GT)
hd = Hausdorff_Dist(SEG, GT)
jaccard = Jaccard_Index(SEG, GT)
apd = Avg_PerpenDist(SEG, GT)
confm_index = ConformityCoefficient(SEG, GT)
precision = Precision(SEG, GT)
recall = Recall(SEG, GT)
sen = getSensitivity(SEG, GT)
F1=(2*precision*recall)/(precision+recall)