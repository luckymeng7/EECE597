% Function to convert video to topView object
% Input:
%   videoPath
% Output: 
%   outputTopView, a topView object 
function outputTopView = vedioToTopview(videoPath, conversionRate)
    videoHandler = VideoReader(videoPath);
    outputTopView = topViewObject;
    outputTopView.conversionRate = conversionRate;
    outputTopView.frameNo = videoHandler.NumFrames;
    outputTopView.allFrames(:,:,1) = rgb2gray(read(videoHandler,1));
    for i = 1:outputTopView.frameNo
        outputTopView.allFrames(:,:,i) = rgb2gray(read(videoHandler, i));
    end 
end 