function [outputVector] = differenceFaces(inputVector,spherePositionOne,spherePositionTwo,sphereRadius, ...
                          k,model,projectedFaceOne,projectedFaceTwo,numOfParams,idx)

    if size(inputVector,2)==(numOfParams+6)
        inputVector = inputVector.';
    end
    
    shapeMu = double(model.shapeMU);
    shapePc = double(model.shapePC);
    shapeEv = double(model.shapeEV);
    offsets = inputVector(1:numOfParams); 
    Rx = inputVector(numOfParams+1); Ry = inputVector(numOfParams+2); Rz = inputVector(numOfParams+3);
    Tx = inputVector(numOfParams+4); Ty = inputVector(numOfParams+5); Tz = inputVector(numOfParams+6);
    t = [Tx;Ty;Tz];
        
    shape  = coef2object( offsets, shapeMu, shapePc, shapeEv );
    genFace = reshape(shape, [ 3 prod(size(shape))/3 ])';
    genFace = [genFace(:,1) .* -1 genFace(:,2) genFace(:,3)];
    genFace = genFace * (1e-03);
    genFace = [rotz(180) * genFace']';
    genFace = [t + genFace']';
    genFace = [rotx(Rx) * genFace']';
    genFace = [roty(Ry) * genFace']';
    genFace = [rotz(Rz) * genFace']';
    
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
    projectedGenTwo = perspectiveProjection(sphereReflectionsTwo,k);

    outputVector = [projectedFaceOne(:)-projectedGenOne(:);projectedFaceTwo(:)-projectedGenTwo(:)];

%   SD offsets
    offsetSD = offsets ./ shapeEv(1:numOfParams,:);
    outputVector = [outputVector;offsetSD];
end

