function [ image ] = generateVirtualPerspectiveProjection( image,sphereRadius,rx,ry,rz,hfov,vfov,generatedImageWidth,zPlane)
    pixelList = zeros((sphereRadius*2) * (sphereRadius*2),5);
    i = 1;
    for row = (0:sphereRadius*2)
        for col = (0:sphereRadius*2)
            if sqrt((row - sphereRadius)^2+(col-sphereRadius)^2) < sphereRadius

                % Calculate u,v
                u = (1/sphereRadius)*col -1;
                v = (1/sphereRadius)*row -1;
                
                colN = -1*col + (sphereRadius*2) + 1;
                rowN = -1*row + (sphereRadius*2) + 1;
                
                % Calculate theta,phi
                phi = atan2(v,u);
                theta = pi*sqrt((u)^2 + (v)^2);

                xyz=[0;0;-1];
                xyz=rotz(phi*(180/pi))*roty(theta*(180/pi))*xyz;
                xyz = rotx(rx) * roty(ry) * rotz(rz) * xyz;
                
                if xyz(3)>0
                    xyz = xyz/xyz(3)*zPlane;
                    pixelList(i,1) = xyz(1);
                    pixelList(i,2) = xyz(2);
                    pixelList(i,4) = image(rowN,col,1);
                    pixelList(i,5) = image(rowN,col,2);
                    pixelList(i,6) = image(rowN,col,3);                   
                end
            end
            i = i+1;
        end
    end
    pixelList = pixelList(any(pixelList,2),:);

    redInterp   = scatteredInterpolant(pixelList(:,1),pixelList(:,2),pixelList(:,4));
    greenInterp = scatteredInterpolant(pixelList(:,1),pixelList(:,2),pixelList(:,5));
    blueInterp  = scatteredInterpolant(pixelList(:,1),pixelList(:,2),pixelList(:,6));

    h = deg2rad(hfov);
    v = deg2rad(vfov);
    ratio = v/h;
    xmax = zPlane  * tan (h/2);
    ymax = zPlane  * tan (v/2);

    cols = linspace(-xmax,xmax,generatedImageWidth);
    rows = linspace(-ymax,ymax,generatedImageWidth*ratio);
    [C,R] = meshgrid(cols,rows);

    r   = redInterp(C,R);
    g   = greenInterp(C,R);
    b   = blueInterp(C,R);
    image = cat(3, r, g, b);

end