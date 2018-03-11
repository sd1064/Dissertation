function [ image ] = generateVirtualPerspectiveProjection( image,sphereRadius,rx,ry,rz,hfov,vfov,generatedImageWidth )
%generateVirtualPerspectiveProjection 
% generate a virtual perspecetive projection from thesis :

% look at at page 88 for better explanation
% basically set image plane arbitrally from a sphere and project points
% onto it
    
    pixelList = zeros((sphereRadius*2) * (sphereRadius*2),5);

    i = 1;
    for row = (0:sphereRadius*2)
        for col = (0:sphereRadius*2)
            if sqrt((row - sphereRadius)^2+(col-sphereRadius)^2) < sphereRadius

              % Calculate u,v
              u = (1/sphereRadius)*col -1;
              v = (1/sphereRadius)*row -1;
              colN = -1*col + (sphereRadius*2) + 1;

              % Calculate theta,phi
              phi = atan2(v,u);
              theta = pi*sqrt((u)^2 + (v)^2);
              
              xyz = [sin(theta)*cos(phi); sin(theta)*sin(phi); cos(theta)];
              xyz = rotx(rx) * roty(ry) * rotz(rz) * xyz;
              if xyz(3)>0

                xyz = xyz/xyz(3)*0.1;

                pixelList(i,1) = xyz(1);
                pixelList(i,2) = xyz(2);

                pixelList(i,3) = image(colN,row,1);
                pixelList(i,4) = image(colN,row,2);
                pixelList(i,5) = image(colN,row,3);

              end
            end
            i = i+1;
        end
    end

    pixelList = pixelList(any(pixelList,2),:);

    redInterp   = scatteredInterpolant(pixelList(:,1),pixelList(:,2),pixelList(:,3));
    greenInterp = scatteredInterpolant(pixelList(:,1),pixelList(:,2),pixelList(:,4));
    blueInterp  = scatteredInterpolant(pixelList(:,1),pixelList(:,2),pixelList(:,5));

    h = deg2rad(hfov);
    v = deg2rad(vfov);
    ratio = v/h;
    
    xmax = 0.1 * tan (h/2);
    ymax = 0.1 * tan (v/2);

    cols = linspace(-xmax,xmax,generatedImageWidth);
    rows = linspace(-ymax,ymax,generatedImageWidth*ratio);

    [C,R] = meshgrid(cols,rows);

    r   = redInterp(C,R);
    g   = greenInterp(C,R);
    b   = blueInterp(C,R);

    image = cat(3, r, g, b);

end

