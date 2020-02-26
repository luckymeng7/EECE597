% Find the nearest Node 
function nearestNode = nearest(currentTree, qRand)
    distanceToAllNodes = vecnorm((currentTree.allNodesPosition - qRand)');
    index = distanceToAllNodes == min(distanceToAllNodes);
    nearestNode = currentTree.allNodes(index);
end