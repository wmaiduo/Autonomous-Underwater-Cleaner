function [colorInput,depthInput,depthMontage] = getImageInput(colorVid,depthVid)

%acquire image from the camera
colorImage = getsnapshot(colorVid);
depthImage = getsnapshot(depthVid);

%treat depth image for displaying purposes
%figure;
depthMontage = adjustDepth(depthImage);%only for displaying purposes


%treat colour Image to eliminate unwanted part and to fit with depth
%Image
colorInput = adjustColor(colorImage);

%montage({colorInput,depthMontage});%only for displaying purposes

depthInput = depthImage;
end