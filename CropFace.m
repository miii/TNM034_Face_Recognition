function croppedImage = CropFace(im, rotationPoint)
    diff = [230, 160];
    rp = [rotationPoint.y, rotationPoint.x];
    
    height = 2 * diff(1);
    width = 2 * diff(2);
    
    cropMinBoundary = rp - diff;
    cropMinBoundary(cropMinBoundary < 0) = 0;
    
    croppedImage = imcrop(im, [cropMinBoundary(2), cropMinBoundary(1), width, height]);
end

