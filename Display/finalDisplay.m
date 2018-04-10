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
