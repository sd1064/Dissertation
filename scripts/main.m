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

% load('face.mat','shape');
shp = coef2object( randn(199, 1), model.shapeMU, model.shapePC, model.shapeEV );
shape = reshape(shp, [ 3 prod(size(shp))/3 ]); 

sphereRadius = 53;

calculateParams;
pointsTo2D;
costUtiliser;
displayGennedVInput;
displayCamera;
sphereUndistort;





