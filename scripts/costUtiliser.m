landmarks = loadLandmarks;
sizePC = size(model.shapePC, 2);

landmarksAverage = landmarks(:,2:end);
offsets = repelem(0,199).';
% offsets = randn(199, 1);

Rx = 0; Ry = 0; Rz = 0; Tx = 0; Ty = 0; Tz = 500;

zPos = repelem(focalLengthWorldUnits,size(projectedImage,1)).';
landmarkVertNum  = landmarks(:,1) +1;
landmarksProjectedImage = getLandmarks([projectedImage zPos],landmarkVertNum);

%ONLY USE 1 LANDMARK ATM - NEED TO MAKE THIS LESS HACKY
landmarksProjectedImage = landmarksProjectedImage(1,:);

params = double([offsets; ...
    Rx; Ry; Rz; Tx; Ty; Tz; ]);

func = @(params)differenceFaces(params,spherePosition,sphereRadius, ...
        focalLengthWorldUnits,centreProjectionX,centreProjectionY, ...
        model,landmarkVertNum,landmarksProjectedImage);

ret = lsqnonlin(func,params);

%%% BELOW IS ALL CODE TO DISPLAY

targetVerts = verts.';
targetParams  = object2coef( verts(:), model.shapeMU, model.shapePC, model.shapeEV );

lsqFace  = coef2object( ret(1:199), model.shapeMU, model.shapePC, model.shapeEV );
lsqFace  = reshape(lsqFace, [ 3 prod(size(lsqFace))/3 ])';
lsqFace  = lsqFace.* (1e-03);

lsqFace = lsqFace * rotx(ret(200)) * roty(ret(201)) * rotz(ret(202));

lsqFace(:,1)= lsqFace(:,1)+ret(203);
lsqFace(:,2)= lsqFace(:,2)+ret(204);
lsqFace(:,3)= lsqFace(:,3)+ret(205); 


figure;hold on;
xlabel('X');ylabel('Y');zlabel('Z');axis equal;grid on;

pcshow([verts(:,1) verts(:,2) verts(:,3)]);
pcshow([lsqFace(:,1) lsqFace(:,2) lsqFace(:,3)]);

