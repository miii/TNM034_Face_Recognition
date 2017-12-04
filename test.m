clear all
close all
clc

k = 16;

for i = 1:k
    % Use reference images
    % filename = strcat(strcat('DB1/db1_', pad(num2str(i), 2, 'left', '0')),'.jpg');
    
    % Use images of persons that is not in the database
    % filename = strcat(strcat('DB0/db0_', num2str(i),'.jpg'));
    
    % Use images of reference faces with different light conditions etc.
    filename = strcat(strcat('DB2/il_', pad(num2str(i), 2, 'left', '0')),'.jpg');
    
    if ~exist(filename, 'file')
        continue;
    end
    
    im = imread(filename);
   
    id = tnm034(im);
    res = [i, id]
    
end