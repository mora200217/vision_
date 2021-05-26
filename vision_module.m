close all;  

% import image 
DIR = 'data'; image_id = 6; 
path = join([DIR, "/", image_id, ".jpeg"], ""); 

image = imread(path); 
bw = rgb2gray(image); 
% Segmentation 
img_hsv = rgb2hsv(image);  % Color space transformation (RGB -> HSV)

% subplot(1,2,1); 
% imshow(image)
% 
% subplot(1,2,2); 
% imshow(img_hsv)

%% Processing 
th= 0.3; % From app tool

[y_l, x_l, ch] = size(img_hsv); 
norm_val = ones(1,3); 

for col = 1:x_l
    for row = 1:y_l
        px_val = img_hsv(row, col, 2); 
        
        if px_val < th
            img_hsv(row, col, :) = 255 * norm_val; 
        else 
            img_hsv(row, col, :) = 0 * norm_val; 
        end 
            
    end 
end 

img_hsv = im2bw(img_hsv); 



se = strel('square', 2);
se2 = strel('square', 4);
img_e = imerode(img_hsv, se);
img_d = imdilate(img_e, se2);

img_d = imclearborder(img_d,4);
img_d = imfill(img_d, 'holes')
img_d = imerode(img_d, se)


% imshow(img_d)

img_for_rois = img_d
% open image 
SE_open = strel('disk', 10); 
img_after_open = imopen(img_for_rois, SE_open)


img_after_open = imerode(img_after_open, se); 

imshow(img_after_open)
%props 

figure(); 

bw = rgb2gray(image); 
s = regionprops(img_after_open, 'centroid')
box = regionprops(img_after_open, 'BoundingBox')
orientation = regionprops(img_after_open, 'Orientation'); 

mAxis= regionprops(img_after_open, 'MinorAxisLength'); 
MAxis = regionprops(img_after_open, 'MajorAxisLength'); 


maxis_vals = cat(1, mAxis.MinorAxisLength)
Maxis_vals = cat(1, MAxis.MajorAxisLength)
orientation_vals = cat(1, orientation.Orientation)

% minor, major, orientation
values = [Maxis_vals, maxis_vals, orientation_vals] 


boxes = cat(1,box.BoundingBox);
centroids = cat(1,s.Centroid);


[r, c] = size(values)
for i = 1:r
    h = drawellipse('Center',centroids(i, :),'SemiAxes',values(i, 1:2),'StripeColor','r', 'RotationAngle', values(i, 3));
end 





hold on; 
imshow(bw); 
hold on; 
plot(centroids(:,1),centroids(:,2),'r*')


%% Identify 
% % edge Canny
% img_edge = edge(img_d, 'Canny'); 
% 
% imshow(img_edge); 
% 
% [H, T, R] = hough(img_edge);
% 
% figure(); 
% 
% 
% 
% imshow(imadjust(rescale(H)),'XData',T,'YData',R,...
%       'InitialMagnification','fit');
%  axis on, axis normal, hold on;
% colormap(gca,hot);
% 
% P  = houghpeaks(H,5,'threshold',ceil(0.01*max(H(:))));
% x = T(P(:,2)); y = R(P(:,1));
% plot(x,y,'.','color','green', 'markerSize', 20);
% hold off ; 
% 
% % Hough lines from peaks
% 
% BW = im2gray(image)
% 
% hold off; 
% lines = houghlines(BW,T,R,P,'FillGap',5,'MinLength',0.2);
% figure(), imshow(BW), hold on
% 
% max_len = 0;
% for k = 1:length(lines)
%    xy = [lines(k).point1; lines(k).point2];
%    plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
% 
%    % Plot beginnings and ends of lines
%    plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
%    plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');
% 
%    % Determine the endpoints of the longest line segment
%    len = norm(lines(k).point1 - lines(k).point2);
%    if ( len > max_len)
%       max_len = len;
%       xy_long = xy;
%    end
% end
