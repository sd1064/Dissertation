function [ returnVal ] = extrinsicSphereCalibration(K,sphere)
%EXTRINSICSPHERECALIBRATION Calculates extrinsic paramteres using a sphere
%   Detailed explanation goes here

    %(u0,v0) is the optical centre positions assumed to be (0,0)
    %(us,vs) is the centre of the sphere in the image
    % Look at section 4.2 of "Extrinsic Calibration of Camera Networks Using
    % a Sphere" for a summary of the maths implemented
    
    % ATM assumed Rs = radius of the sphere in pixels (paper has some discussion about sphere vs circle)
    
    u0 = K(1,3);
    v0 = K(2,3);
    us = sphere(1,1);
    vs = sphere(1,2);
    
    Rs=sphere(1,3);
    
    fx = K(1,1);
    fy = K(2,2);
    
    N = pi*sphere(1,3)^2; 
    
    xs = (us-u0)/fx;
    ys = (vs-v0)/fy;
    delta = -((xs^2+ys^2)^1/2);
    theta = -atan(delta);
    A = N/(fx*fy);

    Zs = Rs*(pi/(A*cos(theta)))^1/2;
    Xs = xs * Zs;
    Ys = ys * Zs;
    returnVal= [Xs Ys Zs]
end

