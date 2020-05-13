function [kernel_r, kernel_g, kernel_b, row_num_1, col_num_1] = cal_metrics_step1(gen_add_str, gen_add_str_1, DOT_TYPE, kernel_radius, interval, gauss_flag)
%%
[col_num, row_num, c_h, c_w] = pist_main(gen_add_str, 4, 19, 912, 19, 1140);
[col_num_1, row_num_1, c_h_1, c_w_1] = pist_main(gen_add_str_1, 4, 19, 912, 19, 1140);
%% Load Images
add_str = [gen_add_str_1,DOT_TYPE];
fileFolder=fullfile(add_str);
dirOutput=dir(fullfile(fileFolder,'*'));
fileNames={dirOutput.name}';
k = 1;
background = imread([gen_add_str_1,'background.bmp']);
for i = 1:length(fileNames)
    if fileNames{i, 1}(1) == '1'
        captured_images{k, 1} = imread([add_str, '\', fileNames{i, 1}]);
        captured_images{k, 1} = captured_images{k, 1} - background;
        k = k + 1;
    end
end

badge = captured_images{1, 1};
badge_ori = imread([gen_add_str_1,'dot1.bmp']);
badge_ori_inv = zeros(1140, 912, 3);
for i = 1:1024
    for j = 1:1280
            if row_num(i, j)<=0 || col_num(i, j)<=0
                continue
            end
            if row_num(i, j)<=1140 && col_num(i, j)<=912
                badge_ori_inv(row_num(i, j), col_num(i, j), :) = badge(i, j, :);
            end
    end
end
badge_ori_inv_rgb = uint8(badge_ori_inv);
%% R Channel
badge_ori_inv = badge_ori_inv_rgb(:,:,1);
for i = 1:1140
    for j = 1:912
        if badge_ori(i,j,1)==255
            kernel{i,j} = zeros(2*kernel_radius-1, 2*kernel_radius-1);
            for ii=(1 - kernel_radius): (kernel_radius - 1)
                if (i+ii)<1 || (i+ii)>1140
                    continue
                end
                for jj=(1 - kernel_radius): (kernel_radius - 1)
                    if (j+jj)<1 || (j+jj)>912
                        continue
                    end
                    kernel{i, j}(ii+kernel_radius, jj+kernel_radius) = badge_ori_inv(i+ii, j+jj);
                end
            end
            kernel{i, j} = kernel{i, j} ./ 255;
            if gauss_flag
                kernel{i, j} = scaleGauss(kernel{i, j}, kernel_radius);
            end
            if sum(sum(kernel{i, j}))
                kernel{i, j} = kernel{i, j} ./ sum(sum(kernel{i, j}));
            end
        else
            kernel{i,j} = zeros(2*kernel_radius-1, 2*kernel_radius-1);
        end
    end
end
for i = 1:1140
    for j = 1:912
         if norm(kernel{i, j},2)==0
            if ((ceil(i/interval))*interval+1)<=1140 && ((ceil(j/interval))*interval+1)<=912
                if ~isempty(kernel{((ceil(i/interval)-1)*interval+1), ((ceil(j/interval)-1)*interval+1)}) && ~isempty(kernel{((ceil(i/interval))*interval+1), ((ceil(j/interval))*interval+1)}) %仅对左上角kernel核右下角kernel非空的点进行插值
                    u = (i-((ceil(i/interval)-1)*interval+1))/interval;
                    v = (j-((ceil(j/interval)-1)*interval+1))/interval;
                    kernel{i, j} = (1 - u)*(1 - v)*kernel{((ceil(i/interval)-1)*interval+1), ((ceil(j/interval)-1)*interval+1)} + ...
                      (1 - u)* v     *kernel{((ceil(i/interval)-1)*interval+1),     ((ceil(j/interval))*interval+1)} + ...
                       u     *(1 - v)*kernel{((ceil(i/interval))*interval+1), ((ceil(j/interval)-1)*interval+1)} + ...
                       u     * v     *kernel{((ceil(i/interval))*interval+1),((ceil(j/interval))*interval+1)};
                    if gauss_flag
                        kernel{i, j} = scaleGauss(kernel{i, j}, kernel_radius);
                    end
                    if sum(sum(kernel{i, j}))
                        kernel{i, j} = kernel{i, j} ./ sum(sum(kernel{i, j}));
                    end
                end
            end
        end
    end
end
kernel_r = kernel;
clear kernel badge_ori_inv
%% G Channel
badge_ori_inv = badge_ori_inv_rgb(:,:,2);
for i = 1:1140
    for j = 1:912
        if badge_ori(i,j,1)==255
            kernel{i,j} = zeros(2*kernel_radius-1, 2*kernel_radius-1);
            for ii=(1 - kernel_radius): (kernel_radius - 1)
                if (i+ii)<1 || (i+ii)>1140
                    continue
                end
                for jj=(1 - kernel_radius): (kernel_radius - 1)
                    if (j+jj)<1 || (j+jj)>912
                        continue
                    end
                    kernel{i, j}(ii+kernel_radius, jj+kernel_radius) = badge_ori_inv(i+ii, j+jj);
                end
            end
            kernel{i, j} = kernel{i, j} ./ 255;
                    if gauss_flag
                        kernel{i, j} = scaleGauss(kernel{i, j}, kernel_radius);
                    end
            if sum(sum(kernel{i, j}))
                kernel{i, j} = kernel{i, j} ./ sum(sum(kernel{i, j}));
            end
        else
            kernel{i,j} = zeros(2*kernel_radius-1, 2*kernel_radius-1);
        end
    end
end
for i = 1:1140
    for j = 1:912
         if norm(kernel{i, j},2)==0
            if ((ceil(i/interval))*interval+1)<=1140 && ((ceil(j/interval))*interval+1)<=912
                if ~isempty(kernel{((ceil(i/interval)-1)*interval+1), ((ceil(j/interval)-1)*interval+1)}) && ~isempty(kernel{((ceil(i/interval))*interval+1), ((ceil(j/interval))*interval+1)}) %仅对左上角kernel核右下角kernel非空的点进行插值
                    u = (i-((ceil(i/interval)-1)*interval+1))/interval;
                    v = (j-((ceil(j/interval)-1)*interval+1))/interval;
                    kernel{i, j} = (1 - u)*(1 - v)*kernel{((ceil(i/interval)-1)*interval+1), ((ceil(j/interval)-1)*interval+1)} + ...
                      (1 - u)* v     *kernel{((ceil(i/interval)-1)*interval+1),     ((ceil(j/interval))*interval+1)} + ...
                       u     *(1 - v)*kernel{((ceil(i/interval))*interval+1), ((ceil(j/interval)-1)*interval+1)} + ...
                       u     * v     *kernel{((ceil(i/interval))*interval+1),((ceil(j/interval))*interval+1)};
                    if gauss_flag
                        kernel{i, j} = scaleGauss(kernel{i, j}, kernel_radius);
                    end
                    if sum(sum(kernel{i, j}))
                        kernel{i, j} = kernel{i, j} ./ sum(sum(kernel{i, j}));
                    end
                end
            end
        end
    end
end
kernel_g = kernel;
clear kernel badge_ori_inv
%% B Channel
badge_ori_inv = badge_ori_inv_rgb(:,:,3);
for i = 1:1140
    for j = 1:912
        if badge_ori(i,j,1)==255
            kernel{i,j} = zeros(2*kernel_radius-1, 2*kernel_radius-1);
            for ii=(1 - kernel_radius): (kernel_radius - 1)
                if (i+ii)<1 || (i+ii)>1140
                    continue
                end
                for jj=(1 - kernel_radius): (kernel_radius - 1)
                    if (j+jj)<1 || (j+jj)>912
                        continue
                    end
                    kernel{i, j}(ii+kernel_radius, jj+kernel_radius) = badge_ori_inv(i+ii, j+jj);
                end
            end
            kernel{i, j} = kernel{i, j} ./ 255;
                    if gauss_flag
                        kernel{i, j} = scaleGauss(kernel{i, j}, kernel_radius);%【改动处】
                    end
            if sum(sum(kernel{i, j}))
                kernel{i, j} = kernel{i, j} ./ sum(sum(kernel{i, j}));
            end
        else
            kernel{i,j} = zeros(2*kernel_radius-1, 2*kernel_radius-1);
        end
    end
end
for i = 1:1140
    for j = 1:912
         if norm(kernel{i, j},2)==0
            if ((ceil(i/interval))*interval+1)<=1140 && ((ceil(j/interval))*interval+1)<=912
                if ~isempty(kernel{((ceil(i/interval)-1)*interval+1), ((ceil(j/interval)-1)*interval+1)}) && ~isempty(kernel{((ceil(i/interval))*interval+1), ((ceil(j/interval))*interval+1)}) %仅对左上角kernel核右下角kernel非空的点进行插值
                    u = (i-((ceil(i/interval)-1)*interval+1))/interval;
                    v = (j-((ceil(j/interval)-1)*interval+1))/interval;
                    kernel{i, j} = (1 - u)*(1 - v)*kernel{((ceil(i/interval)-1)*interval+1), ((ceil(j/interval)-1)*interval+1)} + ...
                      (1 - u)* v     *kernel{((ceil(i/interval)-1)*interval+1),     ((ceil(j/interval))*interval+1)} + ...
                       u     *(1 - v)*kernel{((ceil(i/interval))*interval+1), ((ceil(j/interval)-1)*interval+1)} + ...
                       u     * v     *kernel{((ceil(i/interval))*interval+1),((ceil(j/interval))*interval+1)};
                    if gauss_flag
                        kernel{i, j} = scaleGauss(kernel{i, j}, kernel_radius);
                    end
                    if sum(sum(kernel{i, j}))
                        kernel{i, j} = kernel{i, j} ./ sum(sum(kernel{i, j}));
                    end
                end
            end
        end
    end
end
kernel_b = kernel;
clear kernel badge_ori_inv