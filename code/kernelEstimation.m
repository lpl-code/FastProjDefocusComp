function kernel = kernelEstimation(badge_ori_inv, badge_ori)
kernel_radius = 6;
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
            if sum(sum(kernel{i, j}))
                kernel{i, j} = kernel{i, j} ./ sum(sum(kernel{i, j}));
            end
        else
            kernel{i,j} = zeros(2*kernel_radius-1, 2*kernel_radius-1);
        end
    end
end

interval = 12;
for i = 1:1140
    for j = 1:912
         if norm(kernel{i, j},2)==0
            if ((ceil(i/interval))*interval+1)<=1140 && ((ceil(j/interval))*interval+1)<=912
                if ~isempty(kernel{((ceil(i/interval)-1)*interval+1), ((ceil(j/interval)-1)*interval+1)}) && ~isempty(kernel{((ceil(i/interval))*interval+1), ((ceil(j/interval))*interval+1)})
                    u = (i-((ceil(i/interval)-1)*interval+1))/interval;
                    v = (j-((ceil(j/interval)-1)*interval+1))/interval;
                    kernel{i, j} = (1 - u)*(1 - v)*kernel{((ceil(i/interval)-1)*interval+1), ((ceil(j/interval)-1)*interval+1)} + ...
                      (1 - u)* v     *kernel{((ceil(i/interval)-1)*interval+1),     ((ceil(j/interval))*interval+1)} + ...
                       u     *(1 - v)*kernel{((ceil(i/interval))*interval+1), ((ceil(j/interval)-1)*interval+1)} + ...
                       u     * v     *kernel{((ceil(i/interval))*interval+1),((ceil(j/interval))*interval+1)};
                    if sum(sum(kernel{i, j}))
                        kernel{i, j} = kernel{i, j} ./ sum(sum(kernel{i, j}));
                    end
                end
            end
        end
    end
end
end