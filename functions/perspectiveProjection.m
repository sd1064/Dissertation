function [projected] = perspectiveProjection(verts,k)
%PERSPECTIVEPROJECTION Summary of this function goes here
%   Input 3D mesh - output the projected points

    if size(verts,2)==3
    	verts = verts';
    end
    verts(4,:)=1;
    uvw = k*[eye(3) [0;0;0];]*verts;
    projected(:,1) = (uvw(1,:)./uvw(3,:))';
    projected(:,2) = (uvw(2,:)./uvw(3,:))';
    
end