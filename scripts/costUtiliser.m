landmarks = loadLandmarks;
sizePC = size(model.shapePC, 2);

landmarksAverage = landmarks(:,2:end);
%offsets = model.shapeEV;
offsets = repelem(0.5,size(model.shapeEV,1)).';
Rx = 0; Ry = 0; Rz = 0; Tx = 0; Ty = 0; Tz = 500;

zPos = repelem(focalLengthWorldUnits,size(projectedImage,1)).';
landmarkVertNum  = landmarks(:,1) +1;
landmarksProjectedImage = getLandmarks([projectedImage zPos],landmarkVertNum);

params = double([offsets; ...
    Rx; Ry; Rz; Tx; Ty; Tz; ]);

func = @(params)differenceFaces(params,spherePosition,sphereRadius, ...
        focalLengthWorldUnits,centreProjectionX,centreProjectionY, ...
        model,landmarkVertNum,landmarksProjectedImage);

ret = lsqnonlin(func,params);

% Plot Target
targetVerts = verts.';
targetParams  = object2coef( verts(:), model.shapeMU, model.shapePC, model.shapeEV );
figure;hold on;pcshow([verts(:,1) verts(:,2) verts(:,3)])
% 
% Plot lsq
lsqFace = coef2object( ret(1:199), model.shapeMU, model.shapePC, model.shapeEV );
lsqFace = reshape(lsqFace, [ 3 prod(size(lsqFace))/3 ])';
figure;hold on;pcshow([lsqFace(:,1) lsqFace(:,2) lsqFace(:,3)])

