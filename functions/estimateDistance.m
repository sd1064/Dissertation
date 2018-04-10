function [ intersection ] = estimateDistance(worldRadius,pixelRadius,point1,point2,spherePos1,spherePos2,zPos)
    
%   sphere 1 
    point1World = sphereReflection(worldRadius,spherePos1,[ point1 zPos]);
    normVector1 = point1World.';
    
%   sphere 2 
    point2World = sphereReflection(worldRadius,spherePos2,[ point1 zPos]);
    normVector2 = point2World.';
    
    intersection = lineIntersect3D([spherePos1; spherePos2], [normVector1;normVector2 ]);
    
    % DEBUG
%     figure;hold on;axis equal;xlabel('x');ylabel('y');zlabel('z');
%     [x,y,z] = sphere;
%     surf(x*worldRadius+spherePos1(1), y*worldRadius+spherePos1(2), z*worldRadius+spherePos1(3),'FaceAlpha',0.1);
%     surf(x*worldRadius+spherePos2(1), y*worldRadius+spherePos2(2), z*worldRadius+spherePos2(3),'FaceAlpha',0.1);
%     
%     scatter3(point1World(1),point1World(2),point1World(3),10);
%     scatter3(point2World(1),point2World(2),point2World(3),10);
%     scatter3(intersection(1),intersection(2),intersection(3),10);
% 
%     plot3([spherePos1(1);normVector1(1)],[spherePos1(2);normVector1(2)],[spherePos1(3);normVector1(3)]);
%     plot3([spherePos2(1);normVector2(1)],[spherePos2(2);normVector2(2)],[spherePos2(3);normVector2(3)]);
% 
%     plotCamera('Location',[0 ; 0 ; 0 ],'Orientation',eye(3),'Size',10);
%     axis equal;grid on;
    
end


