function [collisionboxes] = GetCollisionBoxesFromRGBD(img, I)

[axes, ptsCloud] = getAxis(img, I);
% collision boxes 

[N, val] = size(axes);
% collisionboxes = zeros(N, 1); 
for i = 1:N
    collisionboxes(i) = CreateCollisionBoxFromAxis(axes(i, :));
    %hold on; 
    %show(cb); 
end 
end

