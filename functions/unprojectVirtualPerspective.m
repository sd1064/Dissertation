function [ points ] = unprojectVirtualPerspective(landmarks,rotations,image,hfov,vfov,radius,zPlane,sphere)
    
    points = [];
    for idx = 1:size(landmarks,1)

        xyz = convertPixelToXYZ(landmarks(idx,:),hfov,vfov,size(image,2),size(image,1),zPlane);
        xyz = xyz.';
        xyz = xyz/norm(xyz);
        
        xyz = rotz(rotations(1,3)).' * roty(rotations(1,2)).' * rotx(rotations(1,1)).' * xyz;
        
        r = (1/pi)*acos(-xyz(3))/sqrt(xyz(1)^2 + xyz(2)^2);
        u = -1 * xyz(1) * r;
        v =      xyz(2) * r;
        
        point = [(u+1)*radius (v+1)*radius];
        points = [points; point];
    end

end

