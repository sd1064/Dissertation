function [centres,radii] = circleRecognition(inputImage)

    BW = rgb2gray(inputImage);
    matrix = ones(5,5) / 25;
    BW = imfilter(BW,matrix);
    
    %Keep in if needed
    %blurred = imgaussfilt(grey, 10);
    %BW = imbinarize(BW,'adaptive','ForegroundPolarity','dark','Sensitivity',0.6);
    %noiseless = wiener2(BW2,[4 4]);
    
    
    [centersDark, radiiDark] = imfindcircles(BW,[35 65],'Sensitivity',0.80,'EdgeThreshold',0.1,'Method','twostage');
   %[centersDark, radiiDark] = imfindcircles(BW,[35 65],'ObjectPolarity','dark','Sensitivity',0.80,'EdgeThreshold',0.1,'Method','twostage');
    
    %figure;imshow(BW) 
    %viscircles(centersDark,radiiDark);
    
    centres = centersDark;
    radii = radiiDark;
end