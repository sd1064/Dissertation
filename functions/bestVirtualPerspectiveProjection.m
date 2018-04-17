function [ imageRet,landmarks, rotation ] = bestVirtualPerspectiveProjection( image,radius,hFov,vFoV,imageSize,zPlane)

    found = 0;
    possibleRotations = [90:10:270].';
    possibleRotations = [repelem(0,size(possibleRotations,1)).' possibleRotations repelem(0,size(possibleRotations,1)).' ; ...
        repelem(10,size(possibleRotations,1)).' possibleRotations repelem(0,size(possibleRotations,1)).' ; ...
        repelem(20,size(possibleRotations,1)).' possibleRotations repelem(0,size(possibleRotations,1)).' ; ...
        repelem(30,size(possibleRotations,1)).' possibleRotations repelem(0,size(possibleRotations,1)).' ; ...
        repelem(350,size(possibleRotations,1)).' possibleRotations repelem(0,size(possibleRotations,1)).' ; ...
        repelem(340,size(possibleRotations,1)).' possibleRotations repelem(0,size(possibleRotations,1)).' ; ...    
        repelem(330,size(possibleRotations,1)).' possibleRotations repelem(0,size(possibleRotations,1)).' ; ...
    ]; 
    idx = 1;
    
    while found == 0
        [intermediary ]= generateVirtualPerspectiveProjection(image,radius,possibleRotations(idx,1), ...
            possibleRotations(idx,2),possibleRotations(idx,3),hFov,vFoV,imageSize,zPlane);
        intermediary_filtered = intermediary;
        for layer=1:3
            intermediary_filtered(:,:,layer) = wiener2(intermediary(:,:,layer), [5 5]);
        end
        landmarks = detectLandmarks(intermediary_filtered);
        if not(isempty(landmarks))
            figure;imshow(intermediary_filtered);axis equal;hold on;scatter(landmarks(:,1),landmarks(:,2));
            found = input('Found a face (1/0) ?');
            rotation = possibleRotations(idx,:);
            imageRet = intermediary_filtered;
        end
        idx = idx+1;
    end
end