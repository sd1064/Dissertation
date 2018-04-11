cameraParams = calibrateCamera(numberImages,squareSize);
[undistortedImage, newOrigin] = undistortImage(originalImage, cameraParams, 'OutputView', 'full');
[centres,radii] = circleRecognition(undistortedImage,330,380);

sphereOne = [centres(1,1) centres(1,2) radii(1,1)];
sphereTwo = [centres(2,1) centres(2,2) radii(2,1)];

sphereOneXY = [sphereOne(1) size(undistortedImage,1)-sphereOne(2) sphereOne(3)];
sphereTwoXY = [sphereTwo(1) size(undistortedImage,1)-sphereOne(2) sphereTwo(3)]; 

spherePositionOne = extrinsicSphereCalibration(cameraParams.IntrinsicMatrix,sphereOneXY,sphereRadius);
spherePositionTwo = extrinsicSphereCalibration(cameraParams.IntrinsicMatrix,sphereTwoXY,sphereRadius);