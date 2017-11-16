function [maskWithoutHoles] = getFaceMask(YCbCr, threshold)
    shadows = 255 - ((YCbCr(:, :, 3) + YCbCr(:, :, 2)));  
    chromaMerged = 1/2 * ((255 - YCbCr(:, :, 3)) + YCbCr(:, :, 2));
    mask = 255 - (chromaMerged + shadows);
    
    mask(mask < threshold) = 0;
    mask(mask >= threshold) = 255;
    
    figure
    imshow(mask)
    
    maskWithoutHoles = im2double(imfill(mask, 'holes'));
end

