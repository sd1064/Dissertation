global mModel; mModel = model;
global sphereRadius; sphereRadius=sphereRadius;
global spherePositionOne;spherePositionOne=spherePositionOne;
global spherePositionTwo;spherePositionTwo=spherePositionTwo;
global k; k = cameraParams.IntrinsicMatrix;
global landmarksOne;landmarksOne = points2DSphereOneOriginal;
global landmarksTwo;landmarksTwo = points2DSphereTwoOriginal;

k = cameraParams.IntrinsicMatrix;
translation = estimateDistance(sphereRadius,points2DSphereOneOriginal,points2DSphereTwoOriginal,...
spherePositionOne,spherePositionTwo,k);
Rx = 0; Ry = 0; Rz = 0;

params = double([Rx; Ry; Rz; translation(1); translation(2); translation(3); ]);
funcOne = @(params)differenceFacesTranslationRotation(params,spherePositionOne,spherePositionTwo,sphereRadius, ...
        k,model,points2DSphereOneOriginal,points2DSphereTwoOriginal,numOfParams,idx);
options = optimoptions('lsqnonlin','OutputFcn',@outfunRT,'Display','iter');
[retOne,resnorm,residual,exitflag,output] = lsqnonlin(funcOne,params,[],[],options);

displayFirstAttempt;

offsets = repelem(0,numOfParams).';
params = [offsets; retOne];
funcTwo = @(params)differenceFaces(params,spherePositionOne,spherePositionTwo,sphereRadius, ...
        k,model,points2DSphereOneOriginal,points2DSphereTwoOriginal,numOfParams,idx);
options = optimoptions('lsqnonlin','OutputFcn',@outfun,'Display','iter');
[retTwo,resnorm,residual,exitflag,output] = lsqnonlin(funcTwo,params,[],[],options);

displayFinal;

function stop = outfun(x, optimValues, state)
    global mModel; global sphereRadius; global spherePositionOne;global spherePositionTwo;
    global k;global landmarksOne;global landmarksTwo;
    model =  mModel;
    
    inputVector = x;
    shpG = coef2object( inputVector(1:25), model.shapeMU, model.shapePC, model.shapeEV );
    genFace = reshape(shpG, [ 3 prod(size(shpG))/3 ])'; 
    genFace = genFace .* (1e-03);
    genFace = genFace * rotx(inputVector(26)) * roty(inputVector(27)) * rotz(inputVector(28));
    genFace(:,1) = genFace(:,1) + inputVector(29);
    genFace(:,2) = genFace(:,2) + inputVector(30);
    genFace(:,3) = genFace(:,3) + inputVector(31);
    
    figure;hold on;axis equal;grid on;
    [x,y,z] = sphere; 
    surf(x*sphereRadius+spherePositionOne(1), y*sphereRadius+spherePositionOne(2), z*sphereRadius+spherePositionOne(3));
    surf(x*sphereRadius+spherePositionTwo(1), y*sphereRadius+spherePositionTwo(2), z*sphereRadius+spherePositionTwo(3));
    cam = plotCamera('Location',[0 ; 0 ; 0 ],'Orientation',eye(3),'Size',10);
    pcshow(genFace);
    
    xlabel('X (mm)');
    ylabel('Y (mm)');
    zlabel('Z (mm)');
    
    % Projections for first sphere
    sphereReflectionsOne = zeros(size(genFace));
    for i=1:length(genFace)  
        sphereReflectionsOne(i,:) = sphereReflection(sphereRadius,spherePositionOne,genFace(i,:));
    end
    projectedGenOne  = perspectiveProjection(sphereReflectionsOne,k);

    % Projections for second sphere
    sphereReflectionsTwo = zeros(size(genFace));
    for i=1:length(genFace)  
        sphereReflectionsTwo(i,:) = sphereReflection(sphereRadius,spherePositionTwo,genFace(i,:));
    end
    projectedGenTwo  = perspectiveProjection(sphereReflectionsTwo,k);
    
    figure;hold on;axis equal;grid on;
    scatter3(projectedGenOne(:,1),projectedGenOne(:,2),zeros(size(projectedGenOne,1),1),10,[1,0,0]);
    scatter3(projectedGenTwo(:,1),projectedGenTwo(:,2),zeros(size(projectedGenOne,1),1),10,[0,1,0]);
    scatter3(projectedGenTwo(:,1),projectedGenTwo(:,2),zeros(size(projectedGenOne,1),1),10,[0,1,0]);
    scatter3(projectedGenTwo(:,1),projectedGenTwo(:,2),zeros(size(projectedGenOne,1),1),10,[0,1,0]);
    scatter3(landmarksOne(:,1),landmarksOne(:,2),zeros(size(landmarksOne,1),1),10,[1,1,0]);
    scatter3(landmarksTwo(:,1),landmarksTwo(:,2),zeros(size(landmarksOne,1),1),10,[1,1,0]);
    
    figure;hold on;axis equal;grid on;
    pcshow(genFace);
    
    close all;
    stop = false;
end 

function stop = outfunRT(x, optimValues, state)
    global mModel; global sphereRadius; global spherePositionOne;global spherePositionTwo;
    global k;global landmarksOne;global landmarksTwo;
    
    model =  mModel;
    
    inputVector = x;
    shpG = coef2object( zeros(25,1), model.shapeMU, model.shapePC, model.shapeEV );
    genFace = reshape(shpG, [ 3 prod(size(shpG))/3 ])'; 
    genFace = genFace .* (1e-03);
    genFace = genFace * rotx(inputVector(1)) * roty(inputVector(2)) * rotz(inputVector(3));
    genFace(:,1) = genFace(:,1) + inputVector(4);
    genFace(:,2) = genFace(:,2) + inputVector(5);
    genFace(:,3) = genFace(:,3) + inputVector(6);
    
    figure;hold on;axis equal;grid on;
    [x,y,z] = sphere; 
    surf(x*sphereRadius+spherePositionOne(1), y*sphereRadius+spherePositionOne(2), z*sphereRadius+spherePositionOne(3));
    surf(x*sphereRadius+spherePositionTwo(1), y*sphereRadius+spherePositionTwo(2), z*sphereRadius+spherePositionTwo(3));
    cam = plotCamera('Location',[0 ; 0 ; 0 ],'Orientation',eye(3),'Size',10);
    pcshow(genFace);
    
    % Projections for first sphere
    sphereReflectionsOne = zeros(size(genFace));
    for i=1:length(genFace)  
        sphereReflectionsOne(i,:) = sphereReflection(sphereRadius,spherePositionOne,genFace(i,:));
    end
    projectedGenOne  = perspectiveProjection(sphereReflectionsOne,k);

    % Projections for second sphere
    sphereReflectionsTwo = zeros(size(genFace));
    for i=1:length(genFace)  
        sphereReflectionsTwo(i,:) = sphereReflection(sphereRadius,spherePositionTwo,genFace(i,:));
    end
    projectedGenTwo  = perspectiveProjection(sphereReflectionsTwo,k);
    
    figure;hold on;axis equal;grid on;
    scatter3(projectedGenOne(:,1),projectedGenOne(:,2),zeros(size(projectedGenOne,1),1),10,[1,0,0]);
    scatter3(projectedGenTwo(:,1),projectedGenTwo(:,2),zeros(size(projectedGenOne,1),1),10,[0,1,0]);
    scatter3(projectedGenTwo(:,1),projectedGenTwo(:,2),zeros(size(projectedGenOne,1),1),10,[0,1,0]);
    scatter3(projectedGenTwo(:,1),projectedGenTwo(:,2),zeros(size(projectedGenOne,1),1),10,[0,1,0]);
    scatter3(landmarksOne(:,1),landmarksOne(:,2),zeros(size(landmarksOne,1),1),10,[1,1,0]);
    scatter3(landmarksTwo(:,1),landmarksTwo(:,2),zeros(size(landmarksOne,1),1),10,[1,1,0]);

    close all;
    stop = false;
end 
