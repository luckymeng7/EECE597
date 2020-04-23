% Integrate the topView generated from object detection on to
% the path plan
% Input: 
%   topViewMask, 
%   initial variables: initial position, goal positio and step size
% Output:
%   updated path
function [path,planedTree, obstacle, planedPathIndex]= mapObject(initialPosition, goalPosition, maxStepSize, canvasSize, topViews)

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
    
    %   set the topview flag 
    isTopview = 1;
    debug = 0;

    %% First Path plan function
    % Get the info of first frame from topViews
    cRate = topViews.conversionRate;
    firstTopview = topViews.allFrames(:,:,1);
    firstTopview = imresize(firstTopview,cRate);
    % Direction for the first point is from initial to goal
    currentDirection = (goalPosition - initialPosition)/norm(goalPosition - initialPosition);
    [obstacleMask, ellipse] =  maskOnCanvas(canvasSize, firstTopview, initialPosition, currentDirection);
    obstacle = ellipse;
    while (1)
        [planedTree, planedPathCoordinate, planedPathIndex, pathFound] = pathPlan(initialTree, goalPosition, maxStepSize, ellipse, canvasSize, isTopview);
        if(pathFound)
            planedPathList = pathList;
            planedPathList.no = 1;
            planedPathList.listOfPath(1).path = planedPathCoordinate;
            break
        end
    end 
    
    path = planedPathCoordinate;
    if (debug)
        isFinal = 0;
        % Plot the initial plan
        % figure
        subplot(1,4,4)
        plotAll(planedTree, initialPosition, goalPosition, ellipse, planedPathCoordinate, isFinal, isTopview)
        title ('First path')
    end

    
end
