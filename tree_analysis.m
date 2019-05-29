
%TreeQSM analysis
function [] = tree_analysis(wildcard_path, triangulate, save_plot, save_txt, overwrite)
    files = dir(wildcard_path);
    finished_names = dir("results/OptimalQSMs_*.mat");
    finished_names = {finished_names.name};
    create_input
   
    inputs.plot = save_plot;
    inputs.savetxt = save_txt;
    inputs.Tria = triangulate;
    for file = files'
        %Check if this cloud has already been processed
        if((~ismember(['OptimalQSMs_', file.name, '.mat'], finished_names) | overwrite) & contains(file.name, ".pcd"))
            disp(strcat("Fitting new set of QSMs...", file.name));
            cloud = pcread(file.name);
            inputs.name = file.name;
            %Filter the pointcloud - we are hoping our clouds are all
            %given at meter-scale
            %result = filtering(cloud.Location, ?, ?, ?, ?, ?, ?, ?)
            
            %Apply logical vector to filter raw point cloud
            %Strategy: concatenate all TRUE values into a new array
            
            %Downsample the pointcloud - we are hoping our clouds are all
            %given at meter-scale
            result = cubical_averaging(cloud.Location, 0.01);
            %cloud.Location = cubical_down_sampling(cloud.Location, 0.01);
            
            %Main processing step. Generates 5-10 QSMS for optimization
            trees = treeqsm(result, inputs);

            %optimization routine made obsolete by optqsm
            %still, optqsm may be too much mustard
            opt = select_optimum(trees, [file.name, '.mat']);
        else
            disp(strcat("Not fitting tree, Optimal QSMs already available: ", file.name));
        end
    end
end
