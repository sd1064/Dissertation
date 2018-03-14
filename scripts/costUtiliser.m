zPos = repelem(focalLengthWorldUnits,size(projectedImage,1)).';

% At the moment always use all landmarks 
% This could do with being smarter
% Won't need this once landmarks are flowing through 
% landmarksProjectedImage = getLandmarks([projectedImage zPos],idx);
% landmarksProjectedImage = landmarksProjectedImage(1:numLandmarks,:);

offsets = repelem(0,numOfParams).';
Rx = 0; Ry = 0; Rz = 0; Tx = 0; Ty = 0; Tz = 0;
params = double([offsets; Rx; Ry; Rz; Tx; Ty; Tz; ]);

% ---------------------------------------------------------------------
% SPHERE ONE 
funcOne = @(params)differenceFaces(paramsOne,spherePositionOne,sphereRadius, ...
        focalLengthWorldUnits,centreProjectionX,centreProjectionY, ...
        model,projectedImageLandmarksSphereOne,numOfParams,idx);
options = optimoptions('lsqnonlin','Display','iter');

[retOne,resnorm,residual,exitflag,output] = lsqnonlin(funcOne,paramsOne,[],[],options);
% ---------------------------------------------------------------------

% SPHERE Two 
funcTwo = @(params)differenceFaces(paramsTwo,spherePositionTwo,sphereRadius, ...
        focalLengthWorldUnits,centreProjectionX,centreProjectionY, ...
        model,projectedImageLandmarksSphereTwo,numOfParams,idx);
options = optimoptions('lsqnonlin','Display','iter');

[retTwo,resnorm,residual,exitflag,output] = lsqnonlin(funcTwo,paramsTwo,[],[],options);
% ---------------------------------------------------------------------

