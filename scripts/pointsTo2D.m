
points3DsphereOne = initialEstimate(points2DSphereOne);
sphereReflectionsOne = zeros(size(points3DsphereOne));
for i=1:length(points3DsphereOne)  
    sphereReflectionsOne(i,:) = sphereReflection(sphereRadius,spherePositionOne,points3DsphereOne(i,:));
end
projectedImageLandmarksSphereOne = perspectiveProjection(sphereReflectionsOne,focalLengthWorldUnits,centreProjectionX,centreProjectionY);

points3DsphereTwo = initialEstimate(points2DSphereTwo);
sphereReflectionsTwo = zeros(size(points3DsphereTwo));
for i=1:length(points3DsphereTwo)  
    sphereReflectionsTwo(i,:) = sphereReflection(sphereRadius,spherePositionTwo,points3DsphereTwo(i,:));
end
projectedImageLandmarksSphereTwo = perspectiveProjection(sphereReflectionsTwo,focalLengthWorldUnits,centreProjectionX,centreProjectionY);
