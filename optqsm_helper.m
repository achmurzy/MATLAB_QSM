%Script for executing optqsm for our own purposes 
%Namely, fitting models when TreeQSM messes up with local minima

%Ideally, the clouds directory that optqsm works out of is empty, and we
%copy what we need to fit here
convert_to_ASCII('included.txt')

cd("LiDAR/optqsm_in_out/models")
%Run it with four workers because this should optimize the number of cores our local machine here has. 
runqsm("../clouds/*.txt", 4)     %Make like a billion QSMs
runopt("./intermediate/*.mat")  %Find the good one(s)

%Within the 'models' dir, outputs an optimal QSM in the normal TreeQSM format