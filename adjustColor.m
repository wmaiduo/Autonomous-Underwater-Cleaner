function [AdjustedColorImage] = adjustColor(colorImage)
%resize the image so color and depth image fits
resizedColorImage = imresize(colorImage, 0.39259259);
%0.39259259 = 424/1080, 424 is pixels height for depth image, 1080 is pixels height for color image

%crop parts of color image where images do not fit with depth Image
AdjustedColorImage = resizedColorImage(:,122:633,:);
%{
121 leftmost and rightmost columns are cropped 
754-512 = 242, where 754 is the width of the resized color image and 512 is
the width of the depth image
%}
end