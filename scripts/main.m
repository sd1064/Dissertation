% Setup
% Calibrate Camera
% Read in image 
% Undistort image
% Get Centre point and radius of circle
% Make call to calculate extrinsic
% Displays the camera and sphere

clc;
clear;

% Load
loader;

% Processing
% sphereUndistort; - Not ready to be included yet
calculateParams;
pointsTo2D;
costUtiliser;

% Display
displayGennedVInput;
displayCamera;






