fi.indpath = '/media/thecelticcircle/DataStorage/MammouthSave/Modularity_PierreCorrections_2017/fmri/BASC_RestOnly_CBSCMixed_randWhole_BASC6only_Right/stability_ind/';%individual data path
fi.grppath = '/media/thecelticcircle/DataStorage/MammouthSave/Modularity_PierreCorrections_2017/fmri/BASC_RestOnly_CBSCMixed_randWhole_BASC6only_Right/stability_group_SCxxx/';%group path
fo = '/media/thecelticcircle/DataStorage/MammouthSave/Modularity_PierreCorrections_2017/Results/BASCRestOnlyCBSCMixedRandWholeMaskBasc6Only_Right/OverlapMapsBasedOnBestNetworks_YeoOnly/';%outputpath

fi.atoms = '/media/thecelticcircle/DataStorage/MammouthSave/Modularity_PierreCorrections_2017/fmri/region_growing_rand_OccMaskAALetBASC_RL/Atoms_randWhole_BASC6only_Right.mnc.gz';

%fi.scales = [7 1; 5 2;10 3; 6 4;17 5;9 6;7 7]; %scales of interest Right
fi.netnames = {'Visual' 'Sensory' 'FEF' 'Language' 'Orbital' 'FrontoParietal' 'DMN'};%scale name
fi.scales = [8 1; 8 2;16 3; 11 4;11 5;8 6;5 7]; %scales of interest right

fi.groups = {'CBxxx' 'SCxxx'};

fi.contrast = {'CBxxx_Versus_SCxxx'};

fi.numPermutations = 2000;


MakeOverlapMapBestNetworksYeoOnly(fi,fo)
