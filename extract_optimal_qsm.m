function qsm = extract_optimal_qsm(view_qsm, skip_existing)
    optimal_names = dir("results/OptimalQSMs_*.mat");
    analysis_path = "~/Documents/MATLAB/asymmetric-branching/data/";
    finished_names = dir(strjoin([analysis_path, "results/cyl_data_*.txt"], ""));
    for file = optimal_names'
       opt_qsm = load(file.name);
       inputs = opt_qsm.OptInputs;
       
       str = [inputs.name,'_t',num2str(inputs.tree),'_m',num2str(inputs.model)];
       str = [str,'_D',num2str(inputs.PatchDiam1)];
       str = [str,'_DA',num2str(inputs.PatchDiam2Max)];
       str = [str,'_DI',num2str(inputs.PatchDiam2Min)];
       str = [str,'_L',num2str(inputs.lcyl)];
       str = [str,'_F',num2str(inputs.FilRad)];
       
       if skip_existing
           check_member = strjoin(["cyl_data_", str, ".txt"], "");
           if(ismember(check_member, {finished_names.name}))
              disp(["Skipping extraction for present QSM: ", check_member]); 
              continue;
           end
       elseif view_qsm
           view_cylinder_model(file.name);
       end
       disp(str)
       save_model_text2(opt_qsm.OptQSM,str,analysis_path); 
    end
        