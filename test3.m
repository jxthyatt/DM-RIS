output=imread('/Users/xiating/Desktop/�⻬����/FRGMM.jpg');
outputs=reshape(output,(1,[]))
test_targets=imread('/Users/xiating/Desktop/�⻬����/GT.jpg');
AUC(test_targets,output);
plotroc(test_targets,output);