function map = EyeMapC(YCbCr)
    
    Cb = im2double(YCbCr(:, :, 2));
    Cr = im2double(YCbCr(:, :, 3));
    
    map = 1/3 * ((Cb.^2) + (1-Cr) + (Cb./(Cr+1)));

end

