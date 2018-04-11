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

    % Generate an aberage face and apply rotation translation
    shape  = coef2object( offsets, shapeMu, shapePc, shapeEv );
    genFace = reshape(shape, [ 3 prod(size(shape))/3 ])'; 
    genFace = genFace .* (1e-03);
    genFace=genFace * rotx(Rx) * roty(Ry) * rotz(Rz);
    genFace(:,1) = genFace(:,1) + Tx;
    genFace(:,2) = genFace(:,2) + Ty;
    genFace(:,3) = genFace(:,3) + Tz;
    
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

    outputVector = [];
    for i=1:length(projectedGenOne)
        outputVector = [outputVector; norm(projectedFaceOne(i,:) - projectedGenOne(i,:))];
    end
    
    for i=1:length(projectedGenTwo)
        outputVector = [outputVector; norm(projectedFaceTwo(i,:) - projectedGenTwo(i,:))];
    end
    
end

