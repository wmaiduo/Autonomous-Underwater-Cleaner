%Check whether pool boundary is close
function [BoundaryClose] = isBoundaryClose(depthImage)

s = size(depthImage);

%initialize variable to count pixels to detect whether pool boundary is
%close
boundaryClosePixel = 0;

%Find how many pixels is close to the nearest object
for i = 1:s(1)
    for j = 1:s(2)
        %if a pixel of depth camera is too close to an object, its value
        %becomes 0
        if depthImage(i,j) == 0
            boundaryClosePixel = boundaryClosePixel + 1;
        end
    end
end

if boundaryClosePixel > s(1)*s(2)/2
    BoundaryClose = 1;
else
    BoundaryClose = 0;
end
end
