function [processed_img] = inRange(img,channel, range)
%INRANGE 
% This function takes an img with n-channels and 
% applies a threshold activating the pixels within the specified
% range along the channel

%% Params 
% img -> RGB Image 
% Channel -> int n [0, channels(img)] 
% range -> Vector

%% Body
if channel > channel || channel <= 0
    error("Channel must be positive and less than img channels. You funky yankee dork!");
end 


[R, C, Ch] = size(img); % R - Row , C - Cols, Ch - Channels
img_copy = img;  % Copy to modify

% For single value ranges. [0, value]
if length(range) == 1
    range = [0 range]; 
end 

for row = 1:R
    for col = 1:C
        px_val = img_copy(row, col, channel); 
        if px_val >= range(1) && px_val <= range(2)
            img_copy(row, col, :) = [255, 255 ,255]; 
        else
            img_copy(row, col, :) = [0, 0, 0]; 
        end 
            
    end 
end

processed_img = img_copy; 

end
