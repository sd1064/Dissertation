function [projected] = perspectiveProjection(verts,f,cx,cy)
%PERSPECTIVEPROJECTION Summary of this function goes here
%   Input 3D mesh - output the projected points
    % Good explanation :
    % https://www.reddit.com/r/compsci/comments/37xqok/can_someone_explain_part_of_perspective/

    projected = [verts(:,1) verts(:,2) ];
    projected(:,1) = projected(:,1).*f./verts(:,3)  + cx;
    projected(:,2) = projected(:,2).*-f./verts(:,3) + cy;
    
end