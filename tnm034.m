function id = tnm034(im)

    % Transform colorspace to YCbCr
    YCbCr = rgb2ycbcr(im);
    
    % Find eyeMap
    eyeMapC = EyeMapC(YCbCr);
    eyeMapL = EyeMapL(YCbCr);
    eyeMap = eyeMapL .* eyeMapC;
    
    % Find mouthMap
    mouthMap = getMouthMap(YCbCr);
    mouthMap = mouthMap./max(max(mouthMap));
    imshow(mouthMap);
    
    % Find faceMask
    thres = 130;
    faceMask = getFaceMask(YCbCr, thres);
    
    % Combo of eyeMap and faceMask
    maskedEyeMap = eyeMap.*faceMask;
    figure
    imshow(im2double(im).*faceMask);
    
    brightestPoint = max(max(maskedEyeMap));
    
    maskedEyeMap = maskedEyeMap/brightestPoint;
    
    maskedEyeMap(maskedEyeMap < 0.8) = 0;
    
    figure
    imshow(maskedEyeMap);

    
    % Return placeholder
    id = 0;

end

