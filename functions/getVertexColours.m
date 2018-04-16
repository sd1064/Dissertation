function vertexColours = getVertexColours(FV,k,spherePositionOne,oglp,sphereRadius,image)

% Get the rendering parameters
width           = oglp.width;               % width of the image plane
height          = oglp.height;              % height of the image plane

% Get the vertices
V           = FV.Vertices;
Nvertices   = size(FV.Vertices, 1);
Z = V(:, 3);

sphereReflections = zeros(size(V));
for i=1:length(sphereReflections)  
    sphereReflections(i,:) = sphereReflection(sphereRadius,spherePositionOne,V(i,:));
end
UV  = perspectiveProjection(sphereReflections,k);

% Get the triangle vertices
v1      = FV.Faces(:, 1);
v2      = FV.Faces(:, 2);
v3      = FV.Faces(:, 3);
Nfaces  = size(FV.Faces, 1);

% Compute bounding boxes for the projected triangles
x       = [UV(v1, 1), UV(v2, 1), UV(v3, 1)];
y       = [UV(v1, 2), UV(v2, 2), UV(v3, 2)];
minx    = ceil (min(x, [], 2));
maxx    = floor(max(x, [], 2));
miny    = ceil (min(y, [], 2));
maxy    = floor(max(y, [], 2));

clear x y

% Frustum culling
minx    = max(1,        minx);
maxx    = min(width,    maxx);
miny    = max(1,        miny);
maxy    = min(height,   maxy);

% Construct the pixel grid (can speed up by precomputing if shared among the images)
[rows, cols] = meshgrid(1: width, 1: height);

% Initialize the depth-, face- and weight-buffers
zbuffer     = -inf(height, width);
fbuffer     = zeros(height, width);
wbuffer1    = NaN(height, width);
wbuffer2    = NaN(height, width);
wbuffer3    = NaN(height, width);

% For each triangle (can speed up by comparing the triangle depths to the z-buffer and priorly sorting the triangles by increasing depth)
for i = 1: Nfaces
    
    % If some pixels lie in the bounding box
    if minx(i) <= maxx(i) && miny(i) <= maxy(i)
        
        % Get the pixels lying in the bounding box
        px = rows(miny(i): maxy(i), minx(i): maxx(i));
        py = cols(miny(i): maxy(i), minx(i): maxx(i));
        px = px(:);
        py = py(:);
        
        % Compute the edge vectors
        e0 = UV(v1(i), :);
        e1 = UV(v2(i), :) - e0;
        e2 = UV(v3(i), :) - e0;
        
        % Compute the barycentric coordinates (can speed up by first computing and testing a solely)
        det     = e1(1) * e2(2) - e1(2) * e2(1);
        tmpx    = px - e0(1);
        tmpy    = py - e0(2);
        a       = (tmpx * e2(2) - tmpy * e2(1)) / det;
        b       = (tmpy * e1(1) - tmpx * e1(2)) / det;
        
        % Test whether the pixels lie in the triangle
        test = a >= 0 & b >= 0 & a + b <= 1;
        
        % If some pixels lie in the triangle
        if any(test)
            
            % Get the pixels lying in the triangle
            px = px(test);
            py = py(test);
            
            % Interpolate the triangle depth for each pixel
            w2 = a(test);
            w3 = b(test);
            w1 = 1 - w2 - w3;
            pz = Z(v1(i)) * w1 + Z(v2(i)) * w2 + Z(v3(i)) * w3;
            
            % For each pixel lying in the triangle
            for j = 1: length(pz)
                
                % Frustum culling
%                if pz(j) <= -near && pz(j) >= -far
                    
                    % Update the depth-, face- and weight-buffers
                    if pz(j) > zbuffer(py(j), px(j))
                        zbuffer(py(j), px(j))   = pz(j);
                        fbuffer(py(j), px(j))   = i;
                        wbuffer1(py(j), px(j))  = w1(j);
                        wbuffer2(py(j), px(j))  = w2(j);
                        wbuffer3(py(j), px(j))  = w3(j);
                    end
                    
%                end
                
            end
            
        end
        
    end
    
end

% Get the vertices to render
test    = fbuffer ~= 0;
f       = unique(fbuffer(test));
v  = unique([v1(f); v2(f); v3(f)]);

vertexColours = zeros(size(FV.Vertices));
for c=1:3
    vertexColours(:,c) = interp2(image(:,:,c),UV(:,1),UV(:,2));
end
empty = setdiff(1:Nvertices,v).';
vertexColours(empty,:)=0;


end

