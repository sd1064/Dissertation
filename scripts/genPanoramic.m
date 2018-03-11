% originalImage  = imread('ParkAngularMap-800.jpg');
% originalImage = im2double(originalImage);
% 
% % [centres,radii] = circleRecognition(originalImage,350,400);
% % sphereOne = [centres(1,1) centres(1,2) radii(1)]; 
% sphereOne = [400 400 400];
% 
% spherePanoramic = [round(sphereOne(1)) round(sphereOne(2)) round(sphereOne(3))];
% croppedImage = imcrop(originalImage,[spherePanoramic(1)-spherePanoramic(3) spherePanoramic(2)-spherePanoramic(3) spherePanoramic(3)*2 spherePanoramic(3)*2]);
% pixelList = zeros((spherePanoramic(3)*2) * (spherePanoramic(3)*2),5);
% 
% i = 1;
% for row = (0:spherePanoramic(3)*2)
%     for col = (0:spherePanoramic(3)*2)
%         if sqrt((row - spherePanoramic(3))^2+(col-spherePanoramic(3))^2) < spherePanoramic(3)
%           
%           % Calculate u,v
%           u = (1/spherePanoramic(3))*col -1;
%           v = (1/spherePanoramic(3))*row -1;
%           colN = -1*col + (spherePanoramic(3)*2) + 1;
%          
%           % Calculate theta,phi
%           phi = atan2(v,u);
%           theta = pi*sqrt((u)^2 + (v)^2);
%           
%           xyz = [sin(theta)*cos(phi); sin(theta)*sin(phi); cos(theta)];
%           xyz = rotx(180) * roty(90) * rotz(0) * xyz;
%           
%           pixelList(i,1) = atan2(xyz(2),xyz(1));
%           pixelList(i,2) = acos(xyz(3));
%          
%           pixelList(i,3) = croppedImage(colN,row,1);
%           pixelList(i,4) = croppedImage(colN,row,2);
%           pixelList(i,5) = croppedImage(colN,row,3);
% 
%         end
%         i = i+1;
%     end
% end
% 
% pixelList = pixelList(any(pixelList,2),:);
% 
% redInterp   = scatteredInterpolant(pixelList(:,1),pixelList(:,2),pixelList(:,3));
% greenInterp = scatteredInterpolant(pixelList(:,1),pixelList(:,2),pixelList(:,4));
% blueInterp  = scatteredInterpolant(pixelList(:,1),pixelList(:,2),pixelList(:,5));
% 
% imageHeight = 400;
% 
% cols = linspace(-pi,pi,2*imageHeight);
% rows = linspace(0,pi,imageHeight);
% 
% [C,R] = meshgrid(cols,rows);
% 
% r   = redInterp(C,R);
% g   = greenInterp(C,R);
% b   = blueInterp(C,R);
% 
% rgbPanoramicImage = cat(3, r, g, b);
% figure;imshow(rgbPanoramicImage);


% panoram to xyz
x = 202;
y = 175;

coefficients = polyfit([0, 800], [-pi, pi], 1);
acrossSphere = coefficients(1)*x+coefficients(2);

coefficients = polyfit([0, 400], [0, pi], 1);
aboveSphere = coefficients(1)*y+coefficients(2);