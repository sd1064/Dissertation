zPos = repelem(focalLengthWorldUnits,size(points2DSphereOneOriginal,1)).';

global mModel
mModel = model;

translation = estimateDistance(sphereRadius,sphereOne(3),points2DSphereOneOriginal(13,:),points2DSphereTwoOriginal(13,:),...
spherePositionOne,spherePositionTwo,zPos(1));

projectedImageLandmarksSphereOne = [points2DSphereOneOriginal zPos];
projectedImageLandmarksSphereTwo = [points2DSphereTwoOriginal zPos];

% Assume rotation is looking along z direction off camera
Rx = 0; Ry = 0; Rz = 0; 
offsets = repelem(0,numOfParams).';
params = [offsets; double([Rx; Ry; Rz; translation(1); translation(2); translation(3); ])];

funcTwo = @(params)differenceFaces(params,spherePositionOne,spherePositionTwo,sphereRadius, ...
        focalLengthWorldUnits,centreProjectionX,centreProjectionY, ...
        model,projectedImageLandmarksSphereOne,projectedImageLandmarksSphereTwo,numOfParams,idx);
options = optimoptions('lsqnonlin','OutputFcn',@outfun,'Display','iter');
[retTwo,resnorm,residual,exitflag,output] = lsqnonlin(funcTwo,params,[],[],options);

function stop = outfun(x, optimValues, state)
    global mModel;
    model =  mModel;
    inputVector = x;
    shpG = coef2object( inputVector(1:25), model.shapeMU, model.shapePC, model.shapeEV );
    genFace = reshape(shpG, [ 3 prod(size(shpG))/3 ])'; 
    genFace = genFace .* (1e-03);
    genFace = genFace * rotx(inputVector(26)) * roty(inputVector(27)) * rotz(inputVector(28));
    genFace(:,1) = genFace(:,1) + inputVector(29);
    genFace(:,2) = genFace(:,2) + inputVector(30);
    genFace(:,3) = genFace(:,3) + inputVector(31);
    pcshow(genFace);
    close;
    stop = false;
end 