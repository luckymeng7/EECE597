% Integrate the topView generated from object detection on to
% the path plan
% Input: 
%   topViewMask, 
%   initial variables: initial position, goal positio and step size
% Output:
%   updated path
function [path]= mapObject(initialPosition, goalPosition, maxStepSize, canvasSize, topViews)

    %% Some initialization 
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

    %% First Path plan function
    % Get the info of first frame from topViews
    cRate = topViews.conversionRate;
    firstTopview = topViews.allFrames(:,:,1);
    firstTopview = imresize(firstTopview,cRate);
    % Direction for the first point is from initial to goal
    currentDirection = (goalPosition - initialPosition)/norm(goalPosition - initialPosition);
    obstacleMask =  maskOnCanvas(canvasSize, firstTopview, initialPosition, currentDirection);
    
    while (1)
        [planedTree, planedPathCoordinate, planedPathIndex, pathFound] = pathPlan(initialTree, goalPosition, maxStepSize, obstacleMask, canvasSize);
        if(pathFound)
            planedPathList = pathList;
            planedPathList.no = 1;
            planedPathList.listOfPath(1).path = planedPathCoordinate;
            break
        end
    end 
    
    path = planedPathCoordinate;
    isFinal = 0;
    isTopview = 1; 
    % Plot the initial plan
    % figure
    subplot(1,3,3)
    plotAll(planedTree, initialPosition, goalPosition, obstacleMask, planedPathCoordinate, isFinal, isTopview)
    title ('First path')
    
    
    %% Start to move, update the tree as go (TBD)
    
end
