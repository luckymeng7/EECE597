% Funtion to check if the node is on obstacle or the path to nearestNode
% passed obstacle
function free = obstacleFree(checkPosition,nearestNode,obstaclePosition,obstacleSize)
    free = true;
    
    % Distance between obstacle and the new node
    distanceVector = checkPosition-obstaclePosition;
    distance = sqrt(distanceVector(1).^2 + distanceVector(2).^2 );
    
    % Check the node is not on obstacle
    if ( distance < obstacleSize)
        free = false;
    end 
    
    % Distance between the obstaclePosition and the vector between
    % nodeCheck and nearestNode 
    distanceLine = point_to_line_distance(obstaclePosition,checkPosition,nearestNode.position);
    
    % Check the path from node to nearestNode is not cross the obstacle
    if ( distanceLine < obstacleSize)
        free = false;
    end 
end