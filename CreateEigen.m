close all

n1 = 300;
n2 = 250;
k = 5;

% Read in all images and put them in an array
Images = zeros(n1*n2, k);
for i = 1:k
    if (i < 10) 
        filename = strcat(strcat('DBegen/db1_0',num2str(i)),'.jpg');
    else
        filename = strcat(strcat('DBegen/db1_',num2str(i)),'.jpg');
    end
    im = rgb2gray(im2double(imread(filename)));
    Images(:,i) = im(:);
end

% Create the mean face
meanFace = mean(Images, 2);

% Subtract mean face from each face.
Diff2MeanFace = Images-meanFace;

% Find the eigen faces u
[eigenVectors,~] = eigs(transpose(Diff2MeanFace)*Diff2MeanFace, k);
u = Diff2MeanFace*eigenVectors; 

% Show the eigen faces
for i = 1:k
    first = reshape(u(:,i),[n1,n2]);    
    %figure
    %imshow(first,[]);
end

% Calculate the weights
weights = transpose(u)*Diff2MeanFace;

% How to reconstruct an image in the database
I = meanFace + u*weights(:,5);
I = reshape(I, [n1,n2]);

figure
imshow(I, [])
