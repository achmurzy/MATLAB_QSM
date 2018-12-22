%Takes the filename of an optimal QSM and renders the cylinders
%Example (don't forget path and extensions): view_cylinder_model("results/OptimalQSMs_strom_2.pcd.mat")
function [opt_qsm, inputs] = view_cylinder_model(qsm_name)
    opt_qsm = load(qsm_name);
    inputs = opt_qsm.OptInputs;
    disp(["Viewing cloud: ", qsm_name, " with parameters: "]);
    disp(inputs);
    plot_cylinder_model(opt_qsm.OptQSM.cylinder, 1, 8, 0.8);
    gca.Clipping = 'off';
    set(gcf, 'position', [50, 50, 800, 800]);
    pause