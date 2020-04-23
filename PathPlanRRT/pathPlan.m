% Created by xmli01
%   To find the path from initial position and goal position with path plan algorithm
% Inputs:
%   initialPosition: x,y coordinates
%   goalPosition: x,y coordinates
%   maxStepSize: maximum movement of each iteration
%   obstaclePosition: center of the circle obstacle 
%   obstacleRadius: radius of the obstacle
%   canvasSize: the size of the canvas
% Output:
%   path: the list of node position from initial to goal
%
% Note:
%   In real time, the path would be updated after currentNode 
%   

function [finalTree, planedPathCoordinate, planedPathIndex, pathFound] = pathPlan(currentTree, goalPosition, maxStepSize, currentObstacle, canvasSize, isTopview)
    % Initial Varibles
    maxIteration = 2500;
    count = 1;
    pathFound = 0;
    
    finalNode = pathNode;
    finalNode.position = goalPosition;
    
    % Compare the current Node and current Path
    
    
    while (count < maxIteration)
        nextNode = rrt(currentTree,maxStepSize,currentObstacle, canvasSize,isTopview);
        currentTree.indexSize = currentTree.indexSize + 1;
        currentTree.allNodesPosition = [currentTree.allNodesPosition; nextNode.position];
        currentTree.allNodes = [currentTree.allNodes nextNode];
        count = count + 1;
        
        % Distance between goal and the nextNode
        distanceVector = nextNode.position - goalPosition;
        distance = sqrt(distanceVector(1).^2 + distanceVector(2).^2 );
        
        if ( distance < maxStepSize)
            if (obstacleFree(goalPosition,nextNode,currentObstacle,isTopview))
                finalNode.nodeIndex = currentTree.indexSize + 1;
                finalNode.pathToNode = [nextNode.pathToNode finalNode.nodeIndex];
                currentTree.indexSize = currentTree.indexSize + 1;
                currentTree.allNodesPosition = [currentTree.allNodesPosition; finalNode.position];
                currentTree.allNodes = [currentTree.allNodes finalNode];
                pathFound = 1;
                break;
            end
        end  
    end 
    
    if (pathFound)
        planedPath = finalNode.pathToNode;
        fprintf('Path found \n')
    else
        planedPath = 1;
        fprintf('Path not found \n')
    end 
    
    finalTree = currentTree;
    planedPathIndex = planedPath;
    planedPathCoordinate = currentTree.allNodesPosition([planedPath'],:);
    
    %plotAll(currentTree, initialPosition, goalPositio, obstaclePosition, ObstacleSize, planedPathCoordinate);
end 