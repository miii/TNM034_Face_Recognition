function bestPoint = FindEyes(eyeMap)
    pixelated = imresize(eyeMap, 0.25);
    
    BW = DynamicBinarize(pixelated, 10);
    BW = imresize(BW, size(eyeMap));
    
    B = bwboundaries(BW, 8);
    coord = [];
    
    for n = 1:length(B)
        x = mean(B{n}(:, 1));
        y = mean(B{n}(:, 2));
        
        coord = [coord; round([x y])];
    end
    
    points = [];
    
    for i = 1:length(coord)
        for j = (i+1):length(coord)
            delta = abs(coord(i, :) - coord(j, :));
            euclDist = sqrt(delta(1)^2 + delta(2)^2);
            
            point.p1 = coord(i, :);
            point.p2 = coord(j, :);
            point.delta = delta;
            point.eucl = euclDist;
            
            points = [points point];
        end
    end
    
    bestPoint = 0;
    
    for i = 1:length(points)
        if i == 1
            bestPoint = points(i);
        elseif bestPoint.delta(1) > points(i).delta(1)
            bestPoint = points(i);
        end
    end
end

