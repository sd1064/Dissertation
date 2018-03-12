% Load Model Stuff
model = load('01_MorphableModel.mat');
% load('face.mat','shape');
shp = coef2object( randn(199, 1), model.shapeMU, model.shapePC, model.shapeEV );
shape = reshape(shp, [ 3 prod(size(shp))/3 ]); 

verts = shape.';
verts = verts .* (1e-03);

% Discard lanmdark 61 and 65 so landmarks for BFM and face detector match 
landmarkpath = 'Landmarks68_BFM.anl';
idx = readLandmarks(landmarkpath);
idx  = [idx(18:end)];

sizePC = size(model.shapePC, 2);

% Load Image Stuff
originalImage = imread('testSphere.jpg');
originalImage = im2double(originalImage);

% Set params
sphereRadius = 53;

numberImages = 25;
squareSize   = 23;

centreProjectionX = 0;
centreProjectionY = 0;

numOfParams  = 25;
numLandmarks = 49;

hFov = 116;
vFov = 83;
vppImageWidth = 400;