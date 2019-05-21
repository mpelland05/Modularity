fi.matfile = 'E:\MammouthSave\Modularity_PierreCorrections_2017\Results\BASCRestOnlyCBSCMixedRandWholeMaskBasc6Only_Left\OverlapMapsBasedOnBestNetworks_YeoOnly\OutputCmpTopoBesNetwork.mat';%individual data path
fo         = 'E:\MammouthSave\Modularity_PierreCorrections_2017\Results\BASCRestOnlyCBSCMixedRandWholeMaskBasc6Only_Left\OverlapMapsBasedOnBestNetworks_YeoOnly\Permutated\';%outputpath

fi.scales = [7 1; 5 2;10 3; 6 4;17 5;9 6;7 7]; %scales of interest left
fi.netnames = {'Visual' 'Sensory' 'FEF' 'Language' 'Orbital' 'FrontoParietal' 'DMN'};%scale name
%fi.scales = [8 1; 8 1;16 1; 11 1;11 1;8 1;5 1]; %scales of interest Left

fi.groups = {'CBxxx' 'SCxxx'};

fi.contrast = {'CBxxx_Versus_SCxxx'};

fi.numPermutations = 2000;

CompareMapsFromNet_Stats(fi,fo)
