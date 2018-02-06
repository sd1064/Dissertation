% FacePoint into a sphere reflection point that is then projected

load('face.mat','shape');
load('01_MorphableModel.mat','tl');

verts = shape.';
% Convert from micro meters to milli
verts = verts .* (1e-03);
% Translate
verts(:,1)= verts(:,1)+500; 
verts(:,3)= verts(:,3)+500; 

sphereReflections = zeros(size(verts));
for i=1:length(verts)  
    sphereReflections(i,:) = sphereReflection(sphereRadius,spherePosition,verts(i,:));
end

% Need to query - centre off projection
% Use as 0 as where camera is 
% Use as pixel values e.g 2000, 2000 ???? 

centreProjectionX = 0;
centreProjectionY = 0;

projectedImage = perspectiveProjection(verts,focalLengthWorldUnits,centreProjectionX,centreProjectionY);
