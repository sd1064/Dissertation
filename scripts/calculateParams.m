% cameraParams = calibrateCamera(numberImages,squareSize);
% [undistortedImage, newOrigin] = undistortImage(originalImage, cameraParams, 'OutputView', 'full');
[centres,radii] = circleRecognition(undistortedImage,330,380);

sphereOne = [centres(1,1) centres(1,2) radii(1,1)];
sphereTwo = [centres(2,1) centres(2,2) radii(2,1)];

k = cameraParams.IntrinsicMatrix';

spherePositionOne = extrinsicSphereCalibration(k,sphereOne,sphereRadius);
spherePositionTwo = extrinsicSphereCalibration(k,sphereTwo,sphereRadius);