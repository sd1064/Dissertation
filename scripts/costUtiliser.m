landmarks = loadLandmarks;
sizePC = size(model.shapePC, 2);

landmarksAverage = landmarks(:,2:end);
offsets = model.shapeEV;
Rx = 1; Ry = 2; Rz = 3; Tx = 4; Ty = 5; Tz = 6;

zPos = repelem(focalLengthWorldUnits,size(projectedImage,1)).';
landmarkVertNum  = landmarks(:,1) +1;
landmarksProjectedImage = getLandmarks([projectedImage zPos],landmarkVertNum);

params = double([offsets; ...
    Rx; Ry; Rz; Tx; Ty; Tz; ]);

func = @(params)differenceFaces(params,spherePosition,sphereRadius, ...
        focalLengthWorldUnits,centreProjectionX,centreProjectionY, ...
        model,landmarkVertNum,landmarksProjectedImage);

leastSquare = lsqnonlin(func,params);

