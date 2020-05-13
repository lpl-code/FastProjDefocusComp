function [full_nth, finest_captured_image] = decode_conGraycode_version2(h_size, v_size, add_str)
%% load captured gray-code images
dim = 1;
fileFolder=fullfile(add_str);
dirOutput=dir(fullfile(fileFolder,'*'));
fileNames={dirOutput.name}';
k = 1;
for i = 1:length(fileNames)
    if fileNames{i, 1}(1) ~= '.'
        captured_images{k, 1} = imread([add_str, '\', fileNames{i, 1}]);
        k = k + 1;
    end
end
%% decoding from captured images
patterns_num = ceil( log2(h_size) );
% binarization
for n = 1 : patterns_num
    I_c = captured_images{n, 1}(:,:,1);
    I_c_bin = imbinarize(I_c);
    Binarized_graycode_pic{n} = I_c_bin;
end
% dcoded pixels' column
[pic_v_size, pic_h_size] = size(Binarized_graycode_pic{1});
sub_region_nth = zeros(pic_v_size, pic_h_size);
for i = 1 : pic_v_size
    for j = 1 : pic_h_size
        for n = 1 : patterns_num
            encoded_graycode(n) = Binarized_graycode_pic{n}(i, j);
        end
        sub_region_nth(i,j) = Gray2Dec(encoded_graycode) + 1;
    end
end
%% Full Decoding
full_nth = sub_region_nth;
%%
finest_captured_image = captured_images{patterns_num, 1};