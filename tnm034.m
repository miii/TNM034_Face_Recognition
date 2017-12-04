function id = tnm034(im)
    % Get eigenfaces, weights and mean face of the database
    % [meanFace, weights, u] = PSA();
    load('PSAg/meanFace.mat');
    load('PSAg/weights.mat');
    load('PSAg/u.mat');
    
    % Face Recognition using the calculated weights and eigen faces.
    detectedFace = FaceDetect(im);
    
    if detectedFace == -1
        id = 0;
        return;
    end
    
    faceImage = grayWorldCompensation(detectedFace);
    newImage = rgb2gray(im2double(faceImage));
    newImage2 = newImage(:);

    newDiff2Mean = newImage2 - meanFace;
    newWeight = transpose(u)*newDiff2Mean;

    [minDiff, index] = min(sum(sqrt((weights-newWeight).^2)));
    
    if minDiff > 3.25 * 10^3
       id = 0;
       return;
    end
    
    id = index;

end

