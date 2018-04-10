function [ FocalLength ] = calculateFocalLengthWorldUnits( worldRadius,pixelRadius,fx )
%   calculate FocalLength F
%   F = fx * px
%   px = worldRadius/pixelRadius

    FocalLength = fx * px (worldRadius/pixelRadius);
    
end

