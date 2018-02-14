function [ landmarks ] = getLandmarks( verts,list )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    landmarks = zeros(size(list,1),3);
    for i=1:length(list)
        landmarks(i,:) = verts(list(i),:);
    end
end

