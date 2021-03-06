% % originalImage  = undistortedImage;
% originalImage  = im2double(imread('hdri_withblack.jpg'));
% [centres,radii] = circleRecognition(originalImage,400,450);
% spherePanoramic = [round(sphereOne(1)) round(sphereOne(2)) round(sphereOne(3))];
originalImage = im2double(imread('sphereCrop (4).JPG'));
spherePanoramic = [422 422 422];
% spherePanoramic = [1481 1481 1481];
% spherePanoramic = [1362 1935 426];

croppedImage = imcrop(originalImage,[spherePanoramic(1)-spherePanoramic(3) spherePanoramic(2)-spherePanoramic(3) spherePanoramic(3)*2 spherePanoramic(3)*2]);pixelList = zeros((spherePanoramic(3)*2) * (spherePanoramic(3)*2),5);

i = 1;
for row = (0:spherePanoramic(3)*2)
    for col = (0:spherePanoramic(3)*2)
        if sqrt((row - spherePanoramic(3))^2+(col-spherePanoramic(3))^2) < spherePanoramic(3)
          
          % Calculate u,v
          u = (1/spherePanoramic(3))*col -1;
          v = (1/spherePanoramic(3))*row -1;
          colN = -1*col + (spherePanoramic(3)*2) + 1;
         
          % Calculate theta,phi
          phi = atan2(v,u);
          theta = pi*sqrt((u)^2 + (v)^2);
          xyz=[0;0;-1];
          xyz=rotz(phi*(180/pi))*roty(theta*(180/pi))*xyz;
          %xyz = [sin(theta)*cos(phi); sin(theta)*sin(phi); cos(theta)];
          %xyz = rotx(180) * roty(90) * rotz(0) * xyz;

          pixelList(i,1) = atan2(xyz(2),xyz(1));
          pixelList(i,2) = acos(xyz(3));
         
          pixelList(i,3) = croppedImage(colN,row,1);
          pixelList(i,4) = croppedImage(colN,row,2);
          pixelList(i,5) = croppedImage(colN,row,3);

          pixelList(i,6) = theta;
          pixelList(i,7) = phi;
          pixelList(i,8:10) = xyz;
          pixelList(i,11) = u;
          pixelList(i,12) = v;
          
        end
        i = i+1;
    end
end

pixelList = pixelList(any(pixelList,2),:);

redInterp   = scatteredInterpolant(pixelList(:,1),pixelList(:,2),pixelList(:,3));
greenInterp = scatteredInterpolant(pixelList(:,1),pixelList(:,2),pixelList(:,4));
blueInterp  = scatteredInterpolant(pixelList(:,1),pixelList(:,2),pixelList(:,5));

imageHeight = 201;

cols = linspace(-pi,pi,2*imageHeight);
rows = linspace(0,pi,imageHeight);

[C,R] = meshgrid(cols,rows);

r   = redInterp(C,R);
g   = greenInterp(C,R);
b   = blueInterp(C,R);

rgbPanoramicImage = cat(3, r, g, b);
figure;imshow(rgbPanoramicImage);
