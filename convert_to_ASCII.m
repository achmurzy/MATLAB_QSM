%Convert a set of PCD files into an ASCII format to satisfy the demands
%of optqsm. Optionally, provide a file specifying a set of names. 
%Otherwise, convert the whole LiDAR directory
function [] = convert_to_ASCII(names)
if ~exist('names', 'var')
   files = dir('LiDAR/*.pcd');
else
    names = importdata('included.txt')
    files = strcat(strcat("LiDAR/", names), ".pcd")
end

txt_files = dir('LiDAR/optqsm_in_out/clouds/*.txt');
names = {txt_files.name};
    for file = files'
        cloud = pcread(file.name);
        newfile = strcat(file.name, '.txt');
        if(~ismember(newfile, names))
            disp(strcat("Writing to optqsm txt...", newfile));
            dlmwrite(strcat('LiDAR/optqsm_in_out/clouds/',newfile), cloud.Location);
        end
    end
end