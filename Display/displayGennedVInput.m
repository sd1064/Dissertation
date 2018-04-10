% targetVerts = verts.';
targetParams  = object2coef( verts(:), model.shapeMU, model.shapePC, model.shapeEV );

lsqFace  = coef2object( ret(1:numOfParams), model.shapeMU, model.shapePC, model.shapeEV );
lsqFace  = reshape(lsqFace, [ 3 prod(size(lsqFace))/3 ])';
lsqFace  = lsqFace.* (1e-03);

lsqFace = lsqFace * rotx(ret(numOfParams+1)) * roty(ret(numOfParams+2)) * rotz(ret(numOfParams+3));

lsqFace(:,1)= lsqFace(:,1)+ret(numOfParams+4);
lsqFace(:,2)= lsqFace(:,2)+ret(numOfParams+5);
lsqFace(:,3)= lsqFace(:,3)+ret(numOfParams+6); 

figure;
xlabel('X');ylabel('Y');zlabel('Z');axis equal;grid on;
pcshow([verts(:,1) verts(:,2) verts(:,3)]);

figure;
xlabel('X');ylabel('Y');zlabel('Z');axis equal;grid on;
pcshow([lsqFace(:,1) lsqFace(:,2) lsqFace(:,3)]);

% figure;hold on;
% xlabel('X');ylabel('Y');zlabel('Z');axis equal;grid on;
% pcshow([lsqFace(:,1) lsqFace(:,2) lsqFace(:,3)],'blue');
% pcshow([verts(:,1) verts(:,2) verts(:,3)],'red');

figure;
pcshowpair(pointCloud(verts), pointCloud(lsqFace));