function [centres,radii] = circleRecognition(inputImage,circleBoundaryLow,circleBoundaryHigh)

    BW = rgb2gray(inputImage);
    BW = imgaussfilt(BW, 5);

    centres = []; radii = [];
    [centres, radii] = imfindcircles(BW,[circleBoundaryLow circleBoundaryHigh],'ObjectPolarity','dark','Sensitivity',0.95,'EdgeThreshold',0.2,'Method','twostage');

end