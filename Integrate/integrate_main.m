% main function to run the integration funtion
clc;clear;

%% Initial Variables
%   initialPosition: x,y coordinates
initialPosition = [10 20];

%   goalPosition: x,y coordinates
goalPosition = [150 180];

%   maxStepSize: maximum movement of each iteration
maxStepSize = 2;

%   canvasSize: the size of the canvas
canvasSize = 200;

%   the ratio between the map and topView
conversionRate = 0.03125;

%   topView objects
topView(1) = vedioToTopview('../ObjectDetection/topview1.avi', conversionRate);
topView(2) = vedioToTopview('../ObjectDetection/topview2.avi', conversionRate);
topView(3) = vedioToTopview('../ObjectDetection/topview3.avi', conversionRate);

%   rate of update
updateRate = 20;

% Initialize the Actual Path
actualPath = initialPosition;

%% Calculate the final path
[firstPath, planedTree, obstacle1,planedPathIndex] = mapObject(initialPosition, goalPosition, maxStepSize, canvasSize, topView(1));

%% Plot the path
isFinal = 0;
isTopview = 1;
% plotAll(planedTree, currentTree.rootNode.position, goalPosition, topView1, actualPath, isFinal, isTopview);

% Plot the initial plan
figure 
subplot(1,4,1)
plotAll(planedTree, initialPosition, goalPosition, obstacle1, firstPath, isFinal, isTopview)
title ('First path')

%% Start to move, update the tree as go, read in a new videoFrame every "updateRate" steps
stepCount = 0;
updateCount = 1;
while(1)
    % initialize the local variables
    stepCount = stepCount + 1;
    obstacleChanged = 0;
     
    % obtain the current position
    currentNode = planedTree.allNodes(planedPathIndex(stepCount));

    actualPath = [actualPath; currentNode.position];
    
    if (currentNode.position == goalPosition)
        break;
    end 

    % Note: to be modified to accomodate more detections
    if (stepCount > updateRate && updateCount < 3)
        stepCount = 0;
        updateCount = updateCount + 1;
        obstacleChanged = 1;
    end
    
    % Update the path with the new obstacle detected
    % Could add compare the obstacles later, but for now, will update the
    % obstcle every time when reading new video
    
    if (obstacleChanged)
        
        % Recalculate the path 
        [updatedPath, planedTree, obstacle, planedPathIndex] = mapObject(currentNode.position, goalPosition, maxStepSize, canvasSize, topView(updateCount));
        subplot(1,4,updateCount)
        plotAll(planedTree, currentNode.position, goalPosition, obstacle, updatedPath, isFinal, isTopview)
        title ('Updated path')
        
    end 

end 

isFinal = 1;
subplot(1,4,4)
plotAll(planedTree, initialPosition, goalPosition, obstacle, actualPath, isFinal, isTopview)
title('Final path')