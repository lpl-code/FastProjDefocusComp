%%
function [col_num, row_num, c_h, c_w] = pist_main(gen_add_str, phase_shift_steps, p1, proj_w, p2, proj_h)
%%
add_str = [gen_add_str, 'RE1\'];

captured_images = images_read(add_str);

[solve_phase44_main ,cycle] = phase_solve1(captured_images, phase_shift_steps);

limit1 = proj_w;
col_num = matching_solve(solve_phase44_main, cycle, p1, limit1);
%%
clear cycle
clear solve_phase44_main
clear captured_images
add_str = [gen_add_str, 'RE6\'];

captured_images = images_read(add_str);

[solve_phase44_main ,cycle] = phase_solve2(captured_images, phase_shift_steps);

limit2 = proj_h;
row_num = matching_solve(solve_phase44_main, cycle, p2, limit2);
%%
c_h = size(solve_phase44_main, 1);
c_w = size(solve_phase44_main, 2);