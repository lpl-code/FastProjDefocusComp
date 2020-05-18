%% binary-decoding-evaluation
clear
clc
addpath(genpath('data/'));
addpath('code/');
%% load images and decode from the captured gray-code images
add_str_1 = ['.\binary-30-lite\CAPTURED\normal-projection\'];
add_str_2 = ['.\binary-30-lite\CAPTURED\proposed\'];
[full_nth_1, finest_captured_image_1] = decode_conGraycode_version2(912, 1140, add_str_1);
[full_nth_2, finest_captured_image_2] = decode_conGraycode_version2(912, 1140, add_str_2);
%% display the captured images
figure; imshow(finest_captured_image_1, []); title('captured raw images by normal projection');
figure; imshow(finest_captured_image_2, []); title('captured raw images by proposed method');
%% display a profile of the measured decoding results
x = 176:1046;
figure; plot(x, full_nth_1(576, x),'r', 'lineWidth', 1);
hold on; plot(x, full_nth_2(576,x),'k', 'lineWidth', 1);
legend('normal projection', 'proposed', 'Location','northwest', 'Box', 'off');
title('profile comparison of the measured coding values extracted from the two projections');
%% display the extracted coding map
figure; imshow(full_nth_1, []); colorbar; title('extracted decoding map by normal projection');
figure; imshow(full_nth_2, []); colorbar; title('extracted decoding map by proposed method');
