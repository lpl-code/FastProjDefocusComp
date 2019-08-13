function captured_images = images_read(add_str)
fileFolder=fullfile(add_str);
dirOutput=dir(fullfile(fileFolder,'*'));
fileNames={dirOutput.name}';
k = 1;
for i = 1:length(fileNames)
    if fileNames{i, 1}(1) == '1'
        captured_images{k, 1} = imread([add_str, '\', fileNames{i, 1}]);
        captured_images{k, 1} = rgb2gray(captured_images{k, 1});
        k = k + 1;
    end
end