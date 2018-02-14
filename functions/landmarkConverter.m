function [ coords,position ] = landmarkConverter( landmarks,landmarkNumber )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    coords = landmarks(landmarkNumber,2:4);
    position = landmarks(landmarkNumber,1);
    position = position+1;
end

