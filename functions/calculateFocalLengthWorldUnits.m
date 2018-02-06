function [ FocalLength ] = calculateFocalLengthWorldUnits( worldRadius,pixelRadius,fx )
%   calculate FocalLength F
%   F = fx * px
%   px = worldRadius/pixelRadius

    FocalLength = fx * (worldRadius/pixelRadius);
    
end

