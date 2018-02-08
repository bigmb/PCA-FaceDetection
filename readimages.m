%%
%Input Parameters:
%DatabasePath:          Folder Path from where images have to be read.
%l,b:                   Length and Width of image
%im_number:             Read the desired image with a particular index no.

%Output Parameters:
%Currentfilename:       Returns the name of the file
%currentimage:          Returns the image of the specified index number.
%%
function [currentfilename, currentimage] = readimages(DatabasePath,l,b,im_number)

imagefiles = dir(strcat(DatabasePath,'*.jpg'));
nfiles = length(imagefiles);   % Number of files found

S = [];
    
for index = 1:nfiles

    %averageimage = zeros(l,b);
    if (index==im_number)
        index
        % read images from directory
        currentfilename = imagefiles(index).name;
        currentfilename2 = strcat(DatabasePath,currentfilename);
        currentimage = im2double(imread(currentfilename2));
        if ndims(currentimage)>2 %To check the gray level image
            currentimage = rgb2gray(im2double(imread(currentfilename2)));
        end
        [l1, b1] = size(currentimage);
        if l1~=l || b1~=b
            currentimage = imresize(currentimage, [l,b]);
        end
%             temp = reshape(currentimage, 1, l*b);
%             averageimage = averageimage + .2*currentimage;
%             m = mean(temp);
%             S = [S; temp-m];
    end
    
    %save file to disk
%     savefilename = strcat(savepath,currentfilename);
%     imwrite((averageimage),savefilename,'jpeg');
end

end