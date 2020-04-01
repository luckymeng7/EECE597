% Reads in the frames
% input:
%   bagPath: the path to the bag file recorded by realsense
%   limitDistance: the distance threshold for obstacle, in milimeter
%   output: video name for the output video
% output: 
%   
function [] = objectDetect(bagPath,limitRangeLow, limitRangeHigh, output)
    inputVideo = rosbag(bagPath);
    bSel = select(inputVideo, 'Topic', '/device_0/sensor_0/Depth_0/image/data');
    bSel_color = select(inputVideo, 'Topic', '/device_0/sensor_1/Color_0/image/data');
    imgFrames = readMessages(bSel,'DataFormat','image');
    imgFrames_color = readMessages(bSel_color, 'DataFormat', 'image');
    
    videoHandler = VideoWriter(output);
    open(videoHandler);
    % Loop through each of the frames and draw the mask 
    for i = 1:(size(imgFrames_color)) 
        img = readImage(imgFrames{i});
        img_color = readImage(imgFrames_color{i});
        
        % Create the mask upon obstacle detection, distance bellow
        % limitDistance mm
        obstacleMask = img;
        obstacleMask (obstacleMask > limitRangeHigh | obstacleMask < limitRangeLow) = 0;
        obstacleMask (obstacleMask < limitRangeHigh & obstacleMask > limitRangeLow) = 100;
        %obstacleMask (obstacleMask > limitRangeHigh) = 2;   % Save the info for pixels larger than limitDistance as 2
        
        [obstacleSquare, recVector] = maskToSquare(obstacleMask);
        
        % Add the mask to the RGB image
        obstacle_mask_ON_RGB = img_color;
        obstacle_mask_ON_RGB(:,:,1) = obstacle_mask_ON_RGB(:,:,1) + im2uint8(obstacleMask*100); 
        
        % Add the rectangles to the RGB image
        rec_on_RGB = img_color;
        rec_on_depth = mat2gray(img);
        for nRec = 1 : size(recVector, 1) 
            rec_on_RGB = insertShape(rec_on_RGB, 'Rectangle', [recVector(nRec,1) recVector(nRec,2) recVector(nRec,3) recVector(nRec,4)], 'LineWidth', 5, 'Color', 'red');
            rec_on_depth = insertShape(rec_on_depth, 'Rectangle', [recVector(nRec,1) recVector(nRec,2) recVector(nRec,3) recVector(nRec,4)], 'LineWidth', 5, 'Color', 'red');
        end 
        % Combine the images back to vedio 
        writeVideo(videoHandler,rec_on_RGB);
        %writeVideo(videoHandler,rec_on_depth);
        
        % Measurement, based on the FOV from datasheet for depth camera and
        % depth value of the center of the rectangle
        width = zeros(size(recVector, 1));
        height = zeros(size(recVector, 1));
        for nRec = 1 : size(recVector, 1) 
            % FOV?? [74,62] or [86,57] ??
            width(nRec) = recVector(nRec,3)/size(img, 2) * tan(74 * pi/180) * img((recVector(nRec,2)+uint16(floor(recVector(nRec,4)/2))), (recVector(nRec,1)+uint16(floor(recVector(nRec,3)*2/3))));
            height(nRec) = recVector(nRec,4)/size(img, 1) * tan(62 * pi/180) * img((recVector(nRec,2)+uint16(floor(recVector(nRec,4)/2))), (recVector(nRec,1)+uint16(floor(recVector(nRec,3)*2/3))));
           
            % Print out the width and height for objects in first frame 
            if (i == 1)
                fprintf('Obstacle %i width: %d mm\n', nRec, width(nRec))
                fprintf('Obstacle %i height: %d mm\n', nRec, height(nRec))
            end
        end 
        
        % Plot the 1st Frame
        if (i==1)
            % Get the top View sketch 
            topview = topView(img, 2000);
            % Show this as image, last frame , to be removed and cleaned up
            figure 
            subplot(2,3,1)
            depthImg = mat2gray(img);
            imshow(depthImg) 
            title ('Depth image in gray scale')
%             subplot(2,3,2)
%             imshow(img_color)
%             title ('Regular RGB image')
            subplot(2,3,2)
            obstacle_mask_gray = mat2gray(obstacleMask);
            imshow(obstacle_mask_gray)
            title ('Detect Obstacle area')
            subplot(2,3,3)
            imshow(topview)
            hold on 
            set(gca,'YDir','normal')
            title ('Topview of the depth Img')
            subplot(2,3,4)
            imshow(obstacle_mask_ON_RGB)
            title ('Obstacle mask on RGB image')
            subplot(2,3,5)
            imshow(rec_on_RGB)
            title ('Rectangle on RGB image')
            subplot(2,3,6)
            imshow(rec_on_depth)
            title ('Rectangle on depth image')
            subplot
            
        end 
    
    end 
    close(videoHandler);
end 