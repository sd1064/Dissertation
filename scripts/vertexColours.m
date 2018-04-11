shpG = coef2object( retTwo(1:25), model.shapeMU, model.shapePC, model.shapeEV );

genFace = reshape(shpG, [ 3 prod(size(shpG))/3 ])'; 
genFace = genFace .* (1e-03);
genFace = genFace * rotx(retTwo(26)) * roty(retTwo(27)) * rotz(retTwo(28));
genFace(:,1) = genFace(:,1) + retTwo(29);
genFace(:,2) = genFace(:,2) + retTwo(30);
genFace(:,3) = genFace(:,3) + retTwo(31);

oglp.width  = size(undistortedImage,2);
oglp.height = size(undistortedImage,1);

FV.verts = genFace;
FV.faces = model.tl;
FV.vertColours = getVertexColours(FV,k,spherePositionOne,oglp,sphereRadius,undistortedImage);

rp.height = 1000;
rp.width  = 1000;
rp.phi    = deg2rad(90);

display_face (FV.verts, FV.vertColours(:), FV.faces, rp);