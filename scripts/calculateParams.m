sphereRadius = 53;

originalImage = imread('testSphere.jpg');
cameraParams = calibrateCamera(25,23);

[undistortedImage, newOrigin] = undistortImage(originalImage, cameraParams, 'OutputView', 'full');
[centres,radii] = circleRecognition(undistortedImage,330,390);

sphereOne = [centres(1,1) centres(1,2) radii(1,1)];
spherePosition = extrinsicSphereCalibration(cameraParams.IntrinsicMatrix,sphereOne,sphereRadius);

%sphereTwo = [centres(2,1) centres(2,2) radii(2,1)];
%outputTwo = extrinsicSphereCalibration(cameraParams.IntrinsicMatrix,sphereTwo,8);

focalLengthWorldUnits = calculateFocalLengthWorldUnits(sphereRadius,sphereOne(1,3),cameraParams.FocalLength(1));
centreProjectionX = size(undistortedImage,1)/2;
centreProjectionY = size(undistortedImage,2)/2;