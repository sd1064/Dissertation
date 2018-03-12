function [ points ] = unprojectVirtualPerspective(landmarks,rotations,image,hfov,vfov,radius)
    
    points = [];
    for idx = 1:size(landmarks,1)
        
        xyz = convertPixelToXYZ(landmarks(idx,:),hfov,vfov,size(image,2),size(image,1));
        xyz = xyz.';
        xyz = xyz/norm(xyz);
        xyz = rotz(rotations(1,3)).' * roty(rotations(1,2)).' * rotx(rotations(1,1)).' * xyz;
        
        theta = acos(xyz(3));
        phi = atan2(xyz(2),xyz(1));
        
        u = (theta/pi)*sin(phi);
        v = (theta/pi)*cos(phi);
        
        point1 = (u+1)*radius; 
        point2 = (v+1)*radius;
        
        points = [points; round(point1) round(point2)];
    end
    
end

