%Use the .pcd extension in the wildcard for optimal QSMs to distinguish
%from alberta trees. A little hacky but ok for now
function qsm = extract_optimal_qsm(analysis_path, view_qsm)
    optimal_names = dir("results/OptimalQSMs_*.pcd.mat");

    finished_names = dir(strjoin([analysis_path, "results/cyl_data_*.txt"], ""));
    for file = optimal_names'
       opt_qsm = load(file.name);
       inputs = opt_qsm.OptInputs;
       
       str = [inputs.name,'_t',num2str(inputs.tree),'_m',num2str(inputs.model)];
       str = [str,'_D',num2str(inputs.PatchDiam1)];
       str = [str,'_DA',num2str(inputs.PatchDiam2Max)];
       str = [str,'_DI',num2str(inputs.PatchDiam2Min)];
   
       if view_qsm
           view_cylinder_model(file.name);
       end
       
       save_model_text(opt_qsm.OptQSM,inputs.name,analysis_path); 
    end
        