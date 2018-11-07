function suspensionCalc (fn, force)
%Take out all the data on the first sheet 
[numF, ~, rawF] = xlsread(fn,'Front points')
diamater = numF(23, 1) 
% Get rid of NaNs and data that is not points 
points = [numF(1:3,:);numF(5:7,:);numF(9:10,:);numF(12:13,:);numF(15:16,:);numF(18:19,:)]
% Find all the unit vectors for the rods on the front wheel 
FUCA_UnitVec_F = (points(3,:) - points(1,:))/ norm(points(3,:) - points(1,:))% Front Fore Upper Control Arm Unit Vector
AUCA_UnitVec_F = (points(3,:) - points(2,:))/ norm(points(3,:) - points(2,:))% Front Aft Upper Control Arm Unit Vector
FLCA_UnitVec_F = (points(6,:) - points(4,:))/ norm(points(6,:) - points(4,:))% Front Fore Lower Control Arm Unit Vector
ALCA_UnitVec_F = (points(6,:) - points(5,:))/ norm(points(6,:) - points(5,:))% Front Aft Lower Control Arm Unit Vector
PR_UnitVec_F = (points(7,:) - points(8,:))/ norm(points(7,:) - points(8,:))% Front Pull/Push Rod Unit Vector
TR_UnitVec_F = (points(9,:) - points(10,:))/ norm(points(9,:) - points(10,:))% Front Track Rod Unit Vector

% Momenet of the wheel contact point 
M_contact = cross(force, contact_point_F)'

% Momement about the origin 
arm1 = points(3,:) 
col1 = cross(FUCA_UnitVec_F, arm1)' 
arm2 = points(3,:)
col2 = cross(AUCA_UnitVec_F, arm2)'
arm3 = points(6,:)
col3 = cross(FLCA_UnitVec_F, arm3)'
arm4 = points(6,:)
col4 = cross(ALCA_UnitVec_F, arm4)'
arm5 = points(7,:)
col5 = cross(PR_UnitVec_F, arm5)'
arm6 = points(9,:)
col6 = cross(TR_UnitVec_F, arm6)'
matrix = [col1, col2, col3, col4, col5, col6, M_contact]
sol = rref(matrix)
FUCA_force_F = (1,end) * (FUCA_UnitVec_F)
AUCA_force_F = (2,end) * (AUCA_UnitVec_F) 
FLCA_force_F = (3,end) * (FLCA_UnitVec_F) 

FUCA = FUCA_UnitVec_F';
AUCA = AUCA_UnitVec_F';
FLCA = FLCA_UnitVec_F';
ALCA = ALCA_UnitVec_F';
PR = PR_UnitVec_F';
TR = TR_UnitVec_F';

matrix2 = [FUCA, AUCA, FLCA, ALCA, PR, TR, M_contact];
ans = rref(matrix2);

end
