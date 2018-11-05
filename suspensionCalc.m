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


end
