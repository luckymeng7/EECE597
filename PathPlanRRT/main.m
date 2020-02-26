% main function to run the pathPlan funtion
clc;clear;

%% Initial Variables
%   initialPosition: x,y coordinates
initialPosition = [10 10];

%   goalPosition: x,y coordinates
goalPosition = [80 80];

%   maxStepSize: maximum movement of each iteration
maxStepSize = 2;

%   obstaclePosition: center of the circle obstacle 
obstaclePosition = [30 50];

%   obstacleRadius: radius of the obstacle
obstacleRadius = 8;

%   canvasSize: the size of the canvas
canvasSize = 100;

%% Path plan function
[finalTree, planedPath] = pathPlan(initialPosition, goalPosition, maxStepSize, obstaclePosition, obstacleRadius, canvasSize);

%% Plotting 
plotAll(finalTree, initialPosition, goalPosition, obstaclePosition, obstacleRadius,planedPath)

