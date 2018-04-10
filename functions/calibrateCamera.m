function [ cameraParams ] = calibrateCamera( numberImages,squareSize)
%CALIBRATECAMERA Summary of this function goes here

%   Detailed explanation goes here
    numImages = numberImages;
    imageFileNames = cell(1, numImages);
    for i = 1:numImages
        imageFileNames{i} = fullfile(pwd,'res','images','calib',sprintf('calib (%d).jpg', i));
    end

    % Detect checkerboards in images
    [imagePoints, boardSize, imagesUsed] = detectCheckerboardPoints(imageFileNames);
    imageFileNames = imageFileNames(imagesUsed);

    % Read the first image to obtain image size
    originalImage = imread(imageFileNames{1});
    [mrows, ncols, ~] = size(originalImage);

    % Generate world coordinates of the corners of the squares
    %squareSize = 30;  % in units of 'mm'
    worldPoints = generateCheckerboardPoints(boardSize, squareSize);

    % Calibrate the camera
    [cameraParams, imagesUsed, estimationErrors] = estimateCameraParameters(imagePoints, worldPoints, ...
        'EstimateSkew', false, 'EstimateTangentialDistortion', false, ...
        'NumRadialDistortionCoefficients', 2, 'WorldUnits', 'mm', ...
        'InitialIntrinsicMatrix', [], 'InitialRadialDistortion', [], ...
        'ImageSize', [mrows, ncols]);

    % View reprojection errors
    h1=figure; showReprojectionErrors(cameraParams);

    % Visualize pattern locations
    h2=figure; showExtrinsics(cameraParams, 'CameraCentric');

    % Display parameter estimation errors
    displayErrors(estimationErrors, cameraParams);

    % For example, you can use the calibration data to remove effects of lens distortion.
    %undistortedImage = undistortImage(originalImage, cameraParams);

    % See additional examples of how to use the calibration data.  At the prompt type:
    % showdemo('MeasuringPlanarObjectsExample')
    % showdemo('StructureFromMotionExample')

end

