# PCA-FaceDetection

Project done in Matlab - 1st Semester Project

Eigenfaces is the name given to a set of eigenvectors when they are used in the computer vision problem of human face recognition.The eigenvectors are derived from the covariance matrix of the probability distribution over the high-dimensional vector space of face images. The eigenfaces themselves form a basis set of all images used to construct the covariance matrix. This produces dimension reduction by allowing the smaller set of basis images to represent the original training images. Classification can be achieved by comparing how faces are represented by the basis set.

PCA is a statistical approach used for reducing the number of variables in face recognition. In PCA, every image in the training set is represented as a linear combination of weighted eigenvectors called eigenfaces. These eigenvectors are obtained from covariance matrix of a training image set. The weights are found out after selecting a set of most relevant Eigenfaces. Recognition is performed by projecting a test image onto the subspace spanned by the eigenfaces and then classification is done by measuring minimum Euclidean distance. A number of experiments were done to evaluate the performance of the face recognition system.

<img src="https://github.com/bigmb/PCA-FaceDetection/blob/master/facef.PNG" width="450">

<img src="https://github.com/bigmb/PCA-FaceDetection/blob/master/process.PNG" width="450">

# Conclusion

Here we have presented a face recognition system based on PCA. We had systematically varied the components and infer the impact of these variations on performance. The quality of images to be processed is the driving factor in determining the performance of PCA based face recognition system. The PCA plays an immense role in this system for dimensionality reduction and pseudo inverse using SVD played a significant role in normalization problem.
