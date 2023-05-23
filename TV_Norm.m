function norm_tv = TV_Norm(matrix)
% %Total variation norm for a given matrix
% [gradI_x,gradI_y] = imgradientxy(matrix);
% 
% norm_tv = sum(sum(sqrt(gradI_x.^2 + gradI_y.^2)));



v1=(matrix(2:end,:)-matrix(1:end-1,:));
v2=(matrix(:,2:end)-matrix(:,1:end-1));

v1=reshape(v1,1,[]);
v2=reshape(v2,1,[]);

len = numel(v1);


v2 = v2(1:len);
% size(v1)
% size(v2)


norm_tv = (sum((v1.^2 + v2.^2)))/2;


end

