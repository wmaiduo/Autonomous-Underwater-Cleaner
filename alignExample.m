kinectDeviceInfo = imaqhwinfo('kinect');
colorDevice = kinectDeviceInfo.DeviceInfo(1);
depthDevice = kinectDeviceInfo.DeviceInfo(2);
colorVid = videoinput('kinect',1);
depthVid = videoinput('kinect',2);
preview([colorVid depthVid]);
pause(5);
depthI = getsnapshot(depthVid);
colorI = getsnapshot(colorVid);

[colorizedDepth,coord] = alignImage(depthI,colorI,'IntrinsicRGB','InvIntrinsicIR','TransformationD-C'); %'05.png' and '05.jpg' are 424 respectively *512 depth map and corresponding 1080*1920 rgb map

%save computed data
imwrite(colorizedDepth,'Colorized_Depth.png');
figure,imshow(colorizedDepth);