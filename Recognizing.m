clc
clear
%Reading the image:
load Vector.mat;
load Names.mat;
load averageimage;
A = S';
%Find the covariance matrix of the trainig matrix.
C = (S*S')/size(S,1);

%Eigen value of the covariance matrix.
[V, D] = eig(C);

%Arranging the eigenvalues 
L_eig_vec = [];
for i = 1 : size(V,2) 
    if( D(i,i)>0 )
        L_eig_vec = [L_eig_vec V(:,i)];
    end
end

%Finding the eigen faces of the image:
Eigenfaces = zeros(size(A,1),size(L_eig_vec,2));
for i = 1:size(L_eig_vec,2)
    Eigenfaces_n(:,i) = A * L_eig_vec(:,i);
    Eigenfaces(:,i) = Eigenfaces_n(:,i)/norm(Eigenfaces_n(:,i));
end
%Projected image according to each eigenface
ProjectedImages = [];
Train_Number = size(Eigenfaces,2);
for i = 1 : Train_Number
    temp = Eigenfaces'*A(:,i); % Projection of centered images into facespace
    ProjectedImages = [ProjectedImages temp]; 
end

%testing phase:
test_path = './testimage/'; %Location of the test folder
test_normalize_path = './testimage/normalize/';
[coordinate_test, nfiles] = readcoordinates(test_path);
save './testimage/coordinate_test.mat' coordinate_test

Normalization(test_path, test_normalize_path, coordinate_test, size(coordinate_test,1),320, 240);
count = 0;
o = [];
p = [];
for k = 1:nfiles
    [currentfilename, currentimage_test] = readimages(test_normalize_path, 64, 64, k); %reading image at every level
    currentimage_test = histeq(currentimage_test);
    temp = reshape(currentimage_test, 1, 64*64);
    S_test = temp-averageimage;
    ProjectedTestImage = Eigenfaces'*S_test';
    
    %Finding the Eucladian distance from each vector and finding the
    %minimum.
    Euc_dist = [];
    for i = 1 : Train_Number
        q = ProjectedImages(:,i);
        temp = ( norm( ProjectedTestImage - q ) )^2;
        Euc_dist = [Euc_dist temp];
    end

    [Euc_dist_min , Recognized_index] = min(Euc_dist);
    OutputName = Name(Recognized_index);

    Out = split(currentfilename,'5');
    out1 = string(Out(1));
    
    %Displaying the images not detected correctly
    if out1 == OutputName
        o = [o; out1];
    else
        count = count + 1;
        p = [p, out1];
    end
end
o
p
accuracy = (1-(count/nfiles))*100

% for i = 1:25
%     im = reshape(Eigenfaces_n(:,199-i),[64,64]);
%     subplot(5,5,i)
%     imshow(im)
% end
% for i = 1:5:200
%     im = reshape(A(:,i),[64,64]);cnt = cnt+1;
%     subplot(8,5,cnt)
%     imshow(im)
% end