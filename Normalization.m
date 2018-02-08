%%
%DataBasePath:      From where the input image has to be read
%NormalizePath:     Specify the Destination where you have to save the
%                   normalized image
%Coordinate:        Coordinate Matrix obtained from ReadCoordinate Files. Load the
%                   file before calling this Normalization File.
%nfiles:            Number of files in the destination path for loop iteration and
%                   reading all the files.
%Length and Width:  Size of the input image
%Returns:           save the normalized images in the specified folder.
%%
function Normalization(DatabasePath, normalize_path, coordinate, nfiles, Length, Width)

FixedPoints = [13,20; 50,20; 34,34; 16,50; 48,50];

for i = 1:nfiles
    A = FindTransformation(coordinate(i,:), FixedPoints);
    A_tform = maketform('affine',A.T);
    [currentfilename, currentimage] = readimages(DatabasePath, Length, Width, i); %reading image at every level
    Im_Updated = imtransform(currentimage,A_tform,'XData',[1 64],'YData',[1 64]);
    %Im_Updated = imwarp(currentimage,imref2d(size(currentimage),[1, 64],[1, 64]), A);
    savefilename = strcat(normalize_path,currentfilename);
    imwrite(Im_Updated,savefilename,'jpeg');
end

end