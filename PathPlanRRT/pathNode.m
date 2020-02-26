% Class for each of current node
classdef pathNode
    properties
        nodeIndex           % Individual index for each node
        parentNodeIndex     % Parent node index
        position            % Coordinates on (x,y)
        pathToNode          % Contains the index list from 0 to node
    end 
end 