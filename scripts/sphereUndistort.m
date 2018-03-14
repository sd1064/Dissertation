sphereOneRounded = [round(sphereOne(1)) round(sphereOne(2)) round(sphereOne(3))];
sphereTwoRounded = [round(sphereTwo(1)) round(sphereTwo(2)) round(sphereTwo(3))];

% Sphere One
croppedImageSphereOne = imcrop(originalImage,[sphereOneRounded(1)-sphereOneRounded(3) sphereOneRounded(2)-sphereOneRounded(3) sphereOneRounded(3)*2 sphereOneRounded(3)*2]);
[imageSphereOne,landmarksSphereOne,rotationSphereOne] = bestVirtualPerspectiveProjection(croppedImageSphereOne,sphereOneRounded(3),hFov,vFov,400);
points2DSphereOne = unprojectVirtualPerspective(landmarksSphereOne,rotationSphereOne,imageSphereOne,hFov,vFov,sphereOneRounded(3));

% Sphere Two
croppedImageSphereTwo = imcrop(originalImage,[sphereTwoRounded(1)-sphereTwoRounded(3) sphereTwoRounded(2)-sphereTwoRounded(3) sphereTwoRounded(3)*2 sphereTwoRounded(3)*2]);
[imageSphereTwo,landmarksSphereTwo,rotationSphereTwo] = bestVirtualPerspectiveProjection(croppedImageSphereTwo,sphereTwoRounded(3),hFov,vFov,400);
points2DSphereTwo = unprojectVirtualPerspective(landmarksSphereTwo,rotationSphereTwo,imageSphereTwo,hFov,vFov,sphereTwoRounded(3));

% Convert back to regular image coordinates
points2DSphereOneOriginal = convertToOriginal([sphereOneRounded(1)-sphereOneRounded(3) sphereOneRounded(2)-sphereOneRounded(3)],points2DSphereOne);
points2DSphereTwoOriginal = convertToOriginal([sphereTwoRounded(1)-sphereTwoRounded(3) sphereTwoRounded(2)-sphereTwoRounded(3)],points2DSphereTwo);