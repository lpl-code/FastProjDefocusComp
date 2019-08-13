function boundary2_inv = boundary_find3(image_out, row_num, col_num)
boundary2 = rgb2gray(image_out);
boundary2_bw = imbinarize(boundary2);
se = strel('disk',8);
mask_imdilate = imdilate(boundary2_bw,se);
mask_imerode = imerode(mask_imdilate,se);
boundary2 = mask_imerode;
boundary2_inv = zeros(1140, 912);
for i = 1:1024
    for j = 1:1280
            if row_num(i, j)<=0 || col_num(i, j)<=0
                continue
            end
            if row_num(i, j)<=1140 && col_num(i, j)<=912
                boundary2_inv(row_num(i, j), col_num(i, j), :) = boundary2(i, j, :);
            end
    end
end
se = strel('disk',3);
mask_imdilate = imdilate(boundary2_inv,se);
mask_imerode = imerode(mask_imdilate,se);
boundary2_inv = mask_imerode;
end