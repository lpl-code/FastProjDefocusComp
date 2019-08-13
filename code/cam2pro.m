function badge_ori_inv_rgb = cam2pro(captured_images, row_num, col_num)
badge = captured_images{1, 1};
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
end