% Load Model Stuff
model = load('01_MorphableModel.mat');
% load('face.mat','shape');

shp = coef2object( randn(199, 1), model.shapeMU, model.shapePC, model.shapeEV );
shape = reshape(shp, [ 3 prod(size(shp))/3 ]); 

verts = shape.';
verts = verts .* (1e-03);

% Discard lanmdarks so landmarks for BFM and face detector match 
idx = readLandmarks('Landmarks68_BFM.anl');
idx = [idx(1:60,1); idx(62:64,1) ; idx(66:end,1)];
idx = [idx(18:end)];

sizePC = size(model.shapePC, 2);

% Load Image Stuff
originalImage = imread('spheres (17).JPG');
originalImage = im2double(originalImage);

% Set params
sphereRadius = 12.5;

numberImages = 13;
squareSize   = 4;

centreProjectionX = 0;
centreProjectionY = 0;

numOfParams  = 25;
numLandmarks = 49;

vFov = 145; 
hFov = 145;

vppImageWidth = 800;
zPlane = 0.1;