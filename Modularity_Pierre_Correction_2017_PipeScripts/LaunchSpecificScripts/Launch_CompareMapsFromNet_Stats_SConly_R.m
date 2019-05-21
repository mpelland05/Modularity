fi.matfile = 'E:\MammouthSave\Modularity_PierreCorrections_2017\Results\BASCRestOnlyCBSCMixedRandWholeMaskBasc6Only_Right\OverlapMapsBasedOnBestNetworks_SConly\OutputCmpTopoBesNetwork.mat';%individual data path
fo         = 'E:\MammouthSave\Modularity_PierreCorrections_2017\Results\BASCRestOnlyCBSCMixedRandWholeMaskBasc6Only_Right\OverlapMapsBasedOnBestNetworks_SConly\Permutated\';%outputpath

%fi.scales = [7 3; 5 3;10 4; 6 1;17 8;9 6;7 7]; %scales of interest left
fi.netnames = {'Visual' 'Sensory' 'FEF' 'Language' 'Orbital' 'FrontoParietal' 'DMN'};%scale name
fi.scales = [8 3; 8 6;16 16; 11 9;11 10;8 5;5 5]; %scales of interest right

fi.groups = {'CBxxx' 'SCxxx'};

fi.contrast = {'CBxxx_Versus_SCxxx'};

fi.numPermutations = 2000;

CompareMapsFromNet_Stats(fi,fo)
