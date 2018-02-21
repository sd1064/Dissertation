originalImage = imread('uffizi_probe.jpg');
originalImage = im2double(originalImage);

%[centres,radii] = circleRecognition(originalImage,375,425);
centres = [150 150];
radii = 150;
sphereOne = [centres(1,1) centres(1,2) radii(1,1)];
spherePanoramic = [round(sphereOne(1)) round(sphereOne(2)) round(sphereOne(3))];

pixelList = zeros((spherePanoramic(3)*2) * (spherePanoramic(3)*2),5);

i = 1;
for row = (spherePanoramic(2)-spherePanoramic(3)):(spherePanoramic(2)+spherePanoramic(3))
    for col = (spherePanoramic(1)-spherePanoramic(3)):(spherePanoramic(1)+spherePanoramic(3))
        if sqrt((row - spherePanoramic(2))^2+(col-spherePanoramic(1))^2) < spherePanoramic(3)
          
          % Calculate u,v
          uImageCoord = col - (spherePanoramic(2)-spherePanoramic(3));
          vImageCoord = row - (spherePanoramic(1)-spherePanoramic(3));
          u = (1/spherePanoramic(3))*uImageCoord -1;
          v = (1/spherePanoramic(3))*vImageCoord -1;

          % Calculate theta,phi
          phi = atan2(v,u);
          theta = pi*sqrt((u)^2 + (v)^2);
          xyz = [sin(theta)*cos(phi); sin(theta)*sin(phi); cos(theta)];
          xyz = rotx(180) * roty(90) * xyz;
          if xyz(3)>0
    %         To rescale xyz to have z = 0.1
    %         xyz = xyz/xyz(3)*0.1;
    %         Need to store xyz(1:2)

              pixelList(i,1) = atan2(xyz(2),xyz(1));
              pixelList(i,2) = acos(xyz(3));
              % Negate
              colN = -1*uImageCoord + (spherePanoramic(3)*2) + 1;

              pixelList(i,3) = originalImage(colN,row,1);
              pixelList(i,4) = originalImage(colN,row,2);
              pixelList(i,5) = originalImage(colN,row,3);
          end
        end
        i = i+1;
    end
end

pixelList = pixelList(any(pixelList,2),:);

redInterp   = scatteredInterpolant(pixelList(:,1),pixelList(:,2),pixelList(:,3));
greenInterp = scatteredInterpolant(pixelList(:,1),pixelList(:,2),pixelList(:,4));
blueInterp  = scatteredInterpolant(pixelList(:,1),pixelList(:,2),pixelList(:,5));

imageHeight = 400;

cols = linspace(-pi,pi,2*imageHeight);
rows = linspace(0,pi,imageHeight);

[C,R] = meshgrid(cols,rows);

r   = redInterp(C,R);
g   = greenInterp(C,R);
b   = blueInterp(C,R);

rgbImage = cat(3, r, g, b);
figure;imshow(rgbImage)