clear; clc; close all; 

img = imread('imgs/rgb.jpg'); % RGB image
I = imread('imgs/depth.jpg'); % Intensity images  1 Channel 

[axes, ptsCloud] = getAxis(img, I);
mid_pts = midPointAxis(axes)

% scatter3(mid_pts(:, 1), mid_pts(:, 2),mid_pts(:, 3), '.'); 