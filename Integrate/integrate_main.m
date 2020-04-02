% main function to run the integration funtion
clc;clear;

%% Initial Variables
%   initialPosition: x,y coordinates
initialPosition = [10 20];

%   goalPosition: x,y coordinates
goalPosition = [150 180];

%   maxStepSize: maximum movement of each iteration
maxStepSize = 2;

%   canvasSize: the size of the canvas
canvasSize = 200;

%   the ratio between the map and topView
conversionRate = 0.03125;

%   topView object
topView1 = vedioToTopview('../ObjectDetection/topview.avi', conversionRate);

%% Calculate the final path
finalPath = mapObject(initialPosition, goalPosition, maxStepSize, canvasSize, topView1);

%% Plot the path
% isFinal = 0;
% isTopview = 1;
% plotAll(planedTree, currentTree.rootNode.position, goalPosition, topView1, actualPath, isFinal, isTopview);