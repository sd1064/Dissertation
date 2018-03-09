% Can delete once got actual data 
% [centres,radii] = circleRecognition(originalImage,350,400);
originalImage  = imread('ParkAngularMap-800.jpg');
originalImage = im2double(originalImage);

sphereOne = [400 400 400];
spherePanoramic = [round(sphereOne(1)) round(sphereOne(2)) round(sphereOne(3))];

croppedImage = imcrop(originalImage,[spherePanoramic(1)-spherePanoramic(3) spherePanoramic(2)-spherePanoramic(3) spherePanoramic(3)*2 spherePanoramic(3)*2]);
% [image,landmarks,rotation] = bestVirtualPerspectiveProjection(croppedImage,spherePanoramic(3),116,83,300);

% JUST FOR TESTING
% TARGET IS BASE OF TALLEST TREE
rotation = [90 90 0];
working = generateVirtualPerspectiveProjection( croppedImage,spherePanoramic(3) ...
    ,rotation(1,1),rotation(1,2),rotation(1,3),116,83,300 );

imshow(working)
% IN X AND Y NOT ROW AND COL
landmarks = [131,106]; 

points = unprojectVirtualPerspective(landmarks,rotation,working,116,83);