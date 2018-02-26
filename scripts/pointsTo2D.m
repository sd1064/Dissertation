% FacePoint into a sphere reflection point that is then projected


% Eventually these will be landmarks from sphere Undistort

% Translate
verts(:,1)= verts(:,1)+0;
verts(:,2)= verts(:,2)+0;
verts(:,3)= verts(:,3)+500;

% Define sphere
[x,y,z]=ellipsoid(spherePosition(1,1),spherePosition(1,2),spherePosition(1,3),sphereRadius,sphereRadius,sphereRadius,50);
fvc = surf2patch(x, y, z);

sphereReflections = zeros(size(verts));
for i=1:length(verts)  
    sphereReflections(i,:) = sphereReflection(sphereRadius,spherePosition,verts(i,:));
end

projectedImage  = perspectiveProjection(sphereReflections,focalLengthWorldUnits,centreProjectionX,centreProjectionY);
projectedSphere = perspectiveProjection(fvc.vertices,focalLengthWorldUnits,centreProjectionX,centreProjectionY);
