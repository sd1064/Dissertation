function [ FocalLength ] = calculateFocalLengthWorldUnits(world,pixel,fx )
    px = world/pixel;
    FocalLength = fx*px;
end

