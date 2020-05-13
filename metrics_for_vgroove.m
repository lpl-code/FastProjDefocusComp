%% Metrics calculation for the experiment on V-GROOVE
clear
clc
addpath(genpath('data/'));
addpath('code/');
%%
gen_add_str = '.\vgroove1-lite\';
gen_add_str_1 = '.\vgroove1-lite\';
DOT_TYPE = 'DOT2\'; kernel_radius = 6; interval = 12; gauss_flag = 1;
[kernel_r, kernel_g, kernel_b, row_num_1, col_num_1] = cal_metrics_step1(gen_add_str, gen_add_str_1, DOT_TYPE, kernel_radius, interval, gauss_flag);
%%
proj_ori = imread('.\vgroove1-lite\COMP\38-cut\ori_cut.bmp');
comp = imread('.\vgroove1-lite\COMP\38-cut\previous_method_cut.bmp');
[proj_ori_blur, comp_blur] = cal_metrics_step3(kernel_radius, kernel_r, kernel_g, kernel_b, proj_ori, comp);
%% 
top_left = [112, 74]; bottom_right = [1105, 747];
proj_ori_cut = proj_ori(top_left(1):bottom_right(1), top_left(2):bottom_right(2), :);
proj_ori_blur_cut = proj_ori_blur(top_left(1):bottom_right(1), top_left(2):bottom_right(2), :);
comp_blur_cut = comp_blur(top_left(1):bottom_right(1), top_left(2):bottom_right(2), :);
%% SSIM [Previous]
ref = double(proj_ori_cut);
A_before = double(proj_ori_blur_cut);
A_after = double(comp_blur_cut);
[ssimval_1, ssimmap_1] = ssim(A_before,ref);
[ssimval_2, ssimmap_2] = ssim(A_after,ref);
%% PSNR [Previous]
ref = double(proj_ori_cut);
A_before = double(proj_ori_blur_cut);
A_after = double(comp_blur_cut);
[psnrval_1] = psnr(A_before,ref, min(max(max(max(A_before))), max(max(max(ref)))) );
[psnrval_2] = psnr(A_after,ref, min(max(max(max(A_before))), max(max(max(ref)))));
%% RMSE [Previous]
ref = double(proj_ori_cut);
A_before = double(proj_ori_blur_cut);
A_after = double(comp_blur_cut);
rmseval_1 = sqrt(immse(A_before,ref));
rmseval_2 = sqrt(immse(A_after,ref));
%%
proj_ori = imread('.\vgroove1-lite\COMP\38-cut\ori_cut.bmp');
comp = imread('.\vgroove1-lite\COMP\38-cut\proposed_cut.bmp');
[proj_ori_blur, comp_blur] = cal_metrics_step3(kernel_radius, kernel_r, kernel_g, kernel_b, proj_ori, comp);
%%
top_left = [112, 74]; bottom_right = [1105, 747];
proj_ori_cut = proj_ori(top_left(1):bottom_right(1), top_left(2):bottom_right(2), :);
proj_ori_blur_cut = proj_ori_blur(top_left(1):bottom_right(1), top_left(2):bottom_right(2), :);
comp_blur_cut = comp_blur(top_left(1):bottom_right(1), top_left(2):bottom_right(2), :);
%% SSIM [Proposed]
ref = double(proj_ori_cut);
A_before = double(proj_ori_blur_cut);
A_after = double(comp_blur_cut);
[ssimval_1, ssimmap_1] = ssim(A_before,ref);
[ssimval_3, ssimmap_3] = ssim(A_after,ref);
%% PSNR [Proposed]
ref = double(proj_ori_cut);
A_before = double(proj_ori_blur_cut);
A_after = double(comp_blur_cut);
[psnrval_1] = psnr(A_before,ref, min(max(max(max(A_before))), max(max(max(ref)))) );
[psnrval_3] = psnr(A_after,ref, min(max(max(max(A_before))), max(max(max(ref)))));
%% RMSE [Proposed]
ref = double(proj_ori_cut);
A_before = double(proj_ori_blur_cut);
A_after = double(comp_blur_cut);
rmseval_1 = sqrt(immse(A_before,ref));
rmseval_3 = sqrt(immse(A_after,ref));
%% display
fprintf('*********************************************************************************************************\n');
fprintf('Scene               Metrics               Normal projection               Ref.[18]               Proposed\n');
fprintf('---------------------------------------------------------------------------------------------------------\n');
fprintf('                    SSIM                  ');
fprintf('%0.4f                          ',ssimval_1);
fprintf('%0.4f                 ',ssimval_2);
fprintf('%0.4f\n',ssimval_3);

fprintf('V-groove(Fig.11)    PSNR                  ');
fprintf('%0.4f                         ',psnrval_1);
fprintf('%0.4f                ',psnrval_2);
fprintf('%0.4f\n',psnrval_3);

fprintf('                    RMSE                  ');
fprintf('%0.4f                          ',rmseval_1);
fprintf('%0.4f                 ',rmseval_2);
fprintf('%0.4f\n',rmseval_3);
fprintf('*********************************************************************************************************\n');