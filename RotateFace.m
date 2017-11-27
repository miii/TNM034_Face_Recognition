function [rotated, rotationPoint] = RotateFace(im, eyes)
    rotationPoint.y = round(mean([eyes.p1(1) eyes.p2(1)]));
    rotationPoint.x = round(mean([eyes.p1(2) eyes.p2(2)]));
    
    if eyes.p1(2) > eyes.p2(2)
        rightEye = eyes.p1;
    else
        rightEye = eyes.p2;
    end
    
    dy = (rightEye(1) - rotationPoint.y);
    dx = (rightEye(2) - rotationPoint.x);
    
    [theta] = cart2pol(dx, dy);
    rotated = rotateAround(im, rotationPoint.y, rotationPoint.x, (360 * theta / (2 * pi)));
end

