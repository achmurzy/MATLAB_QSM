cd ~/Documents/MATLAB/MATLAB_QSM
wildcard_path = 'LiDAR/*';
triangulate = 0;
save_plot = 0;
save_txt = 1;
overwrite = 0;
files = dir(wildcard_path);
finished_names = dir("results/OptimalQSMs_*.mat");
finished_names = {finished_names.name};
excluded_names = importdata('optqsm_included.txt')
excluded_names = strcat(excluded_names, ".pcd")
create_input
   
inputs.plot = save_plot;
inputs.savetxt = save_txt;
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

            %optimization routine made obsolete by optqsm
            opt = select_optimum(trees, [file.name, '.mat']);
        else
            disp(strcat("Poorly formed input, not processing: ", file.name));
        end
    else
        disp(strcat("Not fitting tree, Optimal QSMs already available: ", file.name));
    end
end

%Extract optimal QSM for each tree, not overwriting existing results
extract_optimal_qsm(0, 1)