function [outputVector] = differenceFaces(inputVector,spherePosition,sphereRadius, ...
                          focalLengthWorldUnits,centreProjectionX,centreProjectionY, ...
                          model,landmarkVertNum,projectedFace)

    % projectedFace is the known Face
    % AvgFace is the face that will be used to fit to the known face
    
    outputVector = zeros(70,1);
    
    offsets = inputVector(1:199); 
    Rx = inputVector(200); Ry = inputVector(201); Rz = inputVector(202);
    Tx = inputVector(203); Ty = inputVector(204); Tz = inputVector(205);
       
    % Generate a face using offsets
    shape  = coef2object( offsets, model.shapeMU, model.shapePC, model.shapeEV );
    genFace = reshape(shape, [ 3 prod(size(shape))/3 ])'; 
    genFace = genFace .* (1e-03);
    
    % apply rotation
    genFace=genFace * rotx(Rx) * roty(Ry) * rotz(Rz);
    
    % apply translation
    genFace(:,1) = genFace(:,1) + Tx;
    genFace(:,2) = genFace(:,2) + Ty;
    genFace(:,3) = genFace(:,3) + Tz;
    
    landMarksGenned = getLandmarks(genFace,landmarkVertNum);
    sphereReflections = zeros(size(genFace));
    
    for i=1:length(landMarksGenned)  
        sphereReflections(i,:) = sphereReflection(sphereRadius,spherePosition,landMarksGenned(i,:));
    end
    
    projectedGen  = perspectiveProjection(sphereReflections,focalLengthWorldUnits,centreProjectionX,centreProjectionY);
    projectedGen = [projectedGen repelem(focalLengthWorldUnits,size(projectedGen,1)).'];
    
    for i=1:length(outputVector)
        outputVector(i,1) = norm(projectedFace(i,:) - projectedGen(i,:));
    end

end

