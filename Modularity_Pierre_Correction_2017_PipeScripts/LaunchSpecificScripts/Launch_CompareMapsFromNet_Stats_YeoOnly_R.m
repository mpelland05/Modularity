fi.matfile = 'E:\MammouthSave\Modularity_PierreCorrections_2017\Results\BASCRestOnlyCBSCMixedRandWholeMaskBasc6Only_Right\OverlapMapsBasedOnBestNetworks_YeoOnly\OutputCmpTopoBesNetwork.mat';%individual data path
fo         = 'E:\MammouthSave\Modularity_PierreCorrections_2017\Results\BASCRestOnlyCBSCMixedRandWholeMaskBasc6Only_Right\OverlapMapsBasedOnBestNetworks_YeoOnly\Permutated\';%outputpath

%fi.scales = [7 1; 5 1;10 1; 6 1;17 1;9 1;7 1]; %scales of interest left
fi.netnames = {'Visual' 'Sensory' 'FEF' 'Language' 'Orbital' 'FrontoParietal' 'DMN'};%scale name
fi.scales = [8 1; 8 2;16 3; 11 4;11 5;8 6;5 7]; %scales of interest right

fi.groups = {'CBxxx' 'SCxxx'};

fi.contrast = {'CBxxx_Versus_SCxxx'};

fi.numPermutations = 2000;

CompareMapsFromNet_Stats(fi,fo)
