
zPos = repelem(focalLengthWorldUnits,size(projectedImage,1)).';

% At the moment always use all landmarks 
% This could do with being smarter
% Won't need this once landmarks are flowing through 
landmarksProjectedImage = getLandmarks([projectedImage zPos],idx);
landmarksProjectedImage = landmarksProjectedImage(1:numLandmarks,:);
% 

offsets = repelem(0,numOfParams).';
Rx = 0; Ry = 0; Rz = 0; Tx = 0; Ty = 0; Tz = 500;

params = double([offsets; ...
    Rx; Ry; Rz; Tx; Ty; Tz; ]);

func = @(params)differenceFaces(params,spherePosition,sphereRadius, ...
        focalLengthWorldUnits,centreProjectionX,centreProjectionY, ...
        model,landmarksProjectedImage,numOfParams,idx);

options = optimoptions('lsqnonlin','Display','iter');
    
[ret,resnorm,residual,exitflag,output] = lsqnonlin(func,params,[],[],options);