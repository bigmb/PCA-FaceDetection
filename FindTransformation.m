%%
%Returns the Affine Transform of the given set of coordinate to the
%specified FixedPoint set of coordinate.
%M is of the size 1x10 which is converted in (x,y) shape again.
%%
function A = FindTransformation(M,FixedPoints)
FloatingPoint = reshape(M,[2,5]);
A = fitgeotrans (FloatingPoint', FixedPoints, 'affine' );
end