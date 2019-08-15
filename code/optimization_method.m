function [result_opt_display, time_consume_sd] = optimization_method(gau, kernel_radius, path)
badge_ori = imread(path);
badge_ori = badge_ori(:,:,1);
badge_ori_zoom = zeros(size(badge_ori,1)+2*(kernel_radius-1), size(badge_ori,2)+2*(kernel_radius-1));
badge_ori_zoom(kernel_radius:(kernel_radius+1139), kernel_radius:(kernel_radius+911)) = badge_ori;
clearvars -except badge_ori_zoom badge_ori kernel_radius boundary2_inv target image_out row_num col_num gau
window_h_total = 150; window_w_total = 150;
start_i_total = 485; start_j_total = 335;
window_h = 50; window_w = 50;
sub_num_h = window_h_total/window_h;    sub_num_w = window_w_total/window_w;
fprintf('Step 1/4, please wait...\n');
x_syms = sym(zeros(window_h+2*(kernel_radius-1), window_w+2*(kernel_radius-1)));
k = 1;
for i = 1:size(x_syms, 1)
    for j = 1:size(x_syms, 2)
        x_syms(i, j) = ['x',num2str(k)];
        k = k + 1;
        if mod(k, 1000)==1
            k;
        end
    end
end
fprintf('Step 2/4, please wait...\n');
y_filted_syms = sym(zeros(window_h, window_w));
k = 1;
for i=1:window_h
	for j=1:window_w
            y_filted_syms(i, j) = sum(sum(gau.*x_syms(i:(i+2*(kernel_radius-1)), j:(j+2*(kernel_radius-1)))));
            k = k + 1;
            if mod(k, 1000)==1
                k;
            end
    end
end
fprintf('Step 3/4, please wait...\n');
time_consume_sd = 0;
time_consume_buffer = zeros(1, sub_num_h*sub_num_w);
for ii = 1:sub_num_h
    for jj = 1:sub_num_w
        start_i = start_i_total + (ii-1)*window_h;
        start_j = start_j_total + (jj-1)*window_w;
        target = badge_ori(start_i:(start_i+window_h-1), start_j:(start_j+window_w-1));

        error_syms = (y_filted_syms - target).^2;
        error_syms_sum = sum(sum(error_syms));
        f = error_syms_sum;
        
        fun = matlabFunction(f);
        s = func2str(fun);
        k = 1;
        rec_flag = 0;
        for i=1:length(s)
            if s(i)==')'
                end_pos = i-1;
                var_reset(k) = str2num(s(start_pos:end_pos));
                break
            end
            if s(i)=='x'
                rec_flag = 1;
                start_pos = i+1;
            end
            if s(i)==','
                if rec_flag
                    end_pos = i-1;
                    var_reset(k) = str2num(s(start_pos:end_pos));
                    rec_flag = 0;
                    k = k + 1;
                if mod(k, 1000)==1
                    k;
                end
                end
            end
        end

        for i=length(var_reset):-1:1
            s = eval(['strrep(s,''x',num2str(var_reset(i)),''',''x(',num2str(i),')'');']);
            if mod(i, 1000)==1
                i;
            end
        end

        kk = 0;
        for i = 1:length(s)
            if s(i) == ')'
                kk = kk + 1;
                if kk == length(var_reset)
                    record_i = i;
                    break
                end
            end
        end
        s(4:record_i) = [];
        fun = str2func(s);
        
        x0_init = zeros(size(target,1)+2*(kernel_radius-1), size(target,2)+2*(kernel_radius-1));
        x0_init(kernel_radius:(kernel_radius+size(target,1)-1), kernel_radius:(kernel_radius+size(target,2)-1)) = target;
        x0_init(1:(kernel_radius-1), kernel_radius:(kernel_radius+size(target,2)-1)) = repmat(target(1,:), (kernel_radius-1), 1);
        x0_init((kernel_radius+size(target,1)):end, kernel_radius:(kernel_radius+size(target,2)-1)) = repmat(target(end,:), (kernel_radius-1), 1);
        x0_init(kernel_radius:(kernel_radius+size(target,2)-1), 1:(kernel_radius-1)) = repmat(target(:,1), 1, (kernel_radius-1));
        x0_init(kernel_radius:(kernel_radius+size(target,2)-1), (kernel_radius+size(target,1)):end) = repmat(target(:,end), 1, (kernel_radius-1));
        x0_init = x0_init';
        x0_init = (x0_init(:))';
        x0 = x0_init(var_reset(1, :));

        x0 = double(x0);
        tic;
       
        fprintf(['Sub-step3-',num2str((ii-1)*sub_num_w + jj),'/',num2str(sub_num_h*sub_num_w),'\n']);
        options = optimoptions(@fmincon,'MaxFunctionEvaluations',26000, 'MaxIterations',1500);
        tic;
        [x,fval,exitflag,output] = fmincon(fun,x0,[],[],[],[],zeros(1, length(x0)),[],[],options);
        time_consume_sd_buffer(1, ((ii-1)*sub_num_w + jj)) = toc;
        time_consume_sd = time_consume_sd + time_consume_sd_buffer(1, ((ii-1)*sub_num_w + jj));
        
        fval;
        exitflag;
        output;
        
        x_unroll = zeros(1, size(x_syms,1)*size(x_syms,2));
        x_unroll(var_reset)=x;
        result_sd = (reshape(x_unroll, size(x_syms,1),size(x_syms,2)))';
        result_sd = result_sd(kernel_radius:(kernel_radius+size(target,1)-1), kernel_radius:(kernel_radius+size(target,2)-1));
        result_opt{ii, jj} = result_sd;
        clear start_i start_j target error_syms error_syms_sum f fun s var_reset x0 x fval exitflag output x_unroll result_sd
    end
end
fprintf('Step 4/4, please wait...\n');

for ii=1:sub_num_h
    for jj=1:sub_num_w
        start_i = 1 + (ii-1)*window_h;
        start_j = 1 + (jj-1)*window_w;
        result_opt_display(start_i:(start_i+window_h-1), start_j:(start_j+window_w-1))=result_opt{ii, jj};
    end
end
fprintf('Done!');
fprintf(['Time consumption of previous optimization method: ', num2str(time_consume_sd), '\n']);
end
