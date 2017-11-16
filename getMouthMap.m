function [map] = getMouthMap(YCbCr)

Cb = im2double(YCbCr(:,:,2));
Cr = im2double(YCbCr(:,:,3));

map = ((Cr./Cb)-(Cr.^2)).*(Cr.^2);


end

