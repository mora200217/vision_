function [cleanedImage] = cleanImage(img, type)
%CLEANIMAGE Summary of this function goes here
%   Erodes, Dilates, and Cleans borders from a Intensity Image. 

%% Params 
% img -> Intensity image (1 channel) 

[R, C, Ch] = size(img); 
if Ch > 1
    error("Only 1 dimensional image are allowed for clean"); 
end 

SE_1 = strel('square', 1); SE_2 = strel('square', 2); SE_4 = strel('square', 4);
SE_d = strel("Disk", 3); 
% img = imopen(img, SE_d); 

% Erode
img_eroded = imerode(img, SE_2);
img_dilated = imdilate(img_eroded, SE_4);

cleanedImage = img_dilated; 
if type == "WClean"||type == "WFillAndClean"
    cleanedImage = imclearborder(cleanedImage); % No borders 
end

if type == "WClean"||type == "WFillAndClean"
    cleanedImage = imfill(cleanedImage, 'holes'); % No borders 
end



end 

