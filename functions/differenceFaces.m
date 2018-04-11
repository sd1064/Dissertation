function [outputVector] = differenceFaces(inputVector,spherePositionOne,spherePositionTwo,sphereRadius, ...
                          k,model,projectedFaceOne,projectedFaceTwo,numOfParams,idx)

    % projectedFace is the known Face
    % AvgFace is the face that will be used to fit to the known face
    
    shapeMu = double(model.shapeMU);
    shapePc = double(model.shapePC);
    shapeEv = double(model.shapeEV);
    offsets = inputVector(1:numOfParams); 
    Rx = inputVector(numOfParams+1); Ry = inputVector(numOfParams+2); Rz = inputVector(numOfParams+3);
    Tx = inputVector(numOfParams+4); Ty = inputVector(numOfParams+5); Tz = inputVector(numOfParams+6);

    % Generate a face using offsets
    shape  = coef2object( offsets, shapeMu, shapePc, shapeEv );
    genFace = reshape(shape, [ 3 prod(size(shape))/3 ])'; 
    genFace = genFace .* (1e-03);
    
    % apply rotation and translation
    genFace=genFace * rotx(Rx) * roty(Ry) * rotz(Rz);
    genFace(:,1) = genFace(:,1) + Tx;
    genFace(:,2) = genFace(:,2) + Ty;
    genFace(:,3) = genFace(:,3) + Tz;
    
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
    
    % calculate output vector
    outputVector = [];
    for i=1:length(projectedGenOne)
        outputVector = [outputVector; norm(projectedFaceOne(i,:) - projectedGenOne(i,:))];
    end
    
    for i=1:length(projectedGenTwo)
        outputVector = [outputVector; norm(projectedFaceTwo(i,:) - projectedGenTwo(i,:))];
    end
    
%     SD of offsets
    offsetSD = offsets ./ shapeEv(1:numOfParams,:);
    outputVector = [outputVector;offsetSD];
end

