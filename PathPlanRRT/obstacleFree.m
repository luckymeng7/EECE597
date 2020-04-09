% Funtion to check if the node or the path to nearestNode is on obstacle
% passed obstacle
function free = obstacleFree(checkPosition,nearestNode,currentObstacle)
    free = true;  
    
%   if (isTopview)

    % Using method described in http://web.cvxr.com/cvx/examples/cvxbook/Ch08_geometric_probs/html/min_vol_elp_finite_set.html
    % To draw a minimum volume ellipsoid covering the mask
    A = currentObstacle(1:2,:);
    b = currentObstacle(3,:)';
    n = 2;
    
    % Check the distance to ellipsoid
    norm_distance = norms(A*checkPosition' + b*ones(1,n), 2);
    if (norm_distance(1) < 1 || norm_distance(1) == 1)
        free = false;
    end 

%         % Check if the node is on the obstacle, check each corner
%         ceilx = ceil(checkPosition(2));
%         ceily = ceil(checkPosition(1));
%         if (floor(checkPosition(2)) == 0)
%             floorx = 1;
%         else 
%             floorx = floor(checkPosition(2));
%         end
%         if (floor(checkPosition(1)) == 0)
%             floory = 1;
%         else
%             floory = floor(checkPosition(1));
%         end
%         corner_1 = currentObstacle(ceilx, ceily);
%         corner_2 = currentObstacle(floorx, ceily);
%         corner_3 = currentObstacle(floorx, floory);
%         corner_4 = currentObstacle(ceilx, floory);
%         
%         if (corner_1 == 1 || corner_2 == 1 || corner_3 == 1 || corner_4 == 1)
%             free = false;
%         end
        
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