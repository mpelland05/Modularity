fi.matfile = 'E:\MammouthSave\Modularity_PierreCorrections_2017\Results\BASCRestOnlyCBSCMixedRandWholeMaskBasc6Only_Left\OverlapMapsBasedOnBestNetworks\OutputCmpTopoBesNetwork.mat';%individual data path
fo = 'E:\MammouthSave\Modularity_PierreCorrections_2017\Results\BASCRestOnlyCBSCMixedRandWholeMaskBasc6Only_Left\OverlapMapsBasedOnBestNetworks\Permutated\';%outputpath

fi.scales = [8 4; 17 17;10 7; 7 5;11 1;9 2;6 5]; %scales of interest left
fi.netnames = {'Visual' 'Sensory' 'FEF' 'Language' 'Orbital' 'FrontoParietal' 'DMN'};%scale name
%fi.scales = [7 1; 8 5;12 10; 11 10;6 2;10 9;5 3]; %scales of interest right

fi.groups = {'CBxxx' 'SCxxx'};

fi.contrast = {'CBxxx_Versus_SCxxx'};

fi.numPermutations = 2000;

CompareMapsFromNet_Stats(fi,fo)
