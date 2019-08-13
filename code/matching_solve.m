function col_num = matching_solve(solve_phase44_main, cycle, p1, limit)
col_num_p1  = zeros(size(solve_phase44_main));
for i = 1:size(solve_phase44_main, 1)
    for j = 1:size(solve_phase44_main, 2)
        if solve_phase44_main(i, j) == 0
            continue
        else
            col_num_p1(i, j) = ceil((solve_phase44_main(i, j) * p1 - pi)/(2*pi));
            if ~col_num_p1(i, j)
                col_num_p1(i, j) = 1;
            end
        end
    end
end

col_num_absolute = col_num_p1 + p1 * cycle;
col_num_absolute(find(col_num_absolute>limit)) = 0;
col_num = col_num_absolute;