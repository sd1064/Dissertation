function [projected] = perspectiveProjection(verts,F)
%PERSPECTIVEPROJECTION Summary of this function goes here
%   Input 3D mesh - output the projected points

    projected = [verts(:,1) verts(:,2)];
    projected(:,1) = projected(:,1).*(F./verts(:,3));
    projected(:,2) = projected(:,2).*(F./verts(:,3));
     
end

