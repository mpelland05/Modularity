%This script will launch compare topographies for the occipital AAL regions and occAAL*BASC06 occipital mask 
%in half the instances, atoms are from the random atom algorithm, the others are grown from Sighted and 
%early blind individuals..


%Variables for all analyses
opt.scales = 3:25;
opt.groups = {'CBxxx','SCxxx'};
opt.contrast = {[1 2]};
opt.filter = {'NoFilt'};
opt.pType = 'consensus';



%%%%%%%%%%%%%%%
%% big loop 
%%%%%%%%%%%%%%
pipeline = struct();
pip.opt.psom.path_logs = '/home/mpelland/database/Modularity_PierreCorrections_2017/Results/BASCRestOnlyCBSCMixedRandOccMaskBasc6Only_RightLeftLogs/CmpTopo/';   %<---------------log outputs


%%%%%%%%%%%%%%%%%%%%%% Right %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
files_in.path = '/home/mpelland/database/Modularity_PierreCorrections_2017/fmri/BASC_RestOnly_CBSCMixed_rand_OccMaskBasc6Only_Right/stability_ind';
files_in.mask = '/home/mpelland/database/Modularity_PierreCorrections_2017/mask/Occipital/CBSC_Rest_Scale6_Occ_Right.mnc.gz';   
files_in.atoms = '/home/mpelland/database/Modularity_PierreCorrections_2017/fmri/region_growing_rand_OccMaskAALetBASC_RL/Atoms_rand_OccBASC6_Right.mnc'; 

files_out = strcat('/home/mpelland/database/Modularity_PierreCorrections_2017/Results/BASCRestOnlyCBSCMixedRandOccMaskBasc6Only_Right/OutputCmpTopo.mat');


%%%% select sample %%%%%%

opt.tpnames = {'CBxxxVDAlCh' 'CBxxxVDAnBe' 'CBxxxVDBeMe' 'CBxxxVDDiCe' 'CBxxxVDFrCo' 'CBxxxVDLL' 'CBxxxVDMaDu' 'CBxxxVDMaLa'...
		'CBxxxVDMoBe' 'CBxxxVDNaTe' 'CBxxxVDSePo' 'CBxxxVDSoSa' 'CBxxxVDYP' 'CBxxxVDYvLa' ...
		'SCxxxVDChJa' 'SCxxxVDCJ' 'SCxxxVDClDe' 'SCxxxVDGeAl' 'SCxxxVDJeRe' 'SCxxxVDJM' 'SCxxxVDJoFr' 'SCxxxVDKaFo'...
		'SCxxxVDLALH' 'SCxxxVDMaSa' 'SCxxxVDNiLe' 'SCxxxVDNiMi' 'SCxxxVDOL' 'SCxxxVDPG' 'SCxxxVDSC' 'SCxxxVDSG' 'SCxxxVDTJ'};


opt.GroupMat = [ones(1,14)  (ones(1,17).*2)];

%%%%% Create job %%%%%%%%%
pipeline = psom_add_job(pipeline,'CmptTopoRight','CompareTopographies',files_in,files_out,opt,0);


%%%%%%%%%%%%%%%%%%%%%% Left %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
files_in.path = '/home/mpelland/database/Modularity_PierreCorrections_2017/fmri/BASC_RestOnly_CBSCMixed_rand_OccMaskBasc6Only_Left/stability_ind';
files_in.mask = '/home/mpelland/database/Modularity_PierreCorrections_2017/mask/Occipital/CBSC_Rest_Scale6_Occ_Left.mnc.gz';   
files_in.atoms = '/home/mpelland/database/Modularity_PierreCorrections_2017/fmri/region_growing_rand_OccMaskAALetBASC_RL/Atoms_rand_OccBASC6_Left.mnc'; 

files_out = strcat('/home/mpelland/database/Modularity_PierreCorrections_2017/Results/BASCRestOnlyCBSCMixedRandOccMaskBasc6Only_Left/OutputCmpTopo.mat');


%%%%% Create job %%%%%%%%%
pipeline = psom_add_job(pipeline,'CmptTopoLeft','CompareTopographies',files_in,files_out,opt,0);



psom_run_pipeline(pipeline,pip.opt.psom);
