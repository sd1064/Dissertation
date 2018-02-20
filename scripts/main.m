% Setup
% Calibrate Camera
% Read in image 
% Undistort image
% Get Centre point and radius of circle
% Make call to calculate extrinsic
% Displays the camera and sphere

clc;
clear;

model = load('01_MorphableModel.mat');
load('face.mat','shape');
sphereRadius = 53;

calculateParams;
pointsTo2D;
costUtiliser;
displayCamera;
% sphereUndistort;





