function [proj_ori_blur, comp_blur] = cal_metrics_step3(kernel_radius, kernel_r, kernel_g, kernel_b, proj_ori, comp)
%% R
badge_ori = proj_ori;
badge_ori = badge_ori(:,:,1);
badge_ori_zoom = zeros(size(badge_ori,1)+2*(kernel_radius-1), size(badge_ori,2)+2*(kernel_radius-1));
badge_ori_zoom(kernel_radius:(kernel_radius+1139), kernel_radius:(kernel_radius+911)) = badge_ori;
badge_art = zeros(size(badge_ori,1)+2*(kernel_radius-1), size(badge_ori,2)+2*(kernel_radius-1));
for i=1:1140
    for j=1:912
        badge_art(i+(kernel_radius-1), j+(kernel_radius-1)) = sum(sum(kernel_r{i,j}.*badge_ori_zoom(i:(i+2*(kernel_radius-1)), j:(j+2*(kernel_radius-1)))));
    end
end
badge_art = badge_art(kernel_radius:(kernel_radius+1139), kernel_radius:(kernel_radius+911));
guess = badge_art;
proj_ori_blur_r = guess;
clear badge_art guess
%% G
badge_ori = proj_ori;
badge_ori = badge_ori(:,:,2);
badge_ori_zoom = zeros(size(badge_ori,1)+2*(kernel_radius-1), size(badge_ori,2)+2*(kernel_radius-1));
badge_ori_zoom(kernel_radius:(kernel_radius+1139), kernel_radius:(kernel_radius+911)) = badge_ori;
badge_art = zeros(size(badge_ori,1)+2*(kernel_radius-1), size(badge_ori,2)+2*(kernel_radius-1));
for i=1:1140
    for j=1:912
        badge_art(i+(kernel_radius-1), j+(kernel_radius-1)) = sum(sum(kernel_r{i,j}.*badge_ori_zoom(i:(i+2*(kernel_radius-1)), j:(j+2*(kernel_radius-1)))));
    end
end
badge_art = badge_art(kernel_radius:(kernel_radius+1139), kernel_radius:(kernel_radius+911));
guess = badge_art;
proj_ori_blur_g = guess;
clear badge_art guess
%% B
badge_ori = proj_ori;
badge_ori = badge_ori(:,:,3);
badge_ori_zoom = zeros(size(badge_ori,1)+2*(kernel_radius-1), size(badge_ori,2)+2*(kernel_radius-1));
badge_ori_zoom(kernel_radius:(kernel_radius+1139), kernel_radius:(kernel_radius+911)) = badge_ori;
badge_art = zeros(size(badge_ori,1)+2*(kernel_radius-1), size(badge_ori,2)+2*(kernel_radius-1));
for i=1:1140
    for j=1:912
        badge_art(i+(kernel_radius-1), j+(kernel_radius-1)) = sum(sum(kernel_r{i,j}.*badge_ori_zoom(i:(i+2*(kernel_radius-1)), j:(j+2*(kernel_radius-1)))));
    end
end
badge_art = badge_art(kernel_radius:(kernel_radius+1139), kernel_radius:(kernel_radius+911));
guess = badge_art;
proj_ori_blur_b = guess;
clear badge_art guess
%%
proj_ori_blur(:,:,1) = uint8(proj_ori_blur_r);
proj_ori_blur(:,:,2) = uint8(proj_ori_blur_g);
proj_ori_blur(:,:,3) = uint8(proj_ori_blur_b);
clear badge_ori
%% R
badge_ori = comp;
badge_ori = badge_ori(:,:,1);
badge_ori_zoom = zeros(size(badge_ori,1)+2*(kernel_radius-1), size(badge_ori,2)+2*(kernel_radius-1));
badge_ori_zoom(kernel_radius:(kernel_radius+1139), kernel_radius:(kernel_radius+911)) = badge_ori;
badge_art = zeros(size(badge_ori,1)+2*(kernel_radius-1), size(badge_ori,2)+2*(kernel_radius-1));
for i=1:1140
    for j=1:912
        badge_art(i+(kernel_radius-1), j+(kernel_radius-1)) = sum(sum(kernel_r{i,j}.*badge_ori_zoom(i:(i+2*(kernel_radius-1)), j:(j+2*(kernel_radius-1)))));
    end
end
badge_art = badge_art(kernel_radius:(kernel_radius+1139), kernel_radius:(kernel_radius+911));
guess = badge_art;
comp_blur_r = guess;
clear badge_art guess
%% G
badge_ori = comp;
badge_ori = badge_ori(:,:,2);
badge_ori_zoom = zeros(size(badge_ori,1)+2*(kernel_radius-1), size(badge_ori,2)+2*(kernel_radius-1));
badge_ori_zoom(kernel_radius:(kernel_radius+1139), kernel_radius:(kernel_radius+911)) = badge_ori;
badge_art = zeros(size(badge_ori,1)+2*(kernel_radius-1), size(badge_ori,2)+2*(kernel_radius-1));
for i=1:1140
    for j=1:912
        badge_art(i+(kernel_radius-1), j+(kernel_radius-1)) = sum(sum(kernel_r{i,j}.*badge_ori_zoom(i:(i+2*(kernel_radius-1)), j:(j+2*(kernel_radius-1)))));
    end
end
badge_art = badge_art(kernel_radius:(kernel_radius+1139), kernel_radius:(kernel_radius+911));
guess = badge_art;
comp_blur_g = guess;
clear badge_art guess
%% B
badge_ori = comp;
badge_ori = badge_ori(:,:,3);
badge_ori_zoom = zeros(size(badge_ori,1)+2*(kernel_radius-1), size(badge_ori,2)+2*(kernel_radius-1));
badge_ori_zoom(kernel_radius:(kernel_radius+1139), kernel_radius:(kernel_radius+911)) = badge_ori;
badge_art = zeros(size(badge_ori,1)+2*(kernel_radius-1), size(badge_ori,2)+2*(kernel_radius-1));
for i=1:1140
    for j=1:912
        badge_art(i+(kernel_radius-1), j+(kernel_radius-1)) = sum(sum(kernel_r{i,j}.*badge_ori_zoom(i:(i+2*(kernel_radius-1)), j:(j+2*(kernel_radius-1)))));
    end
end
badge_art = badge_art(kernel_radius:(kernel_radius+1139), kernel_radius:(kernel_radius+911));
guess = badge_art;
comp_blur_b = guess;
clear badge_art guess
%%
comp_blur(:,:,1) = uint8(comp_blur_r);
comp_blur(:,:,2) = uint8(comp_blur_g);
comp_blur(:,:,3) = uint8(comp_blur_b);