clear all
close all
clc

% k = 16;
% k = 4;
k = 16;

for i = 1:k
    filename = strcat(strcat('DB1/db1_', pad(num2str(i), 2, 'left', '0')),'.jpg');
    % filename = strcat(strcat('DB0/db0_', num2str(i),'.jpg'));
    % filename = strcat(strcat('DB2/il', pad(num2str(i), 2, 'left', '0')),'.jpg');
    
    if ~exist(filename, 'file')
        continue;
    end
    
    im = imread(filename);
   
    id = tnm034(im);
    res = [i, id]
    
end