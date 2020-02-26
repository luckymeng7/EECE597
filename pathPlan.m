% Created by xmli01
% To find the path from initial position and goal position with path plan algorithm
% Inputs:
%   initialPosition: x,y coordinates
%   goalPosition: x,y coordinates
%   maxStepSize: maximum movement of each iteration
%   obstaclePosition: center of the circle obstacle 
%   obstacleRadius: radius of the obstacle
%   canvasSize: the size of the canvas
% Output:
%   path: the list of node position from initial to goal

function [finalTree, planedPathCoordinate] = pathPlan(initialPosition, goalPosition, maxStepSize, obstaclePosition, obstacleSize, canvasSize)
    % Initial Varibles
    maxIteration = 1000;
    count = 1;
    pathFound = 0;
    planedPath = 1;
    
    %originalNode = pathNode(0,0,initialPosition,planedPath);
    originalNode = pathNode;
    originalNode.nodeIndex = 0; originalNode.parentNodeIndex = 0; 
    originalNode.position = initialPosition; originalNode.pathToNode = planedPath;

    finalNode = pathNode;
    finalNode.position = goalPosition;
    
    currentTree = tree;
    currentTree.indexSize = 1;
    currentTree.allNodesPosition = originalNode.position;
    currentTree.allNodes = originalNode;
    
    while (count < maxIteration)
        nextNode = rrt(currentTree,maxStepSize,obstaclePosition, obstacleSize, canvasSize);
        currentTree.indexSize = currentTree.indexSize + 1;
        currentTree.allNodesPosition = [currentTree.allNodesPosition; nextNode.position];
        currentTree.allNodes = [currentTree.allNodes nextNode];
        count = count + 1;
        
        % Distance between goal and the nextNode
        distanceVector = nextNode.position - goalPosition;
        distance = sqrt(distanceVector(1).^2 + distanceVector(2).^2 );
        
        if ( distance < maxStepSize)
            if (obstacleFree(goalPosition,nextNode,obstaclePosition,obstacleSize))
                finalNode.nodeIndex = count + 1;
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
        fprintf('Path not found \n')
    end 
    
    finalTree = currentTree;
    planedPathCoordinate = currentTree.allNodesPosition([planedPath'],:);
    
    %plotAll(currentTree, initialPosition, goalPositio, obstaclePosition, ObstacleSize, planedPathCoordinate);
end 