function image_out = blurEstimation(badge_ori, kernel_r, row_num, col_num, disp_boundary)
kernel_radius = 6;
badge_ori_zoom = zeros(size(badge_ori,1)+2*(kernel_radius-1), size(badge_ori,2)+2*(kernel_radius-1));
badge_ori_zoom(kernel_radius:(kernel_radius+1139), kernel_radius:(kernel_radius+911)) = badge_ori;
badge_art = zeros(size(badge_ori,1)+2*(kernel_radius-1), size(badge_ori,2)+2*(kernel_radius-1));
for i=1:1140
    for j=1:912
        badge_art(i+(kernel_radius-1), j+(kernel_radius-1)) = sum(sum(kernel_r{i,j}.*badge_ori_zoom(i:(i+2*(kernel_radius-1)), j:(j+2*(kernel_radius-1)))));
    end
end
badge_art = badge_art(kernel_radius:(kernel_radius+1139), kernel_radius:(kernel_radius+911));

new_badge_art = zeros(1024, 1280);
for i = 1:1024
    for j = 1:1280
        if row_num(i, j)<=0 || col_num(i, j)<=0
            continue
        end
        if row_num(i, j)<=1140 && col_num(i, j)<=912
            new_badge_art(i, j, :) = badge_art(row_num(i, j), col_num(i, j));
        end
    end
end
image_out = disp_boundary(:,:,1).*new_badge_art;
end