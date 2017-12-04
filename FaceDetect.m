function croppedImage = PrepareFace(im)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%% FACE DETECTION PIPELINE %%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    faceSize = zeros(461, 321, 3);
    
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

    % Find mouthMap
%     faceMaskYCbCr = rgb2ycbcr(im .* uint8(faceMask));
%     mouthMap = getMouthMap(faceMaskYCbCr);
%     mouthMap = NormalizeMap(mouthMap);

    % Combo of eyeMap and faceMask
    maskedEyeMap = eyeMap.*faceMask;

    %figure
    %imshow(im2double(im).*faceMask);

    eyes = FindEyes(maskedEyeMap);
    if (~isstruct(eyes))
        croppedImage = -1;
        return;
    end
    
    % Show detected eyes with red dots
%     eyesTemp = im * 0.15;
%     eyesTemp(eyes.p1(1), eyes.p1(2), :) = 255;
%     eyesTemp(eyes.p2(1), eyes.p2(2), :) = 255;
%     figure;
%     imshow(eyesTemp);
    
    [rotatedImage, rotationPoint] = RotateFace(im, eyes);
    
    [scaledImage, scale] = ScaleFace(rotatedImage, eyes);
    eyes.p1 = round(eyes.p1 .* scale);
    eyes.p2 = round(eyes.p2 .* scale);
    rotationPoint.x = round(rotationPoint.x .* scale);
    rotationPoint.y = round(rotationPoint.y .* scale);
    
    croppedImage = CropFace(scaledImage, rotationPoint);
    
    if (length(croppedImage(:)) ~= length(faceSize(:)))
        croppedImage = -1;
    end
end

