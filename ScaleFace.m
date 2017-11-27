function [scaledImage, scale] = ScaleFace(im, eyes)
    scale = 150 / eyes.eucl;
    scaledImage = imresize(im, scale);
end

