B=imread('/Users/xiating/Desktop/PicDenoising/35-1Im_Original.JPG');
[m n]=size(B);
for y=1:n
     C(y)=sum(B(1:m,y))/m;
end
D=repmat(C,512,1);

E=uint8(D);
%figure,imshow(E);
%imwrite(E,'/Users/xiating/Desktop/论文/背景重建1/010200.jpg');
F=E-B;
G=E+B;
H=imdivide(F,G);
%figure,imshow(H);
A=E-B;
figure,imshow(A);
%imwrite(A,'/Users/xiating/Desktop/论文/背景均衡1/010200.jpg');