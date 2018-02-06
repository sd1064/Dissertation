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


% Display
% Needs updating

%figure;hold on;
%pcshow([verts(:,1),verts(:,2),verts(:,3)]);
%xlabel('X');ylabel('Y');zlabel('Z');axis equal;grid on;
%cam = plotCamera('Location',[0 ; 0 ; 0 ],'Orientation',eye(3),'Size',1e4);

%zPos = repelem(F,size(projectedImage,1)).';
%pcshow([projectedImage(:,1),projectedImage(:,2),zPos])