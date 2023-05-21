function norm_tv = TV_Norm(matrix)
%Total variation norm for a given matrix
[gradI_x,gradI_y] = imgradientxy(matrix);

norm_tv = sum(sqrt(gradI_x.^2 + gradI_y.^2))
end

