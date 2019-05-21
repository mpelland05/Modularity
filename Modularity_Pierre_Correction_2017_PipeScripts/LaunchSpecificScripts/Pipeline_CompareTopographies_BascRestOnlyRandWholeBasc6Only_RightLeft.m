%This script will launch compare topographies for the occipital AAL regions and occAAL*BASC06 occipital mask 
%in half the instances, atoms are from the random atom algorithm, the others are grown from Sighted and 
%early blind individuals..

pipeline = struct();
l = 1;
r = 1;

for ii = 5:20, %scales of interest

%Variables for all analyses
opt.scales = ii;
opt.groups = {'CBxxx','SCxxx'};
opt.contrast = {[1 2]};
opt.filter = {'NoFilt'};
opt.pType = 'consensus';



%%%%%%%%%%%%%%%
%% big loop 
%%%%%%%%%%%%%%

pip.opt.psom.path_logs = '/home/mpelland/database/Modularity_PierreCorrections_2017/Results/BASCRestOnlyCBSCMixedRandWholeBasc6Only_RightLeftLogs/CmpTopo/';   %<---------------log outputs


%%%%%%%%%%%%%%%%%%%%%% Right %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
files_in.path = '/home/mpelland/database/Modularity_PierreCorrections_2017/fmri/BASC_RestOnly_CBSCMixed_randWhole_BASC6only_Right/stability_ind';
files_in.mask = '/home/mpelland/database/Modularity_PierreCorrections_2017/mask/Whole/MaskWholeRight.mnc.gz';   
files_in.atoms = '/home/mpelland/database/Modularity_PierreCorrections_2017/fmri/region_growing_rand_OccMaskAALetBASC_RL/Atoms_randWhole_BASC6only_Right.mnc.gz';


files_out = strcat('/home/mpelland/database/Modularity_PierreCorrections_2017/Results/BASCRestOnlyCBSCMixedRandWholeMaskBasc6Only_Right/OutputCmpTopo',num2str(ii),'.mat');

if r,
    r = 0;
else
    files_in.out = strcat('/home/mpelland/database/Modularity_PierreCorrections_2017/Results/BASCRestOnlyCBSCMixedRandWholeMaskBasc6Only_Right/OutputCmpTopo',num2str(ii-1),'.mat');
end


%%%% select sample %%%%%%

opt.tpnames = {'CBxxxVDAlCh' 'CBxxxVDAnBe' 'CBxxxVDBeMe' 'CBxxxVDDiCe' 'CBxxxVDFrCo' 'CBxxxVDLL' 'CBxxxVDMaDu' 'CBxxxVDMaLa'...
		'CBxxxVDMoBe' 'CBxxxVDNaTe' 'CBxxxVDSePo' 'CBxxxVDSoSa' 'CBxxxVDYP' 'CBxxxVDYvLa' ...
		'SCxxxVDChJa' 'SCxxxVDCJ' 'SCxxxVDClDe' 'SCxxxVDGeAl' 'SCxxxVDJeRe' 'SCxxxVDJM' 'SCxxxVDJoFr' 'SCxxxVDKaFo'...
		'SCxxxVDLALH' 'SCxxxVDMaSa' 'SCxxxVDNiLe' 'SCxxxVDNiMi' 'SCxxxVDOL' 'SCxxxVDPG' 'SCxxxVDSC' 'SCxxxVDSG' 'SCxxxVDTJ'};


opt.GroupMat = [ones(1,14)  (ones(1,17).*2)];

%%%%% Create job %%%%%%%%%
pipeline = psom_add_job(pipeline,strcat('CmptTopoRight',num2str(ii)),'CompareTopographies',files_in,files_out,opt,0);


%%%%%%%%%%%%%%%%%%%%%% Left %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
files_in.path = '/home/mpelland/database/Modularity_PierreCorrections_2017/fmri/BASC_RestOnly_CBSCMixed_randWhole_BASC6only_Left/stability_ind';
files_in.mask = '/home/mpelland/database/Modularity_PierreCorrections_2017/mask/Whole/MaskWholeLeft.mnc.gz';   
files_in.atoms = '/home/mpelland/database/Modularity_PierreCorrections_2017/fmri/region_growing_rand_OccMaskAALetBASC_RL/Atoms_randWhole_BASC6only_Left.mnc.gz';

files_out = strcat('/home/mpelland/database/Modularity_PierreCorrections_2017/Results/BASCRestOnlyCBSCMixedRandWholeMaskBasc6Only_Left/OutputCmpTopo',num2str(ii),'.mat');

if l,
    l = 0;
else
    files_in.out = strcat('/home/mpelland/database/Modularity_PierreCorrections_2017/Results/BASCRestOnlyCBSCMixedRandWholeMaskBasc6Only_Left/OutputCmpTopo',num2str(ii-1),'.mat');
end


%%%%% Create job %%%%%%%%%
pipeline = psom_add_job(pipeline,strcat('CmptTopoLeft',num2str(ii)),'CompareTopographies',files_in,files_out,opt,0);



end

pip.opt.max_queued = 1;
psom_run_pipeline(pipeline,pip.opt.psom);