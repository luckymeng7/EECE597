% Move towards the qRand from qNearest for maxStepSize
% Output: the steered position
function qNew = steer (nearestNode, qRand, maxStepSize)
    diff = qRand - nearestNode.position;
    qNew = nearestNode.position + (diff * maxStepSize / norm(diff));
end 