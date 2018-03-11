function [xyz] = convertPixelToXYZ(ab,hfov,vfov,sizeX,sizeY) 
    
    % Input 
    % [132,106],116,83,300,214)
    
    % Target 
    % [-0.782772011647376;3.766666666666636;0.100000000000000]
    
    % go from Virtual Perspected Image To Original XYZ where z = 0.1
    
    h = deg2rad(hfov);
    v = deg2rad(vfov);
    
    xmax = 0.1 * tan (h/2);
    ymax = 0.1 * tan (v/2);
    
    % Respect to xmax ymax
    
    idxX = -xmax:((xmax*2)/(sizeX-1)):xmax;
    idxY = -ymax:((ymax*2)/(sizeY-1)):ymax;   
    
    vals = [idxX(ab(1)) idxY(ab(2))];
    
    % xyz = [ xRespectToXFov yRespectToYFov  0.1 ];
end
