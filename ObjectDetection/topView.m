% Get the top View sketch from the depth image
% Input:
%   Depth image
% Output: 
%   topview image, width same as depthImg, height as 3000 (3 meter)
function [topView] = topView(depthImg, depthSize)
    topView = zeros(depthSize, size(depthImg, 2));
    for i = 1: size(depthImg, 2)
        for j = 1:size(depthImg, 1)
            if (depthImg(j,i) < depthSize && depthImg(j,i) > 0)
                if (depthImg(j,i) > topView(depthImg(j,i), i))
                    topView(depthImg(j,i), i) = j;
                end 
            end 
        end 
    end 
end 