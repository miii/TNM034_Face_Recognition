function [compIm] = grayWorldCompensation(im)

    RscalVal=sum(sum(im(:,:,1)))/numel(im(:,:,1));
    GscalVal=sum(sum(im(:,:,2)))/numel(im(:,:,2));
    BscalVal=sum(sum(im(:,:,3)))/numel(im(:,:,3));
    
    R = im(:,:,1)*(127.5/RscalVal);
    G = im(:,:,2)*(127.5/GscalVal);
    B = im(:,:,3)*(127.5/BscalVal);
    
    compIm = cat(3,R,G,B);
    
end

