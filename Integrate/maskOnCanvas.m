% Function to convert the topview to a mask, which will be projected on the
% canvas as obstacle
% Input:
%   canvasSize
%   aTopView
%   currentPosition
%   currentDirection, current facing direction, with norm as 1
% Output:
%   mask to put on canvas
function [mask_indecis,A_b] =  maskOnCanvas(canvasSize, aTopView, currentPosition, currentDirection)
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
    
    [row, col] = find(mask);
    mask_indecis = [col row];
    
    % Using method described in http://web.cvxr.com/cvx/examples/cvxbook/Ch08_geometric_probs/html/min_vol_elp_finite_set.html
    % To draw a minimum volume ellipsoid covering the mask
    x = mask_indecis';
    [n,m] = size(x);
    
    % Create and solve the model
    % CVX package installed from http://cvxr.com/cvx/doc/install.html#supported-platforms
    cvx_begin
        variable A(n,n) symmetric
        variable b(n)
        maximize( det_rootn( A ) )
        subject to
            norms( A * x + b * ones( 1, m ), 2 ) <= 1;
    cvx_end

    A_b = [A; b'];
    
    % Plot the obstacle 
    figure
    subplot (2,2,1)
    imshow(topViewBW); set(gca,'YDir','normal')
    title('Topview of the depth img, after conversion')
    subplot (2,2,2)
    imshow(mask); set(gca,'YDir','normal')
    title('Mask for map, after rotation and shift')
    % Plot the ellipse results
    subplot(2,2,3)
    noangles = 200;
    angles   = linspace( 0, 2 * pi, noangles );
    ellipse  = A \ [ cos(angles) - b(1) ; sin(angles) - b(2) ];
    plot( x(1,:), x(2,:), 'ro', ellipse(1,:), ellipse(2,:), 'b-' );
    title('Minimum Volume Ellipsoid')
   
end