%Setup
%Calibrate Camera
%Read in image 
%Undistort image
%Get Centre point and radius of circle
% Can assume [R T] = [0 0]

clc;
clear;

originalImage = imread('mockedUp.jpg');
cameraParams = calibrateCamera(9);
[undistortedImage, newOrigin] = undistortImage(originalImage, cameraParams, 'OutputView', 'full');
[centres,radii] = circleRecognition(undistortedImage);

sphereOne = [centres(1,1) centres(1,2)];
sphereTwo = [centres(2,1) centres(2,2)];

R = [0 0 0 ; 0 0 0; 0 0 0];
T = [0 0 0];

%worldPointsSphereOne = pointsToWorld(cameraParams, R, T, sphereOne);
%worldPointsSphereTwo = pointsToWorld(cameraParams, R, T, sphereTwo);
