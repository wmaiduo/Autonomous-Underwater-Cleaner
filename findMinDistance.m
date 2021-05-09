%find the x, y and z coordinate to the nearest debris in the image
function [mindistx,mindisty,mindistz] = findMinDistance(coordinate,depthImage)
%initialize the x and y coordinate for the pixel with the minimum distance
mindistx = -1;
mindisty = -1;
%initialize the z variable or the distance towards the pixel with the
%minimum distance
mindistz = 1000000000;

%loop through all coordinates found using image segmentation
for i = 1:length(coordinate)
    %update the x, y and z coordinate if a new minimum distance is found
    if depthImage(coordinate(1,i),coordinate(2,i)) < mindistz &&...
            depthImage(coordinate(1,i),coordinate(2,i))~= 0
        mindistz = depthImage(coordinate(1,i),coordinate(2,i));
        mindistx = coordinate(1,i);
        mindisty = coordinate(2,i);
    end
end

end