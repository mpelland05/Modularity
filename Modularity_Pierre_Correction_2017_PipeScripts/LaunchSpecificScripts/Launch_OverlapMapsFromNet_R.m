fi.indpath = '/media/thecelticcircle/DataStorage/MammouthSave/Modularity_PierreCorrections_2017/fmri/BASC_RestOnly_CBSCMixed_randWhole_BASC6only_Right/stability_ind/';%individual data path
fi.grppath = '/media/thecelticcircle/DataStorage/MammouthSave/Modularity_PierreCorrections_2017/fmri/BASC_RestOnly_CBSCMixed_randWhole_BASC6only_Right/stability_group_SCxxx/';%group path
fo = '/media/thecelticcircle/DataStorage/MammouthSave/Modularity_PierreCorrections_2017/Results/BASCRestOnlyCBSCMixedRandWholeMaskBasc6Only_Right/OverlapMapsBasedOnBestNetworks_SConly/';%outputpath

fi.atoms = '/media/thecelticcircle/DataStorage/MammouthSave/Modularity_PierreCorrections_2017/fmri/region_growing_rand_OccMaskAALetBASC_RL/Atoms_randWhole_BASC6only_Right.mnc.gz';

%fi.scales = [7 3; 5 3;10 4; 6 1;17 8;9 6;7 7]; %scales of interest left
fi.netnames = {'Visual' 'Sensory' 'FEF' 'Language' 'Orbital' 'FrontoParietal' 'DMN'};%scale name
fi.scales = [8 3; 8 6;16 16; 11 9;11 10;8 5;5 5]; %scales of interest right

fi.groups = {'CBxxx' 'SCxxx'};

fi.contrast = {'CBxxx_Versus_SCxxx'};

fi.numPermutations = 2000;


MakeOverlapMapBestNetworks(fi,fo)
