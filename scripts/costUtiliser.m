% translation = estimateDistance(sphereRadius,points2DSphereOneOriginal,points2DSphereTwoOriginal,...
% spherePositionOne,spherePositionTwo,k);

translation = [-300 ;0 ;100 ];
Rx = 0; Ry = 0; Rz = 0;
imageHeight = size(undistortedImage,1);

params = double([Rx; Ry; Rz; translation(1); translation(2); translation(3); ]);
funcOne = @(params)differenceFacesTranslationRotation(params,spherePositionOne,spherePositionTwo,sphereRadius, ...
        k,model,points2DSphereOneOriginal,points2DSphereTwoOriginal,numOfParams,idx);
options = optimoptions('lsqnonlin','Display','iter');
[retOne,resnorm,residual,exitflag,output] = lsqnonlin(funcOne,params,[],[],options);

displayFirstAttempt;

offsets = repelem(0,numOfParams).';
params = [offsets; retOne];
funcTwo = @(params)differenceFaces(params,spherePositionOne,spherePositionTwo,sphereRadius, ...
        k,model,points2DSphereOneOriginal,points2DSphereTwoOriginal,numOfParams,idx);
options = optimoptions('lsqnonlin','Display','iter');
[retTwo,resnorm,residual,exitflag,output] = lsqnonlin(funcTwo,params,[],[],options);

displayFinal;
