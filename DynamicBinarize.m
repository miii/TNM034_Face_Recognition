function BW = DynamicBinarize(im, sumThres)
    thres = 0;
    stepSize = 1;
    
    while true
        thres = thres + stepSize;
        BW = imbinarize(im, thres * (1 / 256));
        pixelSum = sum(sum(BW));
        
        if pixelSum <= sumThres
            break;
        end
    end
    
    BW = im .* BW;
end

