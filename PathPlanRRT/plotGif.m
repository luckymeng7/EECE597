% Temperory function to plot a gif 
function [] = plotGif (initialPosition, goalPosition,actualPath, planedPathList, currentObstacle, addObstacle)
    % Initial and final position
    plot(initialPosition(1),initialPosition(2),'b*')
    plot(goalPosition(1),goalPosition(2),'r*')

    for i = 1:size(actualPath,1)
        filename = 'animation.gif';

        del = 0.1; % time between animation frames
        
        % Draw obstacle circle and planed path
        if (i == 1)
            th = 0:pi/50:2*pi;
            xunit = currentObstacle.size(1) * cos(th) + currentObstacle.position(1,1);
            yunit = currentObstacle.size(1) * sin(th) + currentObstacle.position(1,2);
            plot(xunit, yunit)
            % Plot the planed path
            plot(planedPathList.listOfPath(1).path(:,1),planedPathList.listOfPath(1).path(:,2),'-x')
        end
        
        if (i == addObstacle(1))
            th = 0:pi/50:2*pi;
            xunit = currentObstacle.size(2) * cos(th) + currentObstacle.position(2,1);
            yunit = currentObstacle.size(2) * sin(th) + currentObstacle.position(2,2);
            plot(xunit, yunit)
            % Plot the planed path
            plot(planedPathList.listOfPath(2).path(:,1),planedPathList.listOfPath(2).path(:,2),'-x')
        end
        
        if (i == addObstacle(2))
            th = 0:pi/50:2*pi;
            xunit = currentObstacle.size(3) * cos(th) + currentObstacle.position(3,1);
            yunit = currentObstacle.size(3) * sin(th) + currentObstacle.position(3,2);
            plot(xunit, yunit)
            % Plot the planed path
            plot(planedPathList.listOfPath(3).path(:,1),planedPathList.listOfPath(3).path(:,2),'-x')
        end
        drawnow 
        
        frame = getframe(gca);
        im = frame2im(frame);
        [imind,cm] = rgb2ind(im,256);
        if i == 1
        imwrite(imind,cm,filename,'gif','Loopcount',inf,'DelayTime',del);
        else
        imwrite(imind,cm,filename,'gif','WriteMode','append','DelayTime',del);
        end
    end
end 