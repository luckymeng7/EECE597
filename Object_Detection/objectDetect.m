% Reads in the frames
% input:
%   bagPath: the path to the bag file recorded by realsense
%   limitDistance: the distance threshold for obstacle, in milimeter
function [] = objectDetect(bagPath,limitDistance,output)
    inputVideo = rosbag(bagPath);
    bSel = select(inputVideo, 'Topic', '/device_0/sensor_0/Depth_0/image/data');
    bSel_color = select(inputVideo, 'Topic', '/device_0/sensor_1/Color_0/image/data');
    imgFrames = readMessages(bSel,'DataFormat','image');
    imgFrames_color = readMessages(bSel_color, 'DataFormat', 'image');
    
    videoHandler = VideoWriter(output);
    open(videoHandler);
    % Loop through each of the frames and draw the mask 
    for i = 1:(size(imgFrames)-1)
    % for i = 2   
        img = readImage(imgFrames{i});
        img_color = readImage(imgFrames_color{i});
        
        % Create the mask upon obstacle detection, distance bellow
        % limitDistance mm
        obstacle_mask = img;
        obstacle_mask (obstacle_mask < limitDistance & obstacle_mask~=0) = 100;
        obstacle_mask (obstacle_mask > limitDistance) = 2;   % Save the info larger than 1.5m as 2
        %obstacle_mask (obstacle_mask == 1) = 2000;
        
        % Add the mask to the RGB image
        obstacle_mask_ON_RGB = img_color;
        obstacle_mask_ON_RGB(:,:,1) = obstacle_mask_ON_RGB(:,:,1) - im2uint8(obstacle_mask*100);        
        obstacle_mask_ON_RGB(:,:,2) = obstacle_mask_ON_RGB(:,:,2) - im2uint8(obstacle_mask*100);
        obstacle_mask_ON_RGB(:,:,3) = obstacle_mask_ON_RGB(:,:,3) - im2uint8(obstacle_mask*100);
        % Combine the images back to vedio 
        
        writeVideo(videoHandler,obstacle_mask_ON_RGB);
    end 
    close(videoHandler);
     
    % Show this as image
%     figure 
%     subplot(2,2,1)
%     depthImg = mat2gray(img);
%     imshow(depthImg) 
%     title ('Depth image in gray scale')
%     subplot(2,2,2)
%     imshow(img_color)
%     title ('Regular RGB image')
%     subplot(2,2,3)
%     obstacle_mask_gray = mat2gray(obstacle_mask);
%     imshow(obstacle_mask_gray)
%     title ('Detect Obstacle area')
%     subplot(2,2,4)
%     imshow(obstacle_mask_ON_RGB)
%     title ('Obstacle mask on RGB image')
    
end 