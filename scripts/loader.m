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
idx = [ idx(1:60,1) ;  idx(62:64,1) ; idx(66:end,1)];

sizePC = size(model.shapePC, 2);

% Load Image Stuff
originalImage = imread('ball2.jpg');
originalImage = im2double(originalImage);

% Set params
sphereRadius = 53;

numberImages = 25;
squareSize   = 23;

centreProjectionX = 0;
centreProjectionY = 0;

numOfParams  = 25;
numLandmarks = 66;