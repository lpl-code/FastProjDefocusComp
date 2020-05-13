%% estimation of noise level
clear
clc
addpath(genpath('data/'));
addpath('code/');
%% load captured raw images
add_str = ['.\binary-30-lite\CAPTURED\normal-projection\'];
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
metrics1 = zeros(10,1);
%% list the results
fprintf('******************************************************************************\n');
fprintf('Image No.               1          2          3          4          5\n');
fprintf('Noise Level*10^(-4)     ');
for kn = 1:5
    z = im2double(captured_images{kn, 1}(:,:,1)); 
    metrics1(kn,1)=noise_evaluation_acva(z);
    fprintf('%.4f     ', metrics1(kn, 1)*10000);
end
fprintf('\n');
fprintf('------------------------------------------------------------------------------\n');
fprintf('Image No.               6          7          8          9          10\n');
fprintf('Noise Level*10^(-4)     ');
for kn = 6:7
    z = im2double(captured_images{kn, 1}(:,:,1)); 
    metrics1(kn,1)=noise_evaluation_acva(z);
    fprintf('%.4f     ', metrics1(kn, 1)*10000);
end
for kn = 8
    z = im2double(captured_images{kn, 1}(:,:,1)); 
    metrics1(kn,1)=noise_evaluation_acva(z);
    fprintf('%.4f    ', metrics1(kn, 1)*10000);
end
for kn = 9
    z = im2double(captured_images{kn, 1}(:,:,1)); 
    metrics1(kn,1)=noise_evaluation_acva(z);
    fprintf('%.4f    ', metrics1(kn, 1)*10000);
end
for kn = 10
    z = im2double(captured_images{kn, 1}(:,:,1)); 
    metrics1(kn,1)=noise_evaluation_acva(z);
    fprintf('%.4f', metrics1(kn, 1)*10000);
end
fprintf('\n');
fprintf('******************************************************************************\n');
