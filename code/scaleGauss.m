function test_adj = scaleGauss(test, kernel_radius)
test_sort = unique(test(:));
test_sort_uniq = sort(test_sort, 'descend');
select_num = (1+kernel_radius)*kernel_radius/2;
if length(test_sort_uniq) < select_num
    value_for_fill = test_sort_uniq;
    value_for_fill((length(test_sort_uniq)+1):select_num)=0;
else
    value_for_fill = test_sort_uniq(1:select_num);
end
test_adj = zeros(2*kernel_radius-1, 2*kernel_radius-1);
k = 1;
for i = 0:(kernel_radius-1)
    for j = 0:i
        test_adj(kernel_radius+i, kernel_radius+j) = value_for_fill(k);
        test_adj(kernel_radius+i, kernel_radius-j) = value_for_fill(k);
        test_adj(kernel_radius-i, kernel_radius+j) = value_for_fill(k);
        test_adj(kernel_radius-i, kernel_radius-j) = value_for_fill(k);
        test_adj(kernel_radius+j, kernel_radius+i) = value_for_fill(k);
        test_adj(kernel_radius+j, kernel_radius-i) = value_for_fill(k);
        test_adj(kernel_radius-j, kernel_radius+i) = value_for_fill(k);
        test_adj(kernel_radius-j, kernel_radius-i) = value_for_fill(k);
        k = k+1;
    end
end