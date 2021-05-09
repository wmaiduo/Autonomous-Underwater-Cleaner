%This section is used to boot up and connect the camera, uncomment it if
%you want to try the code, also download image processing,  image
%acquisition, kinect, statistics and machine learning toolboxes
%{
kinectDeviceInfo = imaqhwinfo('kinect');
colorDevice = kinectDeviceInfo.DeviceInfo(1);
depthDevice = kinectDeviceInfo.DeviceInfo(2);
colorVid = videoinput('kinect',1);
depthVid = videoinput('kinect',2);
preview([colorVid depthVid]);
%}

%this function is used to get x, y and z coordinate of the nearest debris
%and to detect whether the pool boundary is close
function [minDistX,minDistY,minDistZ,BoundaryClose] = acquireImageData(colorVid,depthVid);
[colorImage,depthImage] = getImageInput(colorVid,depthVid);
[coordinate,result] = segmentInBlue(colorImage);
if coordinate(1,1) ~= -1 && coordinate(2,1) ~= -1
    [minDistX, minDistY, minDistZ] = findMinDistance(coordinate,depthImage);
end
BoundaryClose = isBoundaryClose(depthImage);
%{
   f1 = figure;
   imshow(depthMontage);
   hold on;
   scatter(minDistY,minDistX,'filled');
   hold off;
   f2 = figure;
   imshow(result);
   hold on;
   scatter(minDistY,minDistX,'filled');
   hold off;
%}
end