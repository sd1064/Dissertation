inputVector = retOne;
shpG = coef2object( zeros(25,1), model.shapeMU, model.shapePC, model.shapeEV );
genFace = reshape(shpG, [ 3 prod(size(shpG))/3 ])'; 
genFace = genFace .* (1e-03);
genFace = genFace * rotx(inputVector(1)) * roty(inputVector(2)) * rotz(inputVector(3));
genFace(:,1) = genFace(:,1) + inputVector(4);
genFace(:,2) = genFace(:,2) + inputVector(5);
genFace(:,3) = genFace(:,3) + inputVector(6);

figure;hold on;axis equal;grid on;
[x,y,z] = sphere; 
surf(x*sphereRadius+spherePositionOne(1), y*sphereRadius+spherePositionOne(2), z*sphereRadius+spherePositionOne(3));
surf(x*sphereRadius+spherePositionTwo(1), y*sphereRadius+spherePositionTwo(2), z*sphereRadius+spherePositionTwo(3));
cam = plotCamera('Location',[0 ; 0 ; 0 ],'Orientation',eye(3),'Size',10);

pcshow(genFace);

xlabel('X (mm)');
ylabel('Y (mm)');
zlabel('Z (mm)');