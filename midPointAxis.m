function [mid_pts] = midPointAxis(axis)
%MIDPOINTAXIS Summary of this function goes here
%   Detailed explanation goes here
[num_axis, col] = size(axis);
mid_pts = zeros(num_axis, 3);
for i = 1:num_axis
    r_0 = axis(i, 1:3);
    r_1 = axis(i, 4:end);
    
    mid_pts(i, :) = (r_0 + r_1) / 2;
end 

end

