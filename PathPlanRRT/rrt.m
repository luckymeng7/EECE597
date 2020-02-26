% Created by xmli01
% RRT* algorithm
% Input: 
%   currentTree: the object of currentTree
% Output:
%   nextNode: the object of nextNode

function nextNode = rrt(currentTree,maxStepSize,obstaclePosition, obstacleSize, canvasSize)
    nextNode = pathNode;
    while (1)
        qRand = [canvasSize*rand(), canvasSize*rand()];
        nearestNode = nearest(currentTree, qRand);
        if (obstacleFree(qRand,nearestNode,obstaclePosition,obstacleSize))
            qNew = steer (nearestNode, qRand, maxStepSize);
            if (obstacleFree(qNew,nearestNode, obstaclePosition,obstacleSize))
                nextNode.position = qNew;
                break;
            end
        end 
    end 
    nextNode.nodeIndex = currentTree.indexSize + 1;
    nextNode.parentNodeIndex = nearestNode.nodeIndex;
    nextNode.pathToNode = [nearestNode.pathToNode nextNode.nodeIndex];
    
end 