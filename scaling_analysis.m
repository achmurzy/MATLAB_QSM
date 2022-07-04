cd ~/Documents/MATLAB/MATLAB_QSM
wildcard_path = 'LiDAR/*';
triangulate = 0;
save_plot = 0;
save_txt = 1;
overwrite = 0;
files = dir(wildcard_path);
files = files(4:end) %Discard folder paths '.' '..' and '.gitignore'
finished_names = dir("results/OptimalQSMs_*.mat");
finished_names = {finished_names.name};
excluded_names = importdata('optqsm_included.txt')
excluded_names = strcat(excluded_names, ".pcd")

%optimization_criterion = 'all_mean_dis'
%optimization_criterion = 'trunk+1branch+2branch_mean_dis'
%optimization_criterion = 'trunk+branch_vol_std';
optimization_criterion = 'all_mean_surf';
%optimization_criterion = 'trunk+1branch+2branch_mean_surf';
create_input
%Modify the input here if we aren't doing a default run
inputs.PatchDiam2Min = [0.025 0.05 0.075 0.1]; 
% Maximum cover set size in the stem's base in the second cover:
inputs.PatchDiam2Max = [0.07 0.1 0.15 0.25];
% Must be same length as above
inputs.BallRad2 = inputs.PatchDiam2Max+0.01;
   
inputs.plot = save_plot;
inputs.savetxt = save_txt;
%Enable this ('1') to fit buttresses at the base. Often causes problems.
inputs.Tria = triangulate;
for file = files'
    %Check if this cloud has already been processed
    if((~ismember(['OptimalQSMs_', file.name, '.mat'], finished_names) | overwrite) & contains(file.name, ".pcd"))
        if(~ismember(file.name, excluded_names))
            disp(strcat("Fitting new set of QSMs...", file.name));
            cloud = pcread(file.name);
            inputs.name = file.name;
            %Filter the pointcloud - we are hoping our clouds are all
            %given at meter-scale
            %result = filtering(cloud.Location, ?, ?, ?, ?, ?, ?, ?)

            %Apply logical vector to filter raw point cloud
            %Strategy: concatenate all TRUE values into a new array

            %Downsample the pointcloud - we are hoping our clouds are all
            %given at meter-scale. Downsampling too much will lead to a
            %sparse cloud with its own problems related to local minima

            %result = cubical_averaging(cloud.Location, 0.001);
            result = cloud.Location;

            %Main processing step. Generates 5-10 QSMS for optimization
            trees = treeqsm(result, inputs);
            %all_mean_dis optimizes for all fitted cylinders' mean distance
            %from the cloud. In the case of our sparse San Emilio trees,
            %this is not what we should be doing
            %opt = select_optimum(trees, 'all_mean_dis', [file.name, '.mat']);
            opt = select_optimum(trees, optimization_criterion, [file.name, '.mat']);
        else
            disp(strcat("Poorly formed input, not processing: ", file.name));
        end
    else
        disp(strcat("Not fitting tree, Optimal QSMs already available: ", file.name));
        disp(strcat("Extracting optimum based on input criterion: ", file.name));
        trees = load(strjoin(["results/QSM_",file.name,"_t1_m1.mat"],""));
        opt = select_optimum(trees.QSM, optimization_criterion, [file.name, '.mat']);
    end
end

%Extract optimal QSM for each tree, not overwriting existing results
%Need to re-write this for version 2.4.1
extract_optimal_qsm('~/forest_architecture/', 0);