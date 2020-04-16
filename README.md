# Trajectory planning with real time vision-based obstacle detection
This project implemented object detected with RealSense camera with RRT trajectory plan algorithm, simulated in MATLAB environment. This project is done during UBC project course EECE597. Thanks for the supervision of Dr. Maryam Kamgarpour and Dr. Mahdi Yousefi. 

<img src="Integrate/Figure/Object_ellipse_pathplan.jpg" title="ellipse_on_path" width=60% height=50%/>

## Introduction to the repo
There are three main parts for this project: trajectory plan algorithm, obstacle dection with RGBD image processing, and integration of the detected obstacle to trajectory plan. 

The final report is [here](https://luckymeng7.github.io/EECE597/FinalReport/thesis.pdf).

Further instruction on UBC report template is [here](https://luckymeng7.github.io/EECE597/FinalReport/).

## Usage instruction
#### Packages need to be installed in MATLAB (Please contact me if other toolboxes needed):
- ROS Toolbox

#### To run the integrated result:
- Clone the whole repo to local 
- Nevigate to folder integrate and open one of the matlab scripts here
- Type this command in command window: __run("integrate_main.m")__
- Add any path needed to be included

## Progress logs 

### 1. Path planning with RRT, MATLAB (Feb 26, 2020)

<img src="PathPlanRRT/rrt_path.jpg" title="RRT_Path_Plan" width=30% height=30% />

### 2. Real-time path planning with RRT, add obstacle half way (March 4, 2020)

<img src="PathPlanRRT/onlineRRT.jpg" title="Online_RRT" width=30% height=30% />

__Acutal path__

<img src="PathPlanRRT/onlineRRT_actualPath.jpg" title="Actual path" width=30% height=30% />

__Another Example__

<img src="PathPlanRRT/onlineRRTmainOutput3.jpg" title="Actual path 2" width=70% height=70% />

### 3. Object Detection (March 11, 2020)

<img src="ObjectDetection/ObjectDetect_frame1.jpg" title="Object_Detection" width=90% height=90% />

### 4. Improvement on Object Detection (March 25, 2020)
<img src="ObjectDetection/ObjectDetect_w_Rect.jpg" title="Object_Detection_Improved" width=90% height=90% />

#### Top View image from depth info

<img src="ObjectDetection/ObjectDetect_topView.JPG" title="Top_View" width=30% height=30% />

### 5. Map the obstacle on path plan (Apr 1, 2020)

<img src="Integrate/Figure/object_mapped_on_pathplan_and_obstacle.jpg" title="object_on_path" width=100% height=90% />

### 6. Map the obstacle with an ellipse boundary (Apr 9, 2020)

<img src="Integrate/Figure/Object_ellipse_pathplan.jpg" title="ellipse_on_path" width=60% height=60% />
