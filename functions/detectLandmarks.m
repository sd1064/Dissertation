function [ landmarks ] = detectLandmarks( image)
    
    image = rgb2gray(image);
    load('Chehra_f1.0.mat');
    MaxIter=6;

    faceDetector = vision.CascadeObjectDetector();
    bbox = step(faceDetector, image);   
    
    if not(isempty(bbox))
        test_init_shape = InitShape(bbox,refShape);
        test_init_shape = reshape(test_init_shape,49,2);
        landmarks = Fitting(image,test_init_shape,RegMat,MaxIter);
    else
        landmarks = [];
    end
    
end

