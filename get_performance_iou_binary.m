function performance =get_performance_iou_binary(ImgResult, ImgGT)

% background color & foreground
bg_color = 0 ;
fg_color = 255 ;

% check the size
[rh rw rd] = size(ImgResult);
[gh gw gd] = size(ImgGT);

rh~=gh || rw~=gw || rd~=gd
    return;
end

% performance by intersection-over-union
intersection=0;
unionsection=0;

for i=1:rh
    for j=1:rw
        if ImgResult(i,j)==fg_color && ImgGT(i,j)==fg_color
            intersection=intersection+1;
        end
        if ImgResult(i,j)==fg_color || ImgGT(i,j)==fg_color
            unionsection=unionsection+1;
        end
    end
end

if unionsection==0
    performance=100;
else
    performance=100*intersection/unionsection;
end

end