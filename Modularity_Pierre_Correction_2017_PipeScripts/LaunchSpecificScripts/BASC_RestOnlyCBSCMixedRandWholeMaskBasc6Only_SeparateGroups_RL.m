clear all

root_path = '/media/thecelticcircle/DataStorage/MammouthSave/blindtvr/fmri/';

%%%%%
%Grab
%%%%%%
opt_g.min_nb_vol = 10; %<-------------------------------------------------------modify to fit the current data!
opt_g.filter.session = {'rest'};
opt_g.exclude_subject = {'LBxxxVDCaMa','LBxxxVDDeBe','LBxxxVDGiCo','LBxxxVDJoBi','LBxxxVDJoBo','LBxxxVDJoGa','LBxxxVDLiJo','LBxxxVDLiVe','LBxxxVDMoLa','LBxxxVDRaDe','LBxxxVDSeBe' ...
,'SCxxxVDChJa','SCxxxVDCJ','SCxxxVDClDe','SCxxxVDGeAl','SCxxxVDJeRe','SCxxxVDJM','SCxxxVDJoFr','SCxxxVDKaFo','SCxxxVDLALH','SCxxxVDMaSa','SCxxxVDNiLe','SCxxxVDNiMi','SCxxxVDOL','SCxxxVDPG','SCxxxVDSC','SCxxxVDSG','SCxxxVDTJ'};

files_in = niak_grab_fmri_preprocess('/media/thecelticcircle/DataStorage/MammouthSave/blindtvr/fmri/fmri_preprocess_01_RestOnly_NoSmooth_NoLB',opt_g);

%%%%%%
%Basc
%%%%%%
opt.grid_scales = [3:25]; 
%opt.scales_maps = [3 3 3; 7 5 5; 8 9 9];
opt.stability_tseries.nb_samps = 100; 
opt.stability_group.nb_samps = 500; 

opt.flag_tseries_network = false; 
files_in.infos = '/media/thecelticcircle/DataStorage/MammouthSave/blindtvr/models/restCB.csv';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Right short %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
files_in.atoms = '/media/thecelticcircle/DataStorage/MammouthSave/Modularity_PierreCorrections_2017/fmri/region_growing_rand_OccMaskAALetBASC_RL/Atoms_randWhole_BASC6only_Right.mnc.gz';
opt.folder_out = '/media/thecelticcircle/DataStorage/MammouthSave/Modularity_PierreCorrections_2017/fmri/BASC_RestOnly_CBSCMixed_randWhole_BASC6only_Right/CBOnly/'; 

%% Run the pipeline %%
[pipeline,opt] = niak_pipeline_stability_rest(files_in,opt);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Left short %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
files_in.atoms = '/media/thecelticcircle/DataStorage/MammouthSave/Modularity_PierreCorrections_2017/fmri/region_growing_rand_OccMaskAALetBASC_RL/Atoms_randWhole_BASC6only_Left.mnc.gz';
opt.folder_out = '/media/thecelticcircle/DataStorage/MammouthSave/Modularity_PierreCorrections_2017/fmri/BASC_RestOnly_CBSCMixed_randWhole_BASC6only_Left/CBOnly/'; 

%% Run the pipeline %%
opt.mode = 'session';
[pipeline,opt] = niak_pipeline_stability_rest(files_in,opt);
