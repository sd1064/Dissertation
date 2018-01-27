clc;
clear;

%%

% Setup
% Calibrate Camera
% Read in image 
% Undistort image
% Get Centre point and radius of circle
% Make call to calculate extrinsic
% Displays the camera and sphere

% originalImage = imread('test.jpg');
% cameraParams = calibrateCamera(9);
% [undistortedImage, newOrigin] = undistortImage(originalImage, cameraParams, 'OutputView', 'full');
% [centres,radii] = circleRecognition(undistortedImage);
% 
% sphereOne = [centres(1,1) centres(1,2) radii(1,1)];
% sphereTwo = [centres(2,1) centres(2,2) radii(2,1)];
% 
% outputOne = extrinsicSphereCalibration(cameraParams.IntrinsicMatrix,sphereOne,8);
% outputTwo = extrinsicSphereCalibration(cameraParams.IntrinsicMatrix,sphereTwo,8);
% 
% displayCamera;

%%

% load scanned face
% load face list from morhable model
% rotate face so faces towards "camera" and set slightly back
% add in a camera for looks
% use a dummy value for focal length for now
% could do with scaling everything down

load('00001_20061015_00418_neutral_face05.mat');
load('01_MorphableModel.mat','tl');

verts=(roty(180)*shape).';
verts(:,3)= verts(:,3)+5e5; 

figure;hold on;
pcshow([verts(:,1),verts(:,2),verts(:,3)]);
xlabel('X');ylabel('Y');zlabel('Z');axis equal;grid on;

F = 1e5;
cam = plotCamera('Location',[0 ; 0 ; 0 ],'Orientation',eye(3),'Size',1e4);
projectedImage = perspectiveProjection(verts,F);

zPos = repelem(F,size(projectedImage,1)).';
pcshow([projectedImage(:,1),projectedImage(:,2),zPos])



