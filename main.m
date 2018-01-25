% Setup
% Calibrate Camera
% Read in image 
% Undistort image
% Get Centre point and radius of circle
% Make call to calculate extrinsic
% Displays the camera and sphere


clc;
clear;

originalImage = imread('test.jpg');
cameraParams = calibrateCamera(9);
[undistortedImage, newOrigin] = undistortImage(originalImage, cameraParams, 'OutputView', 'full');
[centres,radii] = circleRecognition(undistortedImage);

sphereOne = [centres(1,1) centres(1,2) radii(1,1)];
sphereTwo = [centres(2,1) centres(2,2) radii(2,1)];

outputOne = extrinsicSphereCalibration(cameraParams.IntrinsicMatrix,sphereOne,8);
outputTwo = extrinsicSphereCalibration(cameraParams.IntrinsicMatrix,sphereTwo,8);

displayCamera;

%input mesh





