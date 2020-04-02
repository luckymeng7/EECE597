% Funtion to check if the node or the path to nearestNode is on obstacle
% passed obstacle
function free = obstacleFree(checkPosition,nearestNode,currentObstacle)
    free = true;
%     if (isTopview)
        % Check if the node is on the obstacle 
        if (currentObstacle(ceil(checkPosition(2)), ceil(checkPosition(1))) == 1)
            free = false;
        end
        
        % TBD: Check if the path to nearest Node is on obstacle
         
%     else
%         for i = 1:currentObstacle.no
%             %Distance between obstacle center and the new node
%             distanceVector = checkPosition-currentObstacle.position(i,:);
%             distance = sqrt(distanceVector(1).^2 + distanceVector(2).^2 );
% 
%             %Check the node is not on obstacle
%             if ( distance < currentObstacle.size(i))
%                 free = false;
%             end 
% 
%             %Distance between the obstaclePosition and the vector between
%             %nodeCheck and nearestNode 
%             distanceLine = point_to_line_distance(currentObstacle.position(i,:),checkPosition,nearestNode.position);
% 
%             %Check the path from node to nearestNode is not cross the obstacle
%             if ( distanceLine < currentObstacle.size(i))
%                 free = false;
%             end 
%         end 
%     end
end