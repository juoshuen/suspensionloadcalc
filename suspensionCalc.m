function suspensionCalc (fn, force)
%Take out all the data on the first sheet 
[numF, ~, rawF] = xlsread(fn,'Front points')
diamater = numF(23, 1) 
contact_point_F = [numF(end-5,1:2),0]
% % Momenet of the wheel contact point 
M_contact = cross(force, contact_point_F)'
% Get rid of NaNs and data that is not points 
points = [numF(1:3,:);numF(5:7,:);numF(9:10,:);numF(12:13,:);numF(15:16,:);numF(18:19,:)]
% Create a matrix of all the unit vectors
vec1 = [3,3,6,6,7,9] % These are the rows in 'points' where the locations for the rods connect with the wheel in order
vec2 = [1,2,4,5,8,10] % These are the rows in 'points' where the locations for the rods connect with the chasis in order
UnitVec_mat = []
for i=1:6 
    unitvec = ((points(vec1(i),:) - points(vec2(i),:))/ norm(points(vec1(i),:) - points(vec2(i),:)))'
    UnitVec_mat = [UnitVec_mat, unitvec]
end
% Create a matrix of all the moment arms 
arm_mat = []
for i = vec1
    arm = points(i,:)'
    arm_mat = [arm_mat, arm] 
end

matrix = [cross(UnitVec_mat, arm_mat), M_contact]
sol = rref(matrix)

FUCA = FUCA_UnitVec_F';
AUCA = AUCA_UnitVec_F';
FLCA = FLCA_UnitVec_F';
ALCA = ALCA_UnitVec_F';
PR = PR_UnitVec_F';
TR = TR_UnitVec_F';

matrix2 = [FUCA, AUCA, FLCA, ALCA, PR, TR, M_contact];
ans = rref(matrix2);

end
