function comp_r = compenstionImage(badge_ori, kernel_r, boundary2_inv)
kernel_radius = 6;
target = boundary2_inv.*double(badge_ori);
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
guess = boundary2_inv.*double(guess);

ratio = guess ./ target;
ratio(find(target==0))=0;

comp = target ./ ratio;
comp(find(ratio==0))=0;
comp = uint8(comp);
comp_r = comp;
end