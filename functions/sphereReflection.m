function [ Sr ] = sphereReflection( radius, sphereCentre,facePoint)
%SPHEREREFLECTION Summary of this function goes here
%   Detailed explanation goes here
    
    vectorA = (facePoint - sphereCentre)/norm(facePoint - sphereCentre);
    vectorB = -sphereCentre/norm(sphereCentre);
    normSr = (vectorA + vectorB)/norm(vectorA+vectorB);
    Sr = sphereCentre + radius*normSr;
    Sr = Sr';
   
end

