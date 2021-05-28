function drawBoxes(bbox)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

boxes = zeros(1, length(bbox)); 

[R, C] = size(bbox); 
for i = 1:R
    h = images.roi.Rectangle(gca, 'Position', bbox(i, :)); 
end 

end

