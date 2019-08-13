function captured_images = image_read_background(gen_add_str)
add_str = [gen_add_str,'DOT\'];
fileFolder=fullfile(add_str);
dirOutput=dir(fullfile(fileFolder,'*'));
fileNames={dirOutput.name}';
k = 1;
background = imread([gen_add_str,'background.bmp']);
for i = 1:length(fileNames)
    if fileNames{i, 1}(1) == '1'
        captured_images{k, 1} = imread([add_str, '\', fileNames{i, 1}]);
        captured_images{k, 1} = captured_images{k, 1} - background;
        k = k + 1;
    end
end
end