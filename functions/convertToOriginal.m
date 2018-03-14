function [ landmarks ] = convertToOriginal( croppingPoint,landmarks )
     landmarks(:,1) = landmarks(:,1) + croppingPoint(1);
     landmarks(:,2) = landmarks(:,2) + croppingPoint(2);
end