SD = 5;
Rx = 0; Ry = 0; Rz = 0;

options = optimoptions('lsqnonlin','Display','iter');
options.FunctionTolerance   = 1e-7;
options.OptimalityTolerance = 1e-7;
options.StepTolerance = 1e-7;
options.FiniteDifferenceType = 'central';
options.MaxFunctionEvaluations = 6000;    

translation = [0;0;(spherePositionOne(3)+spherePositionTwo(3))/4];
params = double([Rx; Ry; Rz; translation(1); translation(2); translation(3); ]);

funcOne = @(params)differenceFacesTranslationRotation(params,spherePositionOne,spherePositionTwo,sphereRadius, ...
        k,model,points2DSphereOneOriginal,points2DSphereTwoOriginal,numOfParams,idx);
retOne = lsqnonlin(funcOne,params,[],[],options);
displayFirstAttempt;

lb = [repelem(-SD,numOfParams,1) ; 0;0;0;-inf;-inf;-inf];
ub = [repelem(SD,numOfParams,1);360;360;360;inf;inf;inf];

offsets = repelem(0,numOfParams).';
params = double([offsets; retOne]);
funcTwo = @(params)differenceFaces(params,spherePositionOne,spherePositionTwo,sphereRadius, ...
          k,model,points2DSphereOneOriginal,points2DSphereTwoOriginal,numOfParams,idx);
[retTwo,resnorm,residual,exitflag,output] = lsqnonlin(funcTwo,params,lb,ub,options);
displayFinal;