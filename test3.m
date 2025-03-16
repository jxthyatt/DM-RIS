output=imread('/Users/xiating/Desktop/光滑明暗/FRGMM.jpg');
outputs=reshape(output,(1,[]))
test_targets=imread('/Users/xiating/Desktop/光滑明暗/GT.jpg');
AUC(test_targets,output);
plotroc(test_targets,output);