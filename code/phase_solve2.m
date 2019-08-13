function [solve_phase44_main ,cycle] = phase_solve2(captured_images, phase_shift_steps)
for i = 1:phase_shift_steps
    I0_rgb = captured_images{i, 1}; %No. 1~4
    pspPattern11{i,1} = double(I0_rgb);
end
for i = 1:phase_shift_steps
    I0_rgb = captured_images{i + phase_shift_steps, 1}; %No. 5~8
    pspPattern22{i,1} = double(I0_rgb);
end
solve_phase11_main = solveMainPhase_Nsteps(pspPattern11);
solve_phase22_main = solveMainPhase_Nsteps(pspPattern22);
cycle = round( (4 .* solve_phase11_main - solve_phase22_main) ./ (2 * pi) );
phase_vase_f4_unwrap = solve_phase22_main + 2 * pi .* cycle;

for i = 1:phase_shift_steps
    I0_rgb = captured_images{i + 2*phase_shift_steps, 1}; %No. 9~12
    pspPattern33{i,1} = double(I0_rgb);
end
solve_phase33_main = solveMainPhase_Nsteps(pspPattern33);
cycle = round( (3 .* phase_vase_f4_unwrap - solve_phase33_main) ./ (2 * pi) );
phase_vase_f16_unwrap = solve_phase33_main + 2 * pi .* cycle;

for i = 1:phase_shift_steps
    I0_rgb = captured_images{i + 3*phase_shift_steps, 1}; %No. 13~16
    pspPattern44{i,1} = double(I0_rgb);
end
solve_phase44_main = solveMainPhase_Nsteps(pspPattern44);
cycle = round( (5 .* phase_vase_f16_unwrap - solve_phase44_main) ./ (2 * pi) );