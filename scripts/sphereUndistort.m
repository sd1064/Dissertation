clc;
clear all;

originalImage = imread('ParkAngularMap-800.jpg');
originalImage = im2double(originalImage);


%[centres,radii] = circleRecognition(originalImage,450,500);
%sphereOne = [centres(1,1) centres(1,2) radii(1,1)];
%spherePanoramic = [round(sphereOne(1)) round(sphereOne(2)) round(sphereOne(3))];

spherePanoramic = [size(originalImage,1)/2 size(originalImage,1)/2 size(originalImage,1)/2];
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
          pixelList(i,1) = atan2(v,u);
          pixelList(i,2) = pi*sqrt((u)^2 + (v)^2);
          
          pixelList(i,3) = originalImage(col,row,1);
          pixelList(i,4) = originalImage(col,row,2);
          pixelList(i,5) = originalImage(col,row,3);
          
        end
        i = i+1;
    end
end

pixelList = pixelList(any(pixelList,2),:);

redInterp   = scatteredInterpolant(pixelList(:,1),pixelList(:,2),pixelList(:,3));
greenInterp = scatteredInterpolant(pixelList(:,1),pixelList(:,2),pixelList(:,4));
blueInterp  = scatteredInterpolant(pixelList(:,1),pixelList(:,2),pixelList(:,5));

imageHeight = 400;
% cols = linspace(0,2*pi,2*imageHeight);
% rows = linspace(0,pi,imageHeight);

cols = linspace(0,pi,imageHeight);
rows = linspace(0,pi,2*imageHeight);

[C,R] = meshgrid(cols,rows);

r   = redInterp(C,R);
g   = greenInterp(C,R);
b   = blueInterp(C,R);

rgbImage = cat(3, r, g, b);
rgbImage = imrotate(rgbImage,90);
figure;imshow(rgbImage)
