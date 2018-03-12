% Can delete once got actual data 
originalImage  = imread('me.jpg');
originalImage = im2double(originalImage);

[centres,radii] = circleRecognition(originalImage,400,450);

spherePanoramic = [round(sphereOne(1)) round(sphereOne(2)) round(sphereOne(3))];
croppedImage = imcrop(originalImage,[spherePanoramic(1)-spherePanoramic(3) spherePanoramic(2)-spherePanoramic(3) spherePanoramic(3)*2 spherePanoramic(3)*2]);

[image,landmarks,rotation] = bestVirtualPerspectiveProjection(croppedImage,spherePanoramic(3),hFov,vFov,vppImageWidth);
points = unprojectVirtualPerspective(landmarks,rotation,image,hFov,vFov,spherePanoramic(3));