function [xyz] = convertPixelToXYZ(ab,hfov,vfov,sizeX,sizeY) 
    
    h = deg2rad(hfov);
    v = deg2rad(vfov);
    
    xmax = 0.1 * tan (h/2);
    ymax = 0.1 * tan (v/2);
    
    % Respect to xmax ymax
    stepSizeX = (xmax*2)/(sizeX-1);
    stepSizeY = (ymax*2)/(sizeY-1);
    
    idxX = -xmax:stepSizeX:xmax;
    idxY = -ymax:stepSizeY:ymax;   
    
    vals2 = [((2*xmax)/sizeX)*ab(1) - xmax ,((2*ymax)/sizeY)*ab(2) - ymax ] ;
    
    xyz = [ vals2  0.1 ];
end
