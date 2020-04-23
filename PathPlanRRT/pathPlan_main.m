% main function to run the pathPlan funtion
% To run this code, need to go to function obstacleFree.m and uncomment the
% part for non topView version
clc;clear;

%% Initial Variables
%   initialPosition: x,y coordinates
initialPosition = [10 10];

%   goalPosition: x,y coordinates
goalPosition = [80 80];

%   maxStepSize: maximum movement of each iteration
maxStepSize = 2;

%   Initialize the obstacles 
initialObstacle = obstacle;
initialObstacle.no = 1;
initialObstacle.size = 6;
initialObstacle.position = [30 50];

%   canvasSize: the size of the canvas
canvasSize = 100;

%   originalNode: Node at start point
initalPath = 1;
originalNode = pathNode;
originalNode.nodeIndex = 0; originalNode.parentNodeIndex = 0; 
originalNode.position = initialPosition; originalNode.pathToNode = initalPath;

%   initialTree: Tree at start point
initialTree = tree;
initialTree.indexSize = 1;
initialTree.rootNode = originalNode;
initialTree.allNodesPosition = originalNode.position;
initialTree.allNodes = originalNode;

% Initialize the Actual Path
actualPath = initialPosition;

% Speed of movement, step on planned path for each iteration
speed = 1;
stepCount = 0;
obstacleChangeCount = 0;
obstacle_changed = 0;

% Add additional obstacles at the following iteration
addObstacle(1) = 10;
addObstacle(2) = 40;

% Flag and counter for obstacle update
obstacleUpdate = 1;
isFinal = 0;

% This demo not includes the topView
isTopview = 0;

%% First Path plan function
while (1)
    [planedTree, planedPathCoordinate,planedPathIndex,pathFound] = pathPlan(initialTree, goalPosition, maxStepSize, initialObstacle, canvasSize, isTopview);
    if(pathFound)
        planedPathList = pathList;
        planedPathList.no = 1;
        planedPathList.listOfPath(1).path = planedPathCoordinate;
        break
    end 
end

% Plot the initial plan
figure
subplot(2,2,1)
plotAll(planedTree, initialPosition, goalPosition, initialObstacle, planedPathCoordinate, isFinal, isTopview)
title ('First path')

%% Start to Move, update the tree and path for each iteration
while (1)
    
    % Obtain the current position
    if (stepCount <= addObstacle(1))
        currentNode = planedTree.allNodes(planedPathIndex(stepCount*speed+1));
    elseif (stepCount <= addObstacle(2))
        currentNode = planedTree.allNodes(planedPathIndex((stepCount-addObstacle(1))*speed+1));
    else
        currentNode = planedTree.allNodes(planedPathIndex((stepCount-addObstacle(2))*speed+1));
    end 
    
    actualPath = [actualPath; currentNode.position];
    
    if (currentNode.position == goalPosition)
        break;
    end 
    
    obstacle_changed = 0;
    % Arbitrarily add Obstacle, to be modified as real time 
    if (stepCount == addObstacle(1))
        currentObstacle = obstacle;
        currentObstacle.no = 2;
        currentObstacle.size = [6 8];
        currentObstacle.position = [30 50;40 30];
        obstacle_changed = 1;
        obstacleChangeCount = obstacleChangeCount+1;
        
    elseif ((stepCount == addObstacle(2)))
        currentObstacle = obstacle;
        currentObstacle.no = 3;
        currentObstacle.size = [6 8 10];
        currentObstacle.position = [30 50; 40 30; 60 70];
        obstacle_changed = 1;  
        obstacleChangeCount = obstacleChangeCount+1;
        
    end 
    
    % Change the path until obstacle change detected
    if (obstacle_changed)  
        obstacleUpdate = obstacleUpdate + 1;
        
        % initialize for the new tree
        currentNode.pathToNode = initalPath;
        currentTree = tree;
        currentTree.indexSize = 1;
        currentTree.rootNode = currentNode;
        currentTree.allNodesPosition = currentNode.position;
        currentTree.allNodes = currentNode;

        % Recalculate the path
        while(1)
            [planedTree, planedPathCoordinate,planedPathIndex,pathFound] = pathPlan(currentTree, goalPosition, maxStepSize, currentObstacle, canvasSize, isTopview);
            if(pathFound)
                planedPathList.no = obstacleChangeCount+1;
                planedPathList.listOfPath(obstacleChangeCount+1).path = planedPathCoordinate;
                break
            end 
        end
        subplot(2,2,obstacleUpdate)
        plotAll(planedTree, currentTree.rootNode.position, goalPosition, currentObstacle, planedPathCoordinate, isFinal, isTopview)
        title('Update path when obstacle detected')
    end

    stepCount = stepCount+1;
    
end 

%plotGif(initialPosition, goalPosition, actualPath, planedPathList, currentObstacle, addObstacle);

isFinal = 1;
subplot(2,2,4)
plotAll(planedTree, currentTree.rootNode.position, goalPosition, currentObstacle, actualPath, isFinal, isTopview)
title('Final path')