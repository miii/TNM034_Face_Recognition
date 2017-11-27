function croppedImage = PrepareFace(im)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%% FACE DETECTION PIPELINE %%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % Gray World Compensation
    %im = grayWorldCompensation(im); %Perhaps use later?

    % Transform colorspace to YCbCr
    YCbCr = rgb2ycbcr(im);
    
    % Find eyeMap
    eyeMapC = EyeMapC(YCbCr);
    eyeMapL = EyeMapL(YCbCr);
    eyeMap = eyeMapL .* eyeMapC;
    eyeMap = NormalizeMap(eyeMap);
    
    % Find faceMask
    thres = 130;
    faceMask = getFaceMask(YCbCr, thres);
    
    faceMaskYCbCr = rgb2ycbcr(im .* uint8(faceMask));
    
    % Find mouthMap
    mouthMap = getMouthMap(faceMaskYCbCr);
    mouthMap = NormalizeMap(mouthMap);
    
    % Combo of eyeMap and faceMask
    maskedEyeMap = eyeMap.*faceMask;
    %figure
    %imshow(im2double(im).*faceMask);
    
    eyes = FindEyes(maskedEyeMap);
    
    [rotatedImage, rotationPoint] = RotateFace(im, eyes);
    
    [scaledImage, scale] = ScaleFace(rotatedImage, eyes);
    eyes.p1 = round(eyes.p1 .* scale);
    eyes.p2 = round(eyes.p2 .* scale);
    rotationPoint.x = round(rotationPoint.x .* scale);
    rotationPoint.y = round(rotationPoint.y .* scale);
    
    croppedImage = CropFace(scaledImage, rotationPoint);
end

