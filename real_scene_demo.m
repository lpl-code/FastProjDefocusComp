clear
clc
addpath(genpath('data/'));
addpath('code/');
%% Chose an original image
image_no = 1; % image_no = 1~7
%%
gen_add_str = 'data\';
[col_num, row_num, c_h, c_w] = pist_main(gen_add_str, 4, 19, 912, 19, 1140);
%% 
captured_images = image_read_background(gen_add_str);
badge_ori_inv_rgb = cam2pro(captured_images, row_num, col_num);
badge_ori = imread([gen_add_str,'dot1.bmp']);
%% Kernel estimation for Red Channel
badge_ori_inv = badge_ori_inv_rgb(:,:,1);
kernel_r = kernelEstimation(badge_ori_inv, badge_ori);
%% Kernel estimation for Green Channel
badge_ori_inv = badge_ori_inv_rgb(:,:,2);
kernel_g = kernelEstimation(badge_ori_inv, badge_ori);
%% Kernel estimation for Blue Channel
badge_ori_inv = badge_ori_inv_rgb(:,:,3);
kernel_b = kernelEstimation(badge_ori_inv, badge_ori);
%% Compute the compensation image for Red Channel (the proposed method)
disp_boundary = boundary_find2(gen_add_str);
boundary2_inv = boundary_find3(disp_boundary, row_num, col_num);
badge_ori = imread([gen_add_str,'INPUT\',num2str(image_no),'.bmp']);
badge_ori = badge_ori(:,:,1);
comp_r = compenstionImage(badge_ori, kernel_r, boundary2_inv);
%% Compute the compensation image for Green Channel (the proposed method)
badge_ori = imread([gen_add_str,'INPUT\',num2str(image_no),'.bmp']);
badge_ori = badge_ori(:,:,2);
comp_g = compenstionImage(badge_ori, kernel_g, boundary2_inv);
%% Compute the compensation image for Blue Channel (the proposed method)
badge_ori = imread([gen_add_str,'INPUT\',num2str(image_no),'.bmp']);
badge_ori = badge_ori(:,:,3);
comp_b = compenstionImage(badge_ori, kernel_b, boundary2_inv);
%% Compute the final compensation image
comp(:,:,1) = comp_r;
comp(:,:,2) = comp_g;
comp(:,:,3) = comp_b;
%% Resize
comp_out = imresize(comp, [800, 1280], 'lanczos3');
badge_ori = imread([gen_add_str,'INPUT\',num2str(image_no),'.bmp']);
badge_ori = uint8(boundary2_inv .* double(badge_ori));
original_out = imresize(badge_ori, [800, 1280], 'lanczos3');
%% Display
figure; imshow(original_out); title('Original image');
figure; imshow(comp_out); title('Compensation image');