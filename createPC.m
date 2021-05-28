function [pc] = createPC(img, depth)
    
    [R, C, channel] = size(img);
    
    pts = zeros(R * C, 3 + 3, "double"); % xyz + rgb
    i = 1; 
 
    for row = 1: R
        for col = 1: C
                color = double(img(row, col, :)); 
                color = color(:)';
                
                value = [col, R - row, double(depth(row,col)), color(1), color(2), color(3)]; 
                
                value = double(value); 
                pts(i, :) = value;
                i = i + 1; 
        end 
    end 
    
    
    color = double(pts(:, 4:end)) / 255; 
    xyz = double(pts(:, 1:3)); 
    
    
    %% Correction position 
    % X - center 
    xyz(:, 1) = xyz(:, 1) - .5 * C; 
    xyz(:, 3) = -xyz(:, 3); 
    
    pc = pointCloud(xyz, 'Color', color); 
    
    
end


