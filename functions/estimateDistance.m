function [ intersection ] = estimateDistance(worldRadius,points1,points2,spherePos1,spherePos2,k)
    
    scaleFactor = 1000;
    fx = k(1,1);
    fy = k(1,1);
    cx = k(3,1);
    cy = k(3,2);
    
    endPoints1 = [];
    endPoints2 = [];
    
    for i=1:length(points1)
        
        point1 = points1(i,:);
        point1 = [(point1-cx)/fx 0 ];
        point1World = sphereReflection(worldRadius,spherePos1,point1);
        vector1 = point1World.' - spherePos1;
        normVector1 = scaleFactor *  vector1/norm(vector1);
        endPoint1 = normVector1 + spherePos1;
        endPoints1 = [endPoints1;endPoint1];
        
        point2 = points2(i,:);
        point2 = [(point2-cy)/fy 0 ];
        point2World = sphereReflection(worldRadius,spherePos2,point2);
        vector2 = point2World.' - spherePos2;
        normVector2 = scaleFactor *  vector2/norm(vector2);
        endPoint2 = normVector2 + spherePos2;
        endPoints2 = [endPoints2;endPoint2];
        
    end
    
    spherePos = [repmat(spherePos1,size(endPoints1,1),1);repmat(spherePos2,size(endPoints2,1),1)];
    intersection = lineIntersect3D(spherePos,[endPoints1;endPoints2 ]);
    
    % DEBUG
%     figure;hold on;axis equal;xlabel('x');ylabel('y');zlabel('z');
%     [x,y,z] = sphere;
%     
%     surf(x*worldRadius+spherePos1(1), y*worldRadius+spherePos1(2), z*worldRadius+spherePos1(3),'FaceAlpha',0.1);
%     surf(x*worldRadius+spherePos2(1), y*worldRadius+spherePos2(2), z*worldRadius+spherePos2(3),'FaceAlpha',0.1);
%     
%     scatter3(endPoints1(:,1),endPoints1(:,2),endPoints1(:,3),50);
%     scatter3(endPoints2(:,1),endPoints2(:,2),endPoints2(:,3),50);
%     
%     scatter3(spherePos1(1),spherePos1(2),spherePos1(3),50);
%     scatter3(spherePos2(1),spherePos2(2),spherePos2(3),50);
%     
%     scatter3(intersection(1),intersection(2),intersection(3),50);
% 
%     plot3([spherePos1(1);endPoint1(1)],[spherePos1(2);endPoint1(2)],[spherePos1(3);endPoint1(3)]);
%     plot3([spherePos2(1);endPoint2(1)],[spherePos2(2);endPoint2(2)],[spherePos2(3);endPoint2(3)]);
% 
%     plotCamera('Location',[0 ; 0 ; 0 ],'Orientation',eye(3),'Size',10);
%     axis equal;grid on;
    
end


