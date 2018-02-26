function [ image,landmarks, rotation ] = bestVirtualPerspectiveProjection( image,radius,hFov,vFoV,imageSize)

    found = 0;
    possibleRotations = [0 90 180 270];
    while found == 0
        rx = possibleRotations(randi([1 4],1));
        ry = possibleRotations(randi([1 4],1));
        rz = possibleRotations(randi([1 4],1));
        
        intermediary = generateVirtualPerspectiveProjection(image,radius,rx,ry,rz,hFov,vFoV,imageSize);

        landmarks = detectLandmarks(intermediary);
        if not(isempty(landmarks))
            found = 1;
            rotation = [rx ry rz];
        end     
    end
end