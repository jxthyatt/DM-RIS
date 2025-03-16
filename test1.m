sourcePic=imread('/Users/xiating/Desktop/310007.JPG');

grayPic=mat2gray(sourcePic);

[m,n]=size(grayPic);

newGrayPic=grayPic;

PrewittNum=0;

PrewittThreshold=0.6;%设定阈值

for j=2:m-1 %进行边界提取

    for k=2:n-1

        PrewittNum=abs(grayPic(j-1,k+1)-grayPic(j+1,k+1)+grayPic(j-1,k)-grayPic(j+1,k)+grayPic(j-1,k-1)-grayPic(j+1,k-1))+abs(grayPic(j-1,k+1)+grayPic(j,k+1)+grayPic(j+1,k+1)-grayPic(j-1,k-1)-grayPic(j,k-1)-grayPic(j+1,k-1));

        if(PrewittNum > PrewittThreshold)

            newGrayPic(j,k)=255;

        else

            newGrayPic(j,k)=0;

        end

    end

end

figure,imshow(newGrayPic);

title('Prewitt算子的处理结果')