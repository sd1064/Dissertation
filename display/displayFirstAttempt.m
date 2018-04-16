inputVector = retOne;
shpG = coef2object( zeros(numOfParams ,1), model.shapeMU, model.shapePC, model.shapeEV );
genFace = reshape(shpG, [ 3 prod(size(shpG))/3 ])';
genFace = [genFace(:,1) .* -1 genFace(:,2) genFace(:,3)];
genFace = genFace * (1e-03);
genFace = [rotz(180) * genFace']';
t = [inputVector(4);inputVector(5);inputVector(6)];
genFace = [t + genFace']';
genFace = [rotx(inputVector(1)) * genFace']';
genFace = [roty(inputVector(2)) * genFace']';
genFace = [rotz(inputVector(3)) * genFace']';

figure;hold on;axis equal;grid on;
[x,y,z] = sphere; 
surf(x*sphereRadius+spherePositionOne(1), y*sphereRadius+spherePositionOne(2), z*sphereRadius+spherePositionOne(3));
surf(x*sphereRadius+spherePositionTwo(1), y*sphereRadius+spherePositionTwo(2), z*sphereRadius+spherePositionTwo(3));
cam = plotCamera('Location',[0 ; 0 ; 0 ],'Orientation',eye(3),'Size',10);

pcshow(genFace);

xlabel('X (mm)');
ylabel('Y (mm)');
zlabel('Z (mm)');

% Projections for first sphere
landMarksGenned = getLandmarks(genFace,idx);

% Projections for first sphere
sphereReflectionsOne = zeros(size(landMarksGenned));
for i=1:length(landMarksGenned)  
    sphereReflectionsOne(i,:) = sphereReflection(sphereRadius,spherePositionOne,landMarksGenned(i,:));
end
projectedGenOne  = perspectiveProjection(sphereReflectionsOne,k);

% Projections for second sphere
sphereReflectionsTwo = zeros(size(landMarksGenned));
for i=1:length(landMarksGenned)  
    sphereReflectionsTwo(i,:) = sphereReflection(sphereRadius,spherePositionTwo,landMarksGenned(i,:));
end
projectedGenTwo = perspectiveProjection(sphereReflectionsTwo,k); 
 
figure;imshow(undistortedImage);hold on;axis equal;grid on;
scatter(projectedGenOne(:,1),projectedGenOne(:,2),10,[1,0,0]);
scatter(points2DSphereOneOriginal(:,1),points2DSphereOneOriginal(:,2),10,[0,1,1]);
scatter(projectedGenTwo(:,1),projectedGenTwo(:,2),10,[0,1,0]);
scatter(points2DSphereTwoOriginal(:,1),points2DSphereTwoOriginal(:,2),10,[1,1,0]);

a = [1:(size(projectedGenOne,1))]'; b = num2str(a); c = cellstr(b);
dx = 0.1; dy = 0.1; % displacement so the text does not overlay the data points
text(projectedGenOne(:,1)+dx, projectedGenOne(:,2)+dy, c);
text(points2DSphereOneOriginal(:,1)+dx, points2DSphereOneOriginal(:,2)+dy, c);
text(projectedGenTwo(:,1)+dx, projectedGenTwo(:,2)+dy, c);
text(points2DSphereTwoOriginal(:,1)+dx, points2DSphereTwoOriginal(:,2)+dy, c);

