function [ points ] = unprojectVirtualPerspective(landmarks,rotations,image,hfov,vfov )
    
    points = [];
    for idx = 1:numel(landmarks)
        
        ab = landmarks(idx);
        
        hv = convert(ab,hfov,vfov,image);
        hv = [hv.' ; 0.1];
        xyz = hv/norm(hv);
        
        xyz = rotz(rotations(1,3)) * roty(rotations(1,2)).' * rotx(rotations(1,1)).' * xyz;
        
        theta = acos(xyz(3));
        phi = atan2(xyz(2),xyz(1));
        
        u = phi * cos(theta);
        v = phi * sin(theta);
        
        points = [points; u v];
    end
    
end


function [converted] = convert(ab,hfov,vfov,image) 
    % go from a b to h v coord space
    % e.g -xmax to xmax and -ymax to ymax
    
    h = deg2rad(hfov);
    v = deg2rad(vfov);
    ratio = v/h;
    
    xmax = 0.1 * tan (h/2);
    ymax = 0.1 * tan (v/2);

    % cols = linspace(-xmax,xmax,generatedImageWidth);
    % rows = linspace(-ymax,ymax,generatedImageWidth*ratio);
    
end
