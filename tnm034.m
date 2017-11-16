function id = tnm034(im)

    % Transform colorspace to YCbCr
    YCbCr = rgb2ycbcr(im);
    
    % Find eyeMap
    eyeMapC = EyeMapC(YCbCr);
    eyeMapL = EyeMapL(YCbCr);
    eyeMap = eyeMapL .* eyeMapC;
    eyeMap = Normalize(eyeMap);
    
    % Find faceMask
    thres = 130;
    faceMask = getFaceMask(YCbCr, thres);
    
    faceMaskYCbCr = rgb2ycbcr(faceMaskRGB .* uint8(faceMask));
    
    % Find mouthMap
    mouthMap = getMouthMap(faceMaskYCbCr);
    mouthMap = Normalize(mouthMap);
    
    figure
    imshow(eyeMap);
    
    figure
    imshow(mouthMap);
    
    % Combo of eyeMap and faceMask
    maskedEyeMap = eyeMap.*faceMask;
    %figure
    %imshow(im2double(im).*faceMask);
    
    brightestPoint = max(max(maskedEyeMap));
    
    maskedEyeMap = maskedEyeMap/brightestPoint;
    
    maskedEyeMap(maskedEyeMap < 0.8) = 0;
    
    %figure
    %imshow(maskedEyeMap);

    
    % Return placeholder
    id = 0;

end

