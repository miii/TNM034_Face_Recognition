function [test] = FindEyes(eyeMap)
    pixelated = imresize(eyeMap, 0.25);
    % pixelated = imresize(eyeMap, 0.0625);
    
    BW = DynamicBinarize(pixelated, 10);
    
    % m = [0 1 0 0 0 0 0 0 0 0 0 0 0 1 0; 1 2 1 0 0 0 0 0 0 0 0 0 1 2 1; 0 1 0 0 0 0 0 0 0 0 0 0 0 1 0] ./ 10;
    % BW3 = conv2(double(BW), double(m), 'same');
    
    % BWmerged = (BW ./ 2 + BW3 ./ 2);
    % BWmergedBin = DynamicBinarize(BWmerged, 4);
    
    BW = eyeMap - imresize(BW, size(eyeMap));
    
    figure
    imshow(BW, 'InitialMagnification', 'fit')

    %figure
    %imshow(BWmergedBin, 'InitialMagnification', 'fit')
    
    test = 0;
end

