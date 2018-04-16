close all;

finalFace = retTwo;
shpG = coef2object( finalFace(1:numOfParams ), model.shapeMU, model.shapePC, model.shapeEV );

genFace = reshape(shpG, [ 3 prod(size(shpG))/3 ])';
genFace = [genFace(:,1) .* -1 genFace(:,2) genFace(:,3)];
genFace = genFace * (1e-03);
genFace = [rotz(180) * genFace']';
t = [finalFace(numOfParams + 4);finalFace(numOfParams + 5);finalFace(numOfParams + 6)];
genFace = [t + genFace']';
genFace = [rotx(finalFace(numOfParams + 1)) * genFace']';
genFace = [roty(finalFace(numOfParams + 2)) * genFace']';
genFace = [rotz(finalFace(numOfParams + 3)) * genFace']';

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

landMarksGenned = genFace;
% landMarksGenned = getLandmarks(genFace,idx);
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
projectedGenTwo  = perspectiveProjection(sphereReflectionsTwo,k);

figure;imshow(undistortedImage);hold on;axis equal;grid on;
scatter(projectedGenOne(:,1),projectedGenOne(:,2),10,[1,0,0]);
scatter(points2DSphereOneOriginal(:,1),points2DSphereOneOriginal(:,2),10,[0,1,1]);
scatter(projectedGenTwo(:,1),projectedGenTwo(:,2),10,[0,1,0]);
scatter(points2DSphereTwoOriginal(:,1),points2DSphereTwoOriginal(:,2),10,[1,1,0]);

oglp.height =size(undistortedImage,1);
oglp.width = size(undistortedImage,2); 

FV.Vertices  = genFace;
FV.Faces  = model.tl;
FV.edgeColor = 'none';

vertexColour1  = getVertexColours(FV,k,spherePositionOne,oglp,sphereRadius,undistortedImage);
vertexColour2  = getVertexColours(FV,k,spherePositionTwo,oglp,sphereRadius,undistortedImage);
vertexColour = (vertexColour1 + vertexColour2)./2;

b=vertexColour;
zeroRows = all(b == 0, 2);
b(zeroRows, :) = NaN;
FV.FaceVertexCData = b;

test = find(all(not(isnan(FV.FaceVertexCData)),2));
genFaceNew = removerows(genFace,'ind',test);
figure;hold on ; patch(FV,'FaceColor','interp');axis equal;pcshow(genFaceNew);

