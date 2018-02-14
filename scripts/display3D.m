% OLD CODE
% load('face.mat');
% load('01_MorphableModel.mat','tl');
% verts =  shape.';
% 
% % rotate and offset verts
% %verts(:,1)=
% %verts(:,2)=verts(:,2)+1000000;
% %verts(:,3)=
% 
% fv.Faces = tl;
% fv.Vertices = verts;
% fv.FaceColor = 	[0.5 0.5 0.5];
% fv.EdgeColor = 	'none';
% fv.FaceLighting = 'gouraud';
% 
% figure;
% hold on;
% patch(fv)
% light;
% axis equal;
% camproj('perspective');
% plot3(0,0,0,'g*');%%%

% Generate randoms face and get landmarks
% alpha = randn(sizePC , 1);
% shape  = coef2object( alpha, model.shapeMU, model.shapePC, model.shapeEV );
% gennedShape = reshape(shape, [ 3 prod(size(shape))/3 ])'; 

% Display
% Needs updating

%-------------------------------------------------------------


%figure;hold on;
%pcshow([verts(:,1),verts(:,2),verts(:,3)]);
%xlabel('X');ylabel('Y');zlabel('Z');axis equal;grid on;
%cam = plotCamera('Location',[0 ; 0 ; 0 ],'Orientation',eye(3),'Size',1e4);

%zPos = repelem(F,size(projectedImage,1)).';
%pcshow([projectedImage(:,1),projectedImage(:,2),zPos])

%-------------------------------------------------------------

% Projected image is the input
% Average Face is other input
% Translation is input
% Rx Ry Rz are rotation inputs

% zPos = repelem(focalLengthWorldUnits,size(projectedImage,1)).';
% landmarkVertNum  = landmarks(:,1) +1;
% landmarksProjectedImage = getLandmarks([projectedImage zPos],landmarkVertNum);

% Average model and landmarks
% averageShape = reshape(model.shapeMU, [ 3 prod(size(shape))/3 ])'; 

% ----------------------------------------------------------------
%     avgFace = [ inputVector(206:(206+numLandmarks)) ...
%         inputVector((206+numLandmarks+1):(206+(numLandmarks*2)+1)) ...
%         inputVector((206+(numLandmarks*2)+1+1):(206+(numLandmarks*3)+1+1)) ];
    