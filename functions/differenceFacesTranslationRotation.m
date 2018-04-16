function [outputVector] = differenceFacesTranslationRotation(inputVector,spherePositionOne,spherePositionTwo,sphereRadius, ...
                          k,model,projectedFaceOne,projectedFaceTwo,numOfParams,idx)

    % projectedFace is the known Face
    % AvgFace is the face that will be used to fit to the known face
    
    shapeMu = double(model.shapeMU);
    shapePc = double(model.shapePC);
    shapeEv = double(model.shapeEV);
    offsets = zeros(1,numOfParams).'; 
    
    Rx = inputVector(1); Ry = inputVector(2); Rz = inputVector(3);
    Tx = inputVector(4); Ty = inputVector(5); Tz = inputVector(6);
    t = [Tx;Ty;Tz];
    
    % Generate an aberage face and apply rotation translation
    shape  = coef2object( offsets, shapeMu, shapePc, shapeEv );
    genFace = reshape(shape, [ 3 prod(size(shape))/3 ])';
    genFace = [genFace(:,1) .* -1 genFace(:,2) genFace(:,3)];
    genFace = genFace * (1e-03);
    genFace = [rotz(180) * genFace']';
    genFace = [t + genFace']';
    genFace = [rotx(Rx) * genFace']';
    genFace = [roty(Ry) * genFace']';
    genFace = [rotz(Rz) * genFace']';
    
    % Get landmarks
    landMarksGenned = getLandmarks(genFace,idx);

    % Projections for first sphere
    sphereReflectionsOne = zeros(size(landMarksGenned));
    for i=1:length(landMarksGenned)  
        sphereReflectionsOne(i,:) = sphereReflection(sphereRadius,spherePositionOne,landMarksGenned(i,:));
    end
    projectedGenOne  = perspectiveProjection(sphereReflectionsOne,k);

    % Projections for second sphere
    sphereReflectionsTwo = zeros(size(landMarksGenned));
    for i=1:length(landMarksGenned)  
        sphereReflectionsTwo(i,:) = sphereReflection(sphereRadius,spherePositionTwo,landMarksGenned(i,:));
    end
    projectedGenTwo  = perspectiveProjection(sphereReflectionsTwo,k);
    
    outputVector = [projectedFaceOne(:)-projectedGenOne(:) ;projectedFaceTwo(:)-projectedGenTwo(:)];
    
end

