% Setup
% Calibrate Camera
% Read in image 
% Undistort image
% Get Centre point and radius of circle
% Make call to calculate extrinsic

clc;
clear;

originalImage = imread('mockedUp.jpg');
cameraParams = calibrateCamera(9);
[undistortedImage, newOrigin] = undistortImage(originalImage, cameraParams, 'OutputView', 'full');
[centres,radii] = circleRecognition(undistortedImage);

sphereOne = [centres(1,1) centres(1,2) radii(1,1)];
sphereTwo = [centres(2,1) centres(2,2) radii(2,1)];

output = extrinsicSphereCalibration(cameraParams.IntrinsicMatrix,sphereOne);

