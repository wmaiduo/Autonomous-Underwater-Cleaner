function [AdjustedDepthImage] = adjustDepth(depthImage)
m = max(max(depthImage));
divisionScale = m/256;

s = size(depthImage);
grayscaleDepth = zeros(s(1),s(2));
for i = 1:s(1)
    for j = 1:s(2)
        grayscaleDepth(i,j)=depthImage(i,j)/divisionScale;
    end
end
AdjustedDepthImage = imfuse(grayscaleDepth, depthImage);
end