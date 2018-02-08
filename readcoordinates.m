%%
%DatabasePath:      Specify the destination from where the database of the
%                   coordinate has to be made.
%Returns:
%Coordinate:        Coordinate files in .mat format 
%nfiles:            Number of files read
%%
function [coordinate, nfiles] = readcoordinates(DatabasePath)
%%
%Read and save coordinate from the files:
%save the coordinate in in binary and txt format with the name
%coordinate.mat and coordinate.txt and dimension as number of images x 10

imagefiles = dir(strcat(DatabasePath,'*.txt'));
nfiles = length(imagefiles);   % Number of files found
coordinate = zeros(nfiles,10);    
for index = 1:5:nfiles %as there are 5 test images in each case
%     averageimage = zeros(l,b);

    for i = 0:4
        img_idx = index + i;
        if img_idx <= nfiles
            % read files from directory
            %fprintf('Hello')
            currentfilename = imagefiles(img_idx).name;
            currentfilename = strcat(DatabasePath,currentfilename);
            coordinate(img_idx,1:10) = textread(currentfilename, '%f',10);
        end
    end
end

%save file to disk
save('coordinate.txt','coordinate','-ascii');
type('coordinate.txt');
%in binary format
save 'coordinate.mat' coordinate;

end