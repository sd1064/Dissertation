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
    xRespectToXmax = ((2*xmax)/sizeX)*ab(1) - xmax;
    yRespectToYmax = ((2*ymax)/sizeY)*ab(2) - ymax;
    
    % Respect to FoVs 
    xRespectToXFov = 2 * atan(xRespectToXmax/0.1); 
    yRespectToYFov = 2 * atan(yRespectToYmax/0.1);
    
    xyz = [ xRespectToXFov yRespectToYFov  0.1 ];
end
