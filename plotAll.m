%Plot the whole thing

function [] = plotAll(currentTree, initialPosition, goalPosition, obstaclePosition, ObstacleSize,planedPath)

hold on 
% Draw canvas
% Draw circle
th = 0:pi/50:2*pi;
xunit = ObstacleSize * cos(th) + obstaclePosition(1);
yunit = ObstacleSize * sin(th) + obstaclePosition(2);
plot(xunit, yunit)

% Initial and final position
plot(initialPosition(1),initialPosition(2),'b*')
plot(goalPosition(1),goalPosition(2),'r*')

% Draw tree
plot(currentTree.allNodesPosition(:,1),currentTree.allNodesPosition(:,2), '.');

% Draw path
plot(planedPath(:,1),planedPath(:,2),'-x')

hold off
end