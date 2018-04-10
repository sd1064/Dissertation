function [centers,radii] = circleRecognition(inputImage,circleBoundaryLow,circleBoundaryHigh)
    
    I = imguidedfilter(inputImage);
    I = imguidedfilter(I);
    figure; imshow(I);    

    [centers, radii, metric] = imfindcircles(I,[circleBoundaryLow circleBoundaryHigh],'ObjectPolarity','bright','Sensitivity',0.99,'EdgeThreshold',0.13,'Method','twostage');
    viscircles(centers, radii);

end