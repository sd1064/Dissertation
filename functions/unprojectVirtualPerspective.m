function [ points ] = unprojectVirtualPerspective(image,landmarks,rotations,radius)

    % INTERPOLATE POINTS
    % go from ab -> xyz
    
    v = repelem(0.1,size(landmarks,5));
    interpolent = scatteredInterpolant(landmarks(:,1),landmarks(:,2),v.');
    
    % UNIT SPHERE !!!!
    % WANT Z = 1 
    
    [x,y,z] = sphere(radius); 
    interpolatedLandmarks = interpolent(x,y,z);
    
    points = [];
    for idx = 1:numel(interpolatedLandmarks)
        xyz = interpolatedLandmarks(idx);
        
        xyz = xyz/0.1 * xyz(3);
        
        % undo the rotation
        xyz = rotz(rotations(1,3)) * roty(rotations(1,2)).' * rotx(rotations(1,1)).' * xyz;

        % get back theta and phi
        theta = acos(xyz(3));
        phi = asin(xyz(2)/sin(theta));

        % get back to u and v
        u = radius * cos(theta);
        v = radius * sin(theta);

        % from u and v back to original image coordinages
        % ATM just plot onto cropped image
        % REMEBER LANDMARKS ARE X Y AND MATLAB IS ROWS AND COLUMNS
        points = [points; u v];
    end
    
end

