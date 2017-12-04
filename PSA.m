function [meanFace, weights, u] = PSA()
k = 16;
n1 = 0;
n2 = 0;

% Read in all images and put them in an array
Images = [];
for i = 1:k
    if (i < 10) 
        filename = strcat(strcat('DB1/db1_0',num2str(i)),'.jpg');
    else
        filename = strcat(strcat('DB1/db1_',num2str(i)),'.jpg');
    end
    
    if ~exist(filename, 'file')
        continue;
    end
    
    im = rgb2gray(im2double(grayWorldCompensation(FaceDetect(imread(filename)))));
    [n1, n2] = size(im);
    Images(:, i) = im(:);
end

% Create the mean face
meanFace = mean(Images, 2);

% Subtract mean face from each face.
Diff2MeanFace = Images-meanFace;

% Find the eigen faces u
[eigenVectors,~] = eigs(transpose(Diff2MeanFace)*Diff2MeanFace, k);
u = Diff2MeanFace*eigenVectors;

% NOT NEEDED, just to show the eigen faces
% for i = 1:k
%     first = reshape(u(:,i),[n1, n2]);    
%     figure
%     imshow(first,[]);
% end

% Calculate the weights
weights = transpose(u)*Diff2MeanFace;

% NOT NEEDED, just to check how to
% reconstruct an image in the database
% I = meanFace + u*weights(:,5);
% I = reshape(I, [n1,n2]);
% figure
% imshow(I, [])

end





