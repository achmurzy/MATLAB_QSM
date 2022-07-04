%Takes the filename of an QSM and renders the cylinders
%Example (don't forget path and extensions): view_qsm("strom_2.pcd.mat")
%Takes an index value 
function [qsm, inputs] = view_optimal_qsm(qsm_name)
    qsms = load(strjoin(["results/OptimalQSMs_",qsm_name,".pcd.mat"], ""));
    qsm = qsms.OptQSM
    inputs = qsm.rundata.inputs;
    disp(["Viewing optimal QSM of: ", qsm_name, " with parameters: "]);
    disp(inputs);
    plot_cylinder_model(qsm.cylinder, "order", 2, 8, 0.8);
    %plot_cylinder_model2 for QSMs with taper (cylinder.TopRadius)
    gca.Clipping = 'off';
    set(gcf, 'position', [50, 50, 800, 800]);
    pause