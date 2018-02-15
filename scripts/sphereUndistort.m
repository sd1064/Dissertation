clc;
clear all;

originalImage = imread('lightProbe.bmp');
[centres,radii] = circleRecognition(originalImage,450,500);
sphereOne = [centres(1,1) centres(1,2) radii(1,1)];
spherePanoramic = [round(sphereOne(1)) round(sphereOne(2)) round(sphereOne(3))];
pixelList = zeros((spherePanoramic(3)*2) * (spherePanoramic(3)*2),5);

i = 1; 
for x = (spherePanoramic(1)-spherePanoramic(3)):(spherePanoramic(1)+spherePanoramic(3))
    for y = (spherePanoramic(2)-spherePanoramic(3)):(spherePanoramic(2)+spherePanoramic(3))
        if sqrt((x - spherePanoramic(1))^2+(y-spherePanoramic(2))^2) < spherePanoramic(3)
            
          u = x - (spherePanoramic(1)-spherePanoramic(3));
          v = y - (spherePanoramic(2)+spherePanoramic(3));
          
          pixelList(i,1) = atan2(v,u);
          pixelList(i,2) = pi*sqrt((u)^2 + (v)^2);
          pixelList(i,3) = originalImage(y,x,1);
          pixelList(i,4) = originalImage(y,x,2);
          pixelList(i,5) = originalImage(y,x,3);
          
        end
        i = i+1;
    end
end

pixelList = pixelList(any(pixelList,2),:);

x = 0:1000;
y = 0:2000;
[X,Y] = meshgrid(x,y);

% F = zeros(size(X,1),size(X,2));
% surf(X,Y,F);axis equal;

% use scattered interpolator
