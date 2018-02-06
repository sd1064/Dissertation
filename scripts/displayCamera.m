% X = [outputOne(1,1);outputTwo(1,1)];
% Y = [outputOne(1,2);outputTwo(1,2)];
% Z = [outputOne(1,3);outputTwo(1,3)];
% 
% figure;hold on;axis equal;grid on;
% plot3(X,Y,Z,'g*');
% 
% view([-180 90])
% 
% cam = plotCamera('Location',[0 ; 0 ; 0 ],'Orientation',eye(3),'Size',20);
% 
% 
% xlabel('X (mm)');
% ylabel('Y (mm)');
% zlabel('Z (mm)');
% 
% txt1 = 'Sphere One';
% txt2 = 'Sphere Two';
% 
% text(outputOne(1,1),outputOne(1,2),outputOne(1,3),txt1);
% text(outputTwo(1,1),outputTwo(1,2),outputTwo(1,3),txt1);

% Create a figure
% Plot a camera at 0,0,0

% Do some averaging for better display
% e.g only keep every 4th entry in point clouds

figure;hold on;
xlabel('X');ylabel('Y');zlabel('Z');axis equal;grid on;

cam = plotCamera('Location',[0 ; 0 ; 0 ],'Orientation',eye(3),'Size',100);
% Plot Sphere
r=53;
[x,y,z]=ellipsoid(spherePosition(1,1),spherePosition(1,2),spherePosition(1,3),r,r,r,10);
surf(x, y, z);
% Plot Starting Face
pcshow([verts(:,1),verts(:,2),verts(:,3)]);
% Plot ending Face
zPos = repelem(focalLengthWorldUnits,size(projectedImage,1)).';
pcshow([projectedImage(:,1),projectedImage(:,2),-zPos]);

hold off;figure;
pcshow([projectedImage(:,1),projectedImage(:,2),-zPos]);