function graphPC(pcMat, t)
%GRAPHPC Summary of this function goes here
%   Detailed explanation goes here
figure; 
scatter3(pcMat(:, 1), pcMat(:, 2), pcMat(:, 3),'.'); 
title(t); 
end

