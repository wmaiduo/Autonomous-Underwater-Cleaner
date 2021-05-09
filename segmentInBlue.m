%function used for segment background and foreground of an image
function [coordinate,result] = segmentInBlue(RGB)

%acquire the a image for the blue channel values
blueChannel = RGB(:,:,3);

%Find threshold of blue channel to separate foreground and background
T = graythresh(blueChannel);
%Separate the image using binarization
BW = imbinarize(blueChannel,T);

%For displaying purposes only
%maskedRGBImage = RGB;
%maskedRGBImage(repmat(~BW,[1 1 3])) = 0;

%Construct a structuring element for morphological process
se = strel('disk',5);

%Perform open morphlogical process to the image to eliminate possible
%noises
open = imopen(BW,se);

%Perform close morphological process to reduce the size of unwanted element
%after open process
processedMasked = imclose(open,se);

%Find the result
s = size(BW);
result = RGB;

%Initialize coordinate for values containing debris
coordinate = zeros(2,1000000);
%Find how many pixels contain debris
counter = 1;

%Update the image
for i = 1:s(1)
    for j = 1:s(2)
        if processedMasked(i,j) == 0
            for k = 1:3
                result(i,j,k) = 0;
                coordinate(1,counter) = i;
                coordinate(2,counter) = j;
                counter = counter + 1;
            end
        end
    end
end

%Add coordinate of all pixels with debris
coordinate = coordinate(1:2,1:counter-1);

%----------------------------------------------------------------------
% Check whether there is actual debris in water, or only exists water
%Perform a kernel density smoothing to acquire a line for the histogram
[f,xi] = ksdensity(blueChannel(:));

%For Displaying Purposes
%plot(xi,f)

%Find the derivative
dy = diff(f)./diff(xi);

%Count for how many derivative critical points that can be considered as
%peaks or valley exist in the kernel smoothed diagram
count = 0;
%initialize the variable to determine whether the current derivative value is positive
isCurrentPositive = -100;


for i = 1:99
    if (dy(i) ~= 0) && (f(i) > 0.0001)
        isLastPositive = isCurrentPositive;
        if dy(i) > 0
            isCurrentPositive = 1;
        elseif dy(i) < 0
            isCurrentPositive = 0;
        end
        %If the last derivate and current derivative does not have the same
        %sign, then a peak or valley exists
        if (abs(isCurrentPositive-isLastPositive) == 1)
            count = count + 1;
        end
    end
end

%If it found that not enough peaks exist, the function return a coordinate
%with value of [-1, -1]
if count < 4
    coordinate = [-1;-1];
end
%end of check
%-----------------------------------------------------------------------

%For displaying purposes only
%figure
%montage({RGB,maskedRGBImage,processedMasked,result});

end
