rp.height = 1000;
rp.width  = 1000;
rp.phi    = deg2rad(90);

x = repelem(0,199);
x=x.';

%AvgFace
shpA = coef2object( x, model.shapeMU, model.shapePC, model.shapeEV );
texA = coef2object( x,  model.texMU,   model.texPC,   model.texEV);

%Genned Face
shpG = coef2object( randn(199, 1), model.shapeMU, model.shapePC, model.shapeEV );
texG    = coef2object(  randn(199, 1),  model.texMU,   model.texPC,   model.texEV);

display_face (shpA, texA, model.tl, rp)

% avg = reshape(shpA, [ 3 prod(size(shpA))/3 ])'; 
% genned = reshape(shpG, [ 3 prod(size(shpG))/3 ])'; 
% 
% % figure;pcshow(avg,[0, 0.4470, 0.7410]);grid off;axis off;
% figure;pcshow(genned,[0.6350, 0.0780, 0.1840]);grid off;axis off;