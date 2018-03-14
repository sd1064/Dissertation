function [ image,landmarks, rotation ] = bestVirtualPerspectiveProjection( image,radius,hFov,vFoV,imageSize)

    found = 0;
    possibleRotations = permn([0:15:360],3);
    tested = [];
    while found == 0
        idx = randi([1 size(possibleRotations,1)],1);
        intermediary = generateVirtualPerspectiveProjection(image,radius,possibleRotations(idx,1), ...
            possibleRotations(idx,2),possibleRotations(idx,3),hFov,vFoV,imageSize);
        intermediary_filtered = intermediary;
        for layer=1:3
            intermediary_filtered(:,:,layer) = wiener2(intermediary(:,:,layer), [5 5]);
        end
        landmarks = detectLandmarks(intermediary_filtered);
        if not(isempty(landmarks))
            figure;hold on; image(intermediary_filtered);axis equal;scatter(landmarks(:,1),landmarks(:,2))
            found = 1;
            rotation = possibleRotations(idx,:);
        end
        tested = [tested ; possibleRotations(idx, :)]
        possibleRotations(idx, :) = [];
    end
end