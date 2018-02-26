% Can delete once got actual data 
% [centres,radii] = circleRecognition(originalImage,350,400);
sphereOne = [1505 2120 375];
spherePanoramic = [round(sphereOne(1)) round(sphereOne(2)) round(sphereOne(3))];
%

croppedImage = imcrop(originalImage,[spherePanoramic(1)-spherePanoramic(3) spherePanoramic(2)-spherePanoramic(3) spherePanoramic(3)*2 spherePanoramic(3)*2]);
[image,landmarks,rotation] = bestVirtualPerspectiveProjection(croppedImage,spherePanoramic(3),116,83,300);

% function (takes landmarks,rotation) returns landmarks in original image

