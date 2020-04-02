% Function to convert the topview to a mask, which will be projected on the
% canvas as obstacle
% Input:
%   canvasSize
%   aTopView
%   currentPosition
%   currentDirection, current facing direction, with norm as 1
% Output:
%   mask to put on canvas
function mask =  maskOnCanvas(canvasSize, aTopView, currentPosition, currentDirection)
    mask = zeros(canvasSize);
    
    % Convert image to binary
    topViewBW = imbinarize(aTopView);
    
    % Rotate the image by currentDirection
    angle = atan(currentDirection(2)/currentDirection(1));
    topViewRotated = imrotate(topViewBW, rad2deg(angle));
    
    % Shift the top view's base center to start point
    [rows, columns] = size(topViewRotated);
    for i = 1:rows
        for j = 1 : columns 
            x_index = i + currentPosition(2) - floor((1-cos(angle))*rows/2) ;
            y_index = j + currentPosition(1) - floor(columns/2 - rows*sin(angle)/2);
            if ( x_index > 0 && x_index < canvasSize && y_index >0 && y_index < canvasSize)
                mask(x_index, y_index) = topViewRotated(i, j);
            end
        end 
    end 
    
    % Plot the obstacle 
    figure
    subplot (1,3,1)
    imshow(topViewBW); set(gca,'YDir','normal')
    title('Topview of the depth img, after conversion')
    subplot (1,3,2)
    imshow(mask); set(gca,'YDir','normal')
    title('Mask for map, after rotation and shift')
    
    
end