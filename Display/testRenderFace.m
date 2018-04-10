% Create a random face with texture/shape

oglp.height = cameraParams.ImageSize(1);
oglp.width  = cameraParams.ImageSize(2);

oglp.i_amb_light = [ 0.1; 0.1; 0.1];
oglp.i_dir_light = [ 0.1; 0.1; 0.1];

alpha = randn(sizePC , 1);
beta = randn(sizePC , 1);

shape  = coef2object( alpha, model.shapeMU, model.shapePC, model.shapeEV );
tex    = coef2object( beta,  model.texMU,   model.texPC,   model.texEV);

% SET BACK FROM CAMERA
FV.vertices = FV.vertices .* (1e-03);

% Rotate 180 degrees around y axis
FV.vertices = FV.vertices * roty(180);

FV.vertices(:,1)= verts(:,1)+0;
FV.vertices(:,2)= verts(:,2)+0;
FV.vertices(:,3)= verts(:,3)+500;

FV.vertices = reshape(shape, [ 3 prod(size(shape))/3 ])'; 
FV.facevertexcdata = reshape(tex, [ 3 prod(size(tex))/3 ])'; 
FV.faces = model.tl;

im = render_face(FV, cameraParams.IntrinsicMatrix, [eye(3) [0 ; 0 ; 0]], oglp);
imshow(im)