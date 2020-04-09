%Plot the whole thing

function [] = plotAll(currentTree, initialPosition, goalPosition, currentObstacle, planedPath, isFinal, isTopview)

hold on 
% Draw canvas

% Draw obstacle circle/ellipse

if (isTopview)
    %imshow(~currentObstacle);set(gca,'YDir','normal')
    %plot(currentObstacle(:,1),currentObstacle(:,2), 'g*');
    A = currentObstacle(1:2,:);
    b = currentObstacle(3,:)';
    
    noangles = 200;
    angles   = linspace( 0, 2 * pi, noangles );
    ellipse  = A \ [ cos(angles) - b(1) ; sin(angles) - b(2) ];
    plot(ellipse(1,:), ellipse(2,:), 'b-' );

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