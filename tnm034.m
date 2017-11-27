function id = tnm034(im)

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%% FACE DETECTION PIPELINE %%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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
    
    faceMaskYCbCr = rgb2ycbcr(im .* uint8(faceMask));
    
    % Find mouthMap
    mouthMap = getMouthMap(faceMaskYCbCr);
    mouthMap = Normalize(mouthMap);
    
    % Combo of eyeMap and faceMask
    maskedEyeMap = eyeMap.*faceMask;
    %figure
    %imshow(im2double(im).*faceMask);
    
    FindEyes(maskedEyeMap);
    
    brightestPoint = max(max(maskedEyeMap));
    
    maskedEyeMap = maskedEyeMap/brightestPoint;
    
    maskedEyeMap(maskedEyeMap < 0.8) = 0;
    
    %figure
    %imshow(maskedEyeMap);


    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%% FACE RECOGNITION PIPELINE %%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % Get eigenfaces, weights and mean face of the database
    % USES MANUALLY RECONSTRUCTED IMAGES ATM, CHANGE LATER 
    [meanFace, weights, u] = PSA();
    
    % Face Recognition using the calculated weights and eigen faces.
    % USES MANUALLY RECONSTRUCTED IMAGE ATM, CHANGE LATER 
    newImage = rgb2gray(im2double(imread('DBegen/db1_05.jpg')));
    newImage = newImage(:);

    newDiff2Mean = newImage - meanFace;
    newWeight = transpose(u)*newDiff2Mean;

    [minDiff, index] = min(sum(sqrt((weights-newWeight).^2)));
    
    
    % ADD CHECK OF minDiff TO BE ABLE TO REJECT A PERSON THAT DOES
    % NOT EXIST IN THE DATABASE.
    
    % Return placeholder
    id = index;

end

