function [r, c] = BrightestPixel(Y)
    % For testing
    [r c] = find(Y >= max(Y(:))*0.9)
    
end

