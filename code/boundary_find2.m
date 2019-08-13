function disp_boundary = boundary_find2(gen_add_str)
add_str = [gen_add_str, 'boundary.bmp'];
boundary = imread(add_str);
boundary = rgb2gray(boundary);
boundary_bw = zeros(size(boundary));
boundary_bw(boundary>15)=1;

se = strel('disk',8);
mask_imdilate = imdilate(boundary_bw,se);
mask_imerode = imerode(mask_imdilate,se);

disp_boundary = mask_imerode;
disp_boundary(:,:,1) = disp_boundary;
disp_boundary(:,:,2) = disp_boundary(:,:,1);
disp_boundary(:,:,3) = disp_boundary(:,:,2);