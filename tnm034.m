function id = tnm034(im)
    faceImage = FaceDetect(im);
    figure
    imshow(faceImage);

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%% FACE RECOGNITION PIPELINE %%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % Get eigenfaces, weights and mean face of the database
    % USES MANUALLY RECONSTRUCTED IMAGES ATM, CHANGE LATER 
    [meanFace, weights, u] = PSA();
    
    % Face Recognition using the calculated weights and eigen faces.
    % USES MANUALLY RECONSTRUCTED IMAGE ATM, CHANGE LATER 
    newImage = rgb2gray(im2double(imread('DBegen/db1_05.jpg')));
    newImage = newImage(:);

    newDiff2Mean = newImage - meanFace;
    newWeight = transpose(u)*newDiff2Mean;

    [minDiff, index] = min(sum(sqrt((weights-newWeight).^2)));
    
    
    % ADD CHECK OF minDiff TO BE ABLE TO REJECT A PERSON THAT DOES
    % NOT EXIST IN THE DATABASE.
    
    % Return placeholder
    id = index;

end

