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

cam = plotCamera('Location',[0 ; 0 ; 0 ],'Orientation',eye(3),'Size',40);

% Plot Sphere
pcshow([fvc.vertices(:,1),fvc.vertices(:,2),fvc.vertices(:,3)]);

% Plot Starting Face
pcshow([verts(:,1),verts(:,2),verts(:,3)]);

% Plot LSQ Face
% pcshow([lsqFace(:,1) lsqFace(:,2) (lsqFace(:,3)+leastSquare(205))]);

% Plot ending Face
zPosFace = repelem(focalLengthWorldUnits,size(projectedImage,1)).';
pcshow([projectedImage(:,1),projectedImage(:,2),-zPosFace]);

% Plot sphere projection
zPosSphere = repelem(focalLengthWorldUnits,size(projectedSphere,1)).';
pcshow([projectedSphere(:,1),projectedSphere(:,2),-zPosSphere]);

% Plot image plane
ratio = sphereRadius/sphereOne(1,3);

height = size(undistortedImage,1)/2 * ratio;
width = size(undistortedImage,2)/2 * ratio;
zPosImagePlane = repelem(focalLengthWorldUnits,4).';

X = [-width width width -width];
Y = [height height -height -height];

patch('ZData',-zPosImagePlane,'YData',Y,...
    'XData',X,...
    'FaceAlpha',0.2,...
    'LineWidth',1,...
    'FaceColor',[0.494117647058824 0.184313725490196 0.556862745098039],...
    'EdgeColor',[0.494117647058824 0.184313725490196 0.556862745098039]);

hold off;figure;
pcshow([projectedImage(:,1),projectedImage(:,2),-zPosFace]);