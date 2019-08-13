function [comp, target] = proposed_method(badge_ori, gau, start_i_total, start_j_total, window_h_total, window_w_total, kernel_radius)
badge_ori = badge_ori(start_i_total:(start_i_total+window_h_total-1), start_j_total:(start_j_total+window_w_total-1));
target = badge_ori;
badge_ori_zoom = zeros(size(badge_ori,1)+2*(kernel_radius-1), size(badge_ori,2)+2*(kernel_radius-1));
badge_ori_zoom(kernel_radius:(kernel_radius+size(badge_ori, 1)-1), kernel_radius:(kernel_radius+size(badge_ori, 2)-1)) = badge_ori;
badge_art = zeros(size(badge_ori,1)+2*(kernel_radius-1), size(badge_ori,2)+2*(kernel_radius-1));
for i=1:150
    for j=1:150
        badge_art(i+(kernel_radius-1), j+(kernel_radius-1)) = sum(sum(gau.*badge_ori_zoom(i:(i+2*(kernel_radius-1)), j:(j+2*(kernel_radius-1)))));
    end
end
badge_art = badge_art(kernel_radius:(kernel_radius+size(badge_ori,1)-1), kernel_radius:(kernel_radius+size(badge_ori,2)-1));
guess = badge_art;
guess = double(guess);

ratio = guess ./ double(target);
ratio(find(target==0))=0;

comp = double(target) ./ ratio;
comp(find(ratio==0))=0;
target = badge_ori;
end