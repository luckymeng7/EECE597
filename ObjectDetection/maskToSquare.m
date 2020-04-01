% Reads in the obstacle mask and convert it to rectangles 
% Input:
%   obstacleMask
% Output: 
%   obstacleSquare
%   recVector: a vector of [x,y,w,h]
% Note:
%   This is a made up algorithm, need to be improved in the future 

function [obstacleSquare, recVector] = maskToSquare(obstacleMask)
    obstacleSquare = zeros(size(obstacleMask));
    
    histogramR = sum(imbinarize(obstacleMask), 2);
    histogramC = sum(imbinarize(obstacleMask), 1);
    
    % Binarize the histogram value to get the row number and column number,
    % Arb is arbitrary value
    Arb = 70;
    column = histogramC;
    column(column < Arb) = 0;
    column(column >= Arb) = 1;
    
    count_objectC = 0;
    object_width = 0;
    for j = 1:size(column,2)
        if (count_objectC == 0)
            % Detect the first obstacle
            if (column(j) == 1)
                count_objectC = count_objectC + 1;
                obstacleX(count_objectC) = j;
                object_width(count_objectC) = 0;
            end 
        else
            if (column(j-1) == 1 && column(j) == 1)
                object_width(count_objectC) = object_width(count_objectC) + 1;
            elseif (column(j-1) == 0 && column(j) == 1)
                count_objectC = count_objectC + 1;
                obstacleX(count_objectC) = j;
                object_width(count_objectC) = 0;
            end 
        end 
    end 
    
    row = histogramR;
    row(row < Arb) = 0;
    row(row >= Arb) = 1;

    count_objectR = 0;
    object_height = 0;
    for j = 1:size(row,1)
        if (count_objectR == 0)
            % Detect the first obstacle
            if (row(j) == 1)
                count_objectR = count_objectR + 1;
                obstacleY(count_objectR) = j;
                object_height(count_objectR) = 0;
            end 
        else
            if (row(j-1) == 1 && row(j) == 1)
                object_height(count_objectR) = object_height(count_objectR) + 1;
            elseif (row(j-1) == 0 && row(j) == 1)
                count_objectR = count_objectR + 1;
                obstacleY(count_objectR) = j;
                object_height(count_objectR) = 0;
            end 
        end 
    end 

    % Assgin vector for each object 
    if (count_objectC == 0)
        % No object detected!
        recVector = 0;
    else
        recVector = zeros(max(count_objectC, count_objectR),4);
        for n = 1:max(count_objectC, count_objectR)
            % Assign rectangle parameters x,y,w,h
            if ( n > count_objectC)
                recVector(n,1) = obstacleX(count_objectC);
                recVector(n,3) = object_width(count_objectC);                
            else 
                recVector(n,1) = obstacleX(n);
                recVector(n,3) = object_width(n);
            end
            if ( n> count_objectR)
                recVector(n,2) = obstacleY(count_objectR);
                recVector(n,4) = object_height(count_objectR);
            else 
                recVector(n,2) = obstacleY(n);
                recVector(n,4) = object_height(n);
            end 
        end 
    end 
    
    % Draw Square directly based on the histogram
    for i = 1:size(obstacleSquare, 1)
        for j = 1:size(obstacleSquare, 2)
            if (row(i) == 1 && column(j) == 1)
                obstacleSquare(i,j) = 1;
            end 
        end 
    end 

end