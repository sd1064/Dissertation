function [projected] = perspectiveProjection(verts,k)
%PERSPECTIVEPROJECTION Summary of this function goes here
%   Input 3D mesh - output the projected points
    % Good explanation :
    % https://www.reddit.com/r/compsci/comments/37xqok/can_someone_explain_part_of_perspective/
    
    fx = k(1,1);
    fy = k(1,1);
    cx = k(3,1);
    cy = k(3,2);
    
    projected = [verts(:,1) verts(:,2) ];
    projected(:,1) = projected(:,1).*fx./verts(:,3)  + cx;
    projected(:,2) = projected(:,2).*-fy./verts(:,3) + cy;
    
end