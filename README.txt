Custom MATLAB workflow for processing QSMs with TreeQSM and piping to R-based analysis
(Raumonen et al 2013)

Matlab requirements:
Statistics and MAchine Learning Toolbox
Parallel Processing Toolbox (optqsm)
Computer Vision Toolbox

First time start-up from root of MATLAB_QSM folder:
#Download the data from the CyVerse data store using iRODS
cd LiDAR
icd LiDAR/pcd
iget -r .

#Download Alberta data from google drive (assuming remote 'albert_trees' is configured)
#If not, rclone config and follow the instructions - below command just uses a remote with
#base directory access to your drive, which is dangerous in principle but more explicit
rclone copy alberta_trees:Metabolic\ scaling\ project Alberta -P --drive-shared-with-me

Workflow commands:
-scaling_analysis.m - can also specify a single tree
-view_cylinder_model("")
-Extract to the R-based analysis environment with extract_optimal_qsm.m
-optqsm workflow is in place but I don't know what kind of computer can run it, even for a single tree. 
Specify input with the txt file 'optqsm_included.txt'

Taxonomy of TreeQSM errors from parameter variation and poorly formed input:

-PatchDiam1 variation:
    -TreeQSM unable to form connected cover sets, which causes infinite loop
    and eventually crashes MATLAB. 