
function [nuclei, V] = nuclei_counter(BW)
% This function takes a grayscale image and counts cell nuclei 

% Image preprocessing 
BW = bwareaopen(BW,30); % get rid of white regions smaller than 30 pixels. Modify if necessary.
se = strel('disk', 2); % Modify threshold if necessary. 
BW = imdilate(BW, se);
se = strel('disk', 2);
BW = imerode(BW, se);
cc = bwconncomp(BW); % default connectivity is 8. Modify if necessary. 
numPixels = cellfun(@numel,cc.PixelIdxList);

% Count Nuclei
nuclei  = cc.NumObjects;
% Nuclei Size Variance 
V = var(numPixels,0,2); % Returns a scalar containing the variance of the elements in each row.
end