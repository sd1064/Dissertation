% Setup
% Calibrate Camera
% Read in image 
% Undistort image
% Get Centre point and radius of circle
% Make call to calculate extrinsic
% Displays the camera and sphere

clc;
clear;

loader;
calculateParams;
% sphereUndistort;

pointsTo2D;
costUtiliser;

displayGennedVInput;
displayCamera;








