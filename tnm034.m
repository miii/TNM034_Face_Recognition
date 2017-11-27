function id = tnm034(im)
    faceImage = FaceDetect(im);

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%% FACE RECOGNITION PIPELINE %%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % Get eigenfaces, weights and mean face of the database
    % USES MANUALLY RECONSTRUCTED IMAGES ATM, CHANGE LATER 
    % [meanFace, weights, u] = PSA();
    load('PSA/meanFace.mat');
    load('PSA/weights.mat');
    load('PSA/u.mat');
    
    % Face Recognition using the calculated weights and eigen faces.
    % USES MANUALLY RECONSTRUCTED IMAGE ATM, CHANGE LATER 
    newImage = rgb2gray(im2double(FaceDetect(im)));
    newImage = newImage(:);
    
    if length(newImage) ~= length(meanFace)
        id = 0;
        return;
    end

    newDiff2Mean = newImage - meanFace;
    newWeight = transpose(u)*newDiff2Mean;

    [minDiff, index] = min(sum(sqrt((weights-newWeight).^2)));
    
    minDiff
    
    %if minDiff > 0
    %    id = 0;
    %    return;
    %end
    
    % ADD CHECK OF minDiff TO BE ABLE TO REJECT A PERSON THAT DOES
    % NOT EXIST IN THE DATABASE.
    
    % Return placeholder
     id = index;

end

