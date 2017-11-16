function map = EyeMapL(YCbCr)

    Y = im2double(YCbCr(:, :, 1));
    
    SE = strel('disk', 6);
    dilation = imdilate(Y, SE);
    erosion = imerode(Y, SE);
    map = dilation ./ (erosion + 1);

end