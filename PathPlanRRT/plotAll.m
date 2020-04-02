%Plot the whole thing

function [] = plotAll(currentTree, initialPosition, goalPosition, currentObstacle, planedPath, isFinal, isTopview)

hold on 
% Draw canvas

% Draw obstacle circle

if (isTopview)
    %imshow(~currentObstacle);set(gca,'YDir','normal')
    [rows, columns] = size(currentObstacle);
    for i = 1:rows
        for j = 1:columns
            if ( currentObstacle(i, j) == 1)
                plot (i,j, 'g*')
            end 
        end 
    end 
else
    for i = 1:currentObstacle.no
        th = 0:pi/50:2*pi;
        xunit = currentObstacle.size(i) * cos(th) + currentObstacle.position(i,1);
        yunit = currentObstacle.size(i) * sin(th) + currentObstacle.position(i,2);
        plot(xunit, yunit)
    end 
end 

% Initial and final position
plot(initialPosition(1),initialPosition(2),'b*')
plot(goalPosition(1),goalPosition(2),'r*')

% Draw tree
if (isFinal==0)
    plot(currentTree.allNodesPosition(:,1),currentTree.allNodesPosition(:,2), '.');
    %comet(currentTree.allNodesPosition(:,1),currentTree.allNodesPosition(:,2));
end 

% Draw path
plot(planedPath(:,1),planedPath(:,2),'-x')

hold off
end