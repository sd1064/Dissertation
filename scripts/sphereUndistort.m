sphereOneRounded = round(sphereOne);
sphereTwoRounded = round(sphereTwo);

croppedImageSphereOne = imcrop(undistortedImage,[sphereOneRounded(1)-sphereOneRounded(3) sphereOneRounded(2)-sphereOneRounded(3) sphereOneRounded(3)*2 sphereOneRounded(3)*2]);
[imageSphereOne,landmarksSphereOne,rotationSphereOne,uv] = bestVirtualPerspectiveProjection(croppedImageSphereOne,sphereOneRounded(3),hFov,vFov,vppImageWidth,zPlane);
points2DSphereOne = unprojectVirtualPerspective(landmarksSphereOne,rotationSphereOne,imageSphereOne,hFov,vFov,sphereOneRounded(3),zPlane,sphereOneRounded);
points2DSphereOneOriginal = convertToOriginal([sphereOneRounded(1)-sphereOneRounded(3) sphereOneRounded(2)-sphereOneRounded(3)],points2DSphereOne);

croppedImageSphereTwo = imcrop(undistortedImage,[sphereTwoRounded(1)-sphereTwoRounded(3) sphereTwoRounded(2)-sphereTwoRounded(3) sphereTwoRounded(3)*2 sphereTwoRounded(3)*2]);
[imageSphereTwo,landmarksSphereTwo,rotationSphereTwo] = bestVirtualPerspectiveProjection(croppedImageSphereTwo,sphereTwoRounded(3),hFov,vFov,vppImageWidth,zPlane);
points2DSphereTwo = unprojectVirtualPerspective(landmarksSphereTwo,rotationSphereTwo,imageSphereTwo,hFov,vFov,sphereTwoRounded(3),zPlane,sphereTwoRounded);
points2DSphereTwoOriginal = convertToOriginal([sphereTwoRounded(1)-sphereTwoRounded(3) sphereTwoRounded(2)-sphereTwoRounded(3)],points2DSphereTwo);

% IMAGE
figure;imshow(imageSphereOne);axis equal;hold on;scatter(landmarksSphereOne(:,1),landmarksSphereOne(:,2));
figure;imshow(croppedImageSphereOne);axis equal;hold on;scatter(points2DSphereOne(:,1),points2DSphereOne(:,2));

figure;imshow(imageSphereTwo);axis equal;hold on;scatter(landmarksSphereTwo(:,1),landmarksSphereTwo(:,2));
figure;imshow(croppedImageSphereTwo);axis equal;hold on;scatter(points2DSphereTwo(:,1),points2DSphereTwo(:,2));

figure;imshow(undistortedImage);axis equal;hold on;scatter([points2DSphereOneOriginal(:,1);points2DSphereTwoOriginal(:,1)],[points2DSphereOneOriginal(:,2);points2DSphereTwoOriginal(:,2)]);
