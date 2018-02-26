function [outputVector] = differenceFaces(inputVector,spherePosition,sphereRadius, ...
                          focalLengthWorldUnits,centreProjectionX,centreProjectionY, ...
                          model,projectedFace,numOfParams,idx)

    % projectedFace is the known Face
    % AvgFace is the face that will be used to fit to the known face
    
    shapeMu = double(model.shapeMU);
    shapePc = double(model.shapePC);
    shapeEv = double(model.shapeEV);
    
    outputVector = zeros(1,1);
   
    offsets = inputVector(1:numOfParams); 
    
    Rx = inputVector(numOfParams+1); Ry = inputVector(numOfParams+2); Rz = inputVector(numOfParams+3);
    Tx = inputVector(numOfParams+4); Ty = inputVector(numOfParams+5); Tz = inputVector(numOfParams+6);

    % Generate a face using offsets
    shape  = coef2object( offsets, shapeMu, shapePc, shapeEv );
    genFace = reshape(shape, [ 3 prod(size(shape))/3 ])'; 
    genFace = genFace .* (1e-03);
    
    % apply rotation
    genFace=genFace * rotx(Rx) * roty(Ry) * rotz(Rz);
    
    % apply translation
    genFace(:,1) = genFace(:,1) + Tx;
    genFace(:,2) = genFace(:,2) + Ty;
    genFace(:,3) = genFace(:,3) + Tz;
    
    landMarksGenned = getLandmarks(genFace,idx);
    
    % At the moment always use all landmarks 
    % This could do with being smarter
    landMarksGenned = landMarksGenned(1:size(projectedFace,1),:);
    
    sphereReflections = zeros(size(landMarksGenned));
    
    for i=1:length(landMarksGenned)  
        sphereReflections(i,:) = sphereReflection(sphereRadius,spherePosition,landMarksGenned(i,:));
    end

    projectedGen  = perspectiveProjection(sphereReflections,focalLengthWorldUnits,centreProjectionX,centreProjectionY);
    projectedGen = [projectedGen repelem(focalLengthWorldUnits,size(projectedGen,1)).'];

    for i=1:length(outputVector)
        outputVector(i,1) = norm(projectedFace(i,:) - projectedGen(i,:));
    end
    
    offsetSD = offsets ./ shapeEv(1:numOfParams,:);
    outputVector = [outputVector ; offsetSD];
end

