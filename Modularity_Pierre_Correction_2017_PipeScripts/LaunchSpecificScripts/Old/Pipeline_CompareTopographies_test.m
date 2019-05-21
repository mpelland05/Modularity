%This script will launch compare topographies for the occipital AAL regions and occAAL*BASC06 occipital mask 
%in half the instances, atoms are from the random atom algorithm, the others are grown from Sighted and 
%early blind individuals..

nsamp = 1; %number of samples for the 
csv_file = '/home/mpelland/database/Modularity_OC_2016/controls/model/Demographics_csv.csv';
csv_var = 'sex';%control variable
cont_num = [1 1; 1 1];%matrix number of rows = num group, and each column reprents how many participants of each type for each control variable should be selected.

%Variables for all analyses
opt.scales = 3:4;
opt.groups = {'CBxxx','SCxxx'};
opt.contrast = {[1 2]};
opt.filter = {'NoFilt'};
opt.pType = 'consensus';



%%%%%%%%%%%%%%%
%% big loop 
%%%%%%%%%%%%%%
pipeline = struct();
pip.opt.psom.path_logs = '/home/mpelland/database/Modularity_OC_2016/Results/BASC_control_RestOnly_CBSCMixed_rand_OccMaskBasc6Only_RightLeftLogs/PipeTestCmpTopo/';   %<---------------log outputs

for ii = 1:nsamp,
%%%%%%%%%%%%%%%%%%%%%% Right %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
files_in.path = '/home/mpelland/database/Modularity_OC_2016/fmri/BASC_control_RestOnly_CBSCMixed_rand_OccMaskBasc6Only_Right/stability_ind';
files_in.mask = '/home/mpelland/database/Modularity_OC_2016/mask/Occipital/CBSC_Rest_Scale6_Occ_Right.mnc.gz';   
files_in.atoms = '/home/mpelland/database/Modularity_OC_2016/fmri/region_growing_rand_OccMaskAALetBASC_RL/Atoms_rand_OccBASC6_Right.mnc'; 

files_out = strcat('/home/mpelland/database/Modularity_Test/Results/TestCmpTopo/Samp',num2str(ii),'/OutputCmpTopo.mat');


%%%% select sample %%%%%%
[aa, bb]=GetNames4Pipe(files_in.path,csv_file,csv_var,cont_num);

opt.GroupMat = aa;
opt.tpnames = bb;

%%%%% Create job %%%%%%%%%
pipeline = psom_add_job(pipeline,strcat('CmptTopoRight',num2str(ii)),'CompareTopographies',files_in,files_out,opt,0);

end
%save("-mat7-binary", strcat(pip.opt.psom.path_logs,'PipelineSave.mat'), 'pipeline');

psom_run_pipeline(pipeline,pip.opt.psom);