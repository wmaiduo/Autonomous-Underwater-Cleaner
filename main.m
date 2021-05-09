%This section is used to boot up and connect the camera
kinectDeviceInfo = imaqhwinfo('kinect');
colorDevice = kinectDeviceInfo.DeviceInfo(1);
depthDevice = kinectDeviceInfo.DeviceInfo(2);
colorVid = videoinput('kinect',1);
depthVid = videoinput('kinect',2);
preview([colorVid depthVid]);

pause(10);%
while (1)
    %Acquire Image from camera
    [colorImage,depthImage,depthMontage] = getImageInput(colorVid,depthVid);
    %Segment Image
    [coordinate,result] = segmentInBlue(colorImage);
    %Find coordinate based on image segmentation and depth Image
    if coordinate ~= [-1;-1]
        [minDistY, minDistX, minDistZ] = findMinDistance(coordinate,depthImage);
    else
        minDistX = -1;minDistY = -1;minDistZ = -1;%x,y and z = -1 if no debris
    end
    
    %Don't really work now
    %isBoundaryClose = isBoundaryClose(depthImage);
    
    %The following sections show the result
    f1 = figure;
    imshow(depthMontage);
    hold on;
    scatter(minDistX,minDistY,'filled');
    hold off;
    f2 = figure;
    imshow(result);
    hold on;
    scatter(minDistX,minDistY,'filled');
    hold off;
    
    %Use the x, y, z and boundary information to control the motor
    %motorControl(minDistX, minDistY, minDistZ);
    
    
    %only thing for motor control is minDistX, minDistY, minDistZ
    
    disp(["\n new: \n"]);
    disp(["x: ", minDistX, "\n"]);
    disp(["y: ", minDistY, "\n"]);
    disp(["z: ", minDistZ, "\n"]);
    pause(5);
    close all
end