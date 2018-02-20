landmarks = loadLandmarks;
sizePC = size(model.shapePC, 2);

numOfParams  = 25;
numLandmarks = 35;

zPos = repelem(focalLengthWorldUnits,size(projectedImage,1)).';

landmarksAverage = landmarks(:,2:end);
landmarkVertNum  = landmarks(:,1) +1;
landmarksProjectedImage = getLandmarks([projectedImage zPos],landmarkVertNum);
landmarksProjectedImage = landmarksProjectedImage(1:numLandmarks,:);

offsets = repelem(0,numOfParams).';
Rx = 0; Ry = 0; Rz = 0; Tx = 0; Ty = 0; Tz = 500;

params = double([offsets; ...
    Rx; Ry; Rz; Tx; Ty; Tz; ]);

func = @(params)differenceFaces(params,spherePosition,sphereRadius, ...
        focalLengthWorldUnits,centreProjectionX,centreProjectionY, ...
        model,landmarkVertNum,landmarksProjectedImage,numOfParams);

options = optimoptions('lsqnonlin','Display','iter');
    
[ret,resnorm,residual,exitflag,output] = lsqnonlin(func,params,[],[],options);