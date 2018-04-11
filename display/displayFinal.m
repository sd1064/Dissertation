finalFace = retTwo;
shpG = coef2object( finalFace(1:25), model.shapeMU, model.shapePC, model.shapeEV );

%AvgFace
genFace = reshape(shpG, [ 3 prod(size(shpG))/3 ])'; 
genFace = genFace .* (1e-03);
genFace = genFace * rotx(finalFace(26)) * roty(finalFace(27)) * rotz(finalFace(28));
genFace(:,1) = genFace(:,1) + finalFace(29);
genFace(:,2) = genFace(:,2) + finalFace(30);
genFace(:,3) = genFace(:,3) + finalFace(31);

figure;hold on;axis equal;grid on;
[x,y,z] = sphere; 
surf(x*sphereRadius+spherePositionOne(1), y*sphereRadius+spherePositionOne(2), z*sphereRadius+spherePositionOne(3));
surf(x*sphereRadius+spherePositionTwo(1), y*sphereRadius+spherePositionTwo(2), z*sphereRadius+spherePositionTwo(3));
cam = plotCamera('Location',[0 ; 0 ; 0 ],'Orientation',eye(3),'Size',10);

pcshow(genFace);

xlabel('X (mm)');
ylabel('Y (mm)');
zlabel('Z (mm)');

figure;hold on;axis equal;grid on;
pcshow(genFace);


% Projections for first sphere
sphereReflectionsOne = zeros(size(genFace));
for i=1:length(genFace)  
    sphereReflectionsOne(i,:) = sphereReflection(sphereRadius,spherePositionOne,genFace(i,:));
end
projectedGenOne  = perspectiveProjection(sphereReflectionsOne,k);

% Projections for second sphere
sphereReflectionsTwo = zeros(size(genFace));
for i=1:length(genFace)  
    sphereReflectionsTwo(i,:) = sphereReflection(sphereRadius,spherePositionTwo,genFace(i,:));
end
projectedGenTwo  = perspectiveProjection(sphereReflectionsTwo,k);

figure;hold on;axis equal;grid on;
scatter3(projectedGenOne(:,1),projectedGenOne(:,2),zeros(size(projectedGenOne,1),1),10,[1,0,0]);
scatter3(projectedGenTwo(:,1),projectedGenTwo(:,2),zeros(size(projectedGenOne,1),1),10,[0,1,0]);
scatter3(projectedGenTwo(:,1),projectedGenTwo(:,2),zeros(size(projectedGenOne,1),1),10,[0,1,0]);
scatter3(projectedGenTwo(:,1),projectedGenTwo(:,2),zeros(size(projectedGenOne,1),1),10,[0,1,0]);
scatter3(landmarksOne(:,1),landmarksOne(:,2),zeros(size(landmarksOne,1),1),10,[1,1,0]);
scatter3(landmarksTwo(:,1),landmarksTwo(:,2),zeros(size(landmarksOne,1),1),10,[1,1,0]);
