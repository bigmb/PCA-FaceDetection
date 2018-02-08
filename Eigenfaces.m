clc
close all
clear
%%
%Delete Previously saved variables
delete('Vector.mat');
delete('Names.mat');
delete('averageimage.mat');
%%
%Read Images from database path and save them
DatabasePath = './faces_features/';
normalize_path = './normalization/';
average_path = './average/';
Length = 320;
Width = 240;

%%
%Read and save coordinate from the files:
%save the coordinate in in binary and txt format with the name
%coordinate.mat and coordinate.txt and dimension as number of images x 10 
imagefiles = dir(strcat(DatabasePath,'*.jpg'));
nfiles = length(imagefiles); 
readcoordinates(DatabasePath);

%%
%Affine transformation of the images and normalization:

load coordinate.mat;
Normalization(DatabasePath, normalize_path, coordinate, size(coordinate,1),Length, Width);

%%
%average of all the image:(Preparing Ghost Image)
imagefiles = dir(strcat(normalize_path,'*.jpg'));
%nfiles = length(imagefiles);   % Number of files found
S=[];
Name = [];
m=0;
No_Training = 5; %Number of Training Image for each face
averageimage = zeros(64,64);
for index = 1:No_Training:nfiles
    
    for i = 0:No_Training-1
        img_idx = index + i;
        if img_idx <= nfiles
            [currentfilename, currentimage] = readimages(normalize_path, 64, 64, img_idx); %reading image at every level
            temp_currentfilename = split(currentfilename,string(sum(i+1)));
            currentfilename1 = string(temp_currentfilename(1));
            currentimage = histeq(currentimage);
            averageimage = averageimage + currentimage;
%             m = mean(mean(averageimage));
            temp = reshape(currentimage, 1, 64*64);
            S = [S; temp];
            Name = [Name; string(currentfilename1)];
        end
    end

    savefilename = strcat(average_path,currentfilename,'.jpg');
    imwrite(averageimage,savefilename,'jpeg');

end
averageimage = averageimage/nfiles;
averageimage = reshape(averageimage, 1, 64*64);
S = S-averageimage;
save 'Vector.mat' S;
save 'Names.mat' Name;
save 'averageimage.mat' averageimage;
 

