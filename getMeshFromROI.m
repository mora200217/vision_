function [model] = getMeshFromROI(img, depth, mask, ROI, maxDis)
    % ROI -> Rectangle Instance
    ROI = uint32(ROI); 
    x = ROI(1); y = ROI(2);
    w = ROI(3); h = ROI(4);
   
    crop_img = img(y: y + h, x:x + w, :);
    crop_depth = depth(y: y + h, x:x + w);
    crop_mask = mask(y: y + h, x:x + w);
    
    depth_region = uint8(crop_mask) .* crop_depth; 
    [R, C] = size(depth_region); 
    pts = zeros(R * C, 3 + 3); 
    
    i = 1; 
    % create de point cloud 
    for row = 1: R
        for col = 1: C
            if depth_region(row,col) ~= 0
                color = uint8(crop_img(row, col, :)); 
                color = color(:)';
                size(color);
                
                pts(i, :) = [col, row, depth_region(row,col), color(1), color(2), color(3)]; 
                i = i + 1; 
            end
        end 
    end 
    
    color = pts(:, 4:end) / 255;
    ptsCloud = pointCloud(pts(:, 1:3), "Color", color); 
   
    
    roi = [-inf,inf;-inf,inf;140,235];
    sampleIndices = findPointsInROI(ptsCloud,roi);
%    
    
    model = pcfitcylinder(ptsCloud, maxDis, "SampleIndices",sampleIndices); 
    
%     pcshow(ptsCloud); 
%     hold on; 
%     plot(model); 
%     hold off; 
%     
end 
