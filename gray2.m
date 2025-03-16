A = imread('/Users/xiating/Desktop/PicDenoising/35-1Im_Original.JPG');
B = A;
[m n]=size(B);
for y=1:n
S(y)=180*m/sum(B(1:m,y));
end
for y=1:n
for x=1:m
H(x,y)=S(y)*B(x,y);
end
end
figure,imshow(H);
imwrite(H,'/Users/xiating/Desktop/PicDenoising/35-1Im_Original_step1.JPG');