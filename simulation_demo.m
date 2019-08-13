%% Comparison of the proposed edge intensification method and previous widely-used optimization method 
clear
clc
addpath(genpath('data/'));
addpath('code/');
%% Select an original image
image_no = 1; % image_no = 1~15
path = ['data\t', num2str(image_no), '.png'];
%% Blur kernel setup
sigma = 1;
kernel_radius = (2*ceil(2*sigma)+1+1)/2;
r = kernel_radius;
gau = fspecial('gaussian', [2*kernel_radius-1, 2*kernel_radius-1], sigma);
%% Previous optimization method
[result_opt_display, time_consume_sd] = optimization_method(gau, kernel_radius, path);
%% The proposed method
badge_ori = imread(path);
badge_ori = badge_ori(:,:,1);
window_h_total = 150; window_w_total = 150;
start_i_total = 485; start_j_total = 335;
tic;
[comp, target] = proposed_method(badge_ori, gau, start_i_total, start_j_total, window_h_total, window_w_total, kernel_radius);
our_time = toc;
comp_r = uint8(comp);
target_r = uint8(target);
%% Compute the blurred original image
original_zoom = zeros(window_h_total+2*(kernel_radius-1), window_w_total+2*(kernel_radius-1));
original_zoom(kernel_radius:(kernel_radius+window_h_total-1), kernel_radius:(kernel_radius+window_w_total-1)) = target;
original_filted = zeros(window_h_total, window_w_total);
k = 1;
for i=1:window_h_total
    for j=1:window_w_total
        %if boundary2_inv(i+start_i_total-1, j+start_j_total-1)
            %badge_art(i+(kernel_radius-1), j+(kernel_radius-1)) = sum(sum(kernel{i,j}.*badge_ori_zoom(i:(i+2*(kernel_radius-1)), j:(j+2*(kernel_radius-1))))) / sum(sum(kernel{i, j}));
            original_filted(i, j) = sum(sum(gau.*original_zoom(i:(i+2*(kernel_radius-1)), j:(j+2*(kernel_radius-1)))));
            %item = x_syms(i:(i+2*(kernel_radius-1)), j:(j+2*(kernel_radius-1)));
            %y_filted_syms(i+(kernel_radius-1), j+(kernel_radius-1)) = (kernel_r{i,j}(:))' * item(:);
            k = k + 1;
        %end
    end
end
%original_filted = imfilter(target, gau, 'replicate');
%% Compute the blurred compensation image (the proposed method)
comp_zoom = zeros(window_h_total+2*(kernel_radius-1), window_w_total+2*(kernel_radius-1));
comp_zoom(kernel_radius:(kernel_radius+window_h_total-1), kernel_radius:(kernel_radius+window_w_total-1)) = comp;
comp_filted = zeros(window_h_total, window_w_total);
k = 1;
for i=1:window_h_total
    for j=1:window_w_total
        %if boundary2_inv(i+start_i-1, j+start_j-1)
            %badge_art(i+(kernel_radius-1), j+(kernel_radius-1)) = sum(sum(kernel{i,j}.*badge_ori_zoom(i:(i+2*(kernel_radius-1)), j:(j+2*(kernel_radius-1))))) / sum(sum(kernel{i, j}));
            comp_filted(i, j) = sum(sum(gau.*comp_zoom(i:(i+2*(kernel_radius-1)), j:(j+2*(kernel_radius-1)))));
            %item = x_syms(i:(i+2*(kernel_radius-1)), j:(j+2*(kernel_radius-1)));
            %y_filted_syms(i+(kernel_radius-1), j+(kernel_radius-1)) = (kernel_r{i,j}(:))' * item(:);
            k = k + 1;
        %end
    end
end
%comp_filted = imfilter(comp, gau, 'replicate');
%% Compute the blurred compensation image (previous optimization method)
result_zoom = zeros(window_h_total+2*(kernel_radius-1), window_w_total+2*(kernel_radius-1));
result_zoom(kernel_radius:(kernel_radius+window_h_total-1), kernel_radius:(kernel_radius+window_w_total-1)) = result_opt_display;
result_filted = zeros(window_h_total, window_w_total);
k = 1;
for i=1:window_h_total
    for j=1:window_w_total
        %if boundary2_inv(i+start_i-1, j+start_j-1)
            %badge_art(i+(kernel_radius-1), j+(kernel_radius-1)) = sum(sum(kernel{i,j}.*badge_ori_zoom(i:(i+2*(kernel_radius-1)), j:(j+2*(kernel_radius-1))))) / sum(sum(kernel{i, j}));
            result_filted(i, j) = sum(sum(gau.*result_zoom(i:(i+2*(kernel_radius-1)), j:(j+2*(kernel_radius-1)))));
            %item = x_syms(i:(i+2*(kernel_radius-1)), j:(j+2*(kernel_radius-1)));
            %y_filted_syms(i+(kernel_radius-1), j+(kernel_radius-1)) = (kernel_r{i,j}(:))' * item(:);
            k = k + 1;
        %end
    end
end
%% Plot
figure;
subplot(3,2,1); imshow(uint8(target)); xlabel('Original image');
subplot(3,2,2); imshow(uint8(original_filted)); xlabel('Blurred original image');
subplot(3,2,3); imshow(uint8(result_opt_display)); xlabel({'Compensation image'; '(optimization method)'});
subplot(3,2,4); imshow(uint8(result_filted)); xlabel({'Blurred compensation image'; '(optimization method)'});
subplot(3,2,5); imshow(uint8(comp)); xlabel({'Compensation image'; '(proposed)'});
subplot(3,2,6); imshow(uint8(comp_filted)); xlabel({'Blurred Compensation image'; '(proposed)'});
%% SSIM evaluation
ref = double(target);
A_before = double(original_filted);
A_after = comp_filted;
A_sd = result_filted;

[ssimval_1, ssimmap_1] = ssim(A_before,ref);
[ssimval_2, ssimmap_2] = ssim(A_after,ref);
[ssimval_3, ssimmap_3] = ssim(A_sd,ref);

clc
fprintf('--------------------------------------------\n');
fprintf('The SSIM of original defocus is %0.4f.\n',ssimval_1);
fprintf('The SSIM of proposed is %0.4f.\n',ssimval_2);
fprintf('The SSIM of previous_optimization is %0.4f.\n',ssimval_3);
fprintf('--------------------------------------------\n');

%% Efficiency evaluation
fprintf('----------------------------------------------------------\n');
fprintf('The Time_Consumption of proposed is %0.4f.\n',our_time);
fprintf('The Time_Consumption of previous_optimization is %0.4f.\n', time_consume_sd);
fprintf('----------------------------------------------------------\n');