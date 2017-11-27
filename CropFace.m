function croppedImage = CropFace(im, rotationPoint)
    diff = [230, 160];
    rp = [rotationPoint.y, rotationPoint.x];
    
    width = 2 * diff(2);
    height = 2 * diff(1);
    
    cropMinBoundary = rp - diff;
    cropMinBoundary(cropMinBoundary < 0) = 0;
    
    croppedImage = imcrop(im, [cropMinBoundary(1), cropMinBoundary(2), width, height]);
    
%     temp = im;
%     mask = zeros(size(temp));
%     mask(cropMinBoundary(1):(cropMinBoundary(1) + height), cropMinBoundary(2):(cropMinBoundary(2) + width), :) = 1;
%     
%     temp = im2double(temp) .* mask;
%     
%     figure
%     imshow(temp);
end

