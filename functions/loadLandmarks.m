function [ landmarks ] = loadLandmarks( )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    % convert from micro to milli 
    landmarks = csvread('landmarks.csv');
    landmarks = landmarks(:,1:4);
    landmarks = [landmarks(:,1) landmarks(:,2:4) .* (1e-03)];
end

