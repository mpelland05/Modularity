fs = filesep;

%files_in{2} = '/home/mpelland/database/Modularity_PierreCorrections_2017/Results/BASC_control_RestOnly_CBSCMixed_rand_OccMaskBasc6Only_Left/';
files_in{1} = '/media/thecelticcircle/SaveDrive/TemporaryData/'
%files_out{2} = '/home/mpelland/database/Modularity_PierreCorrections_2017/Results/BASC_control_RestOnly_CBSCMixed_rand_OccMaskBasc6Only_Left/ResultsControl/NumberFPH1825.mat';
files_out{1} = '/media/thecelticcircle/SaveDrive/TemporaryData/ResultsControl/NumberFPAllT_Low.mat';

opt.alpha = 0.025;
opt.corrtype = 'bonf';
opt.nsamps = 9000; %number of samples for the bootstrap that was done
opt.specname = {'L36'};	%name of the scales. Will be used to name output file which will be stored in the same folder as the files_in.
opt.contrast_name = 'CBxxx_Versus_SCxxx';

MeasureFalsePositivesT(files_in,files_out,opt)
