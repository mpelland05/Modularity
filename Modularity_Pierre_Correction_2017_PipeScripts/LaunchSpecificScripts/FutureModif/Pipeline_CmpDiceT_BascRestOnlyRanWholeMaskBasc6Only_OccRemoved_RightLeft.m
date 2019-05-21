%This script will do statistical comparisons (using permutations) to assess
%the significance of the differences between the groups. 

fs=filesep;sp=filesep;

%Subscales information (names)
for ii = 1:16,
    slist{ii} = ii+4; 	%list of scales within subscale 1
    SpecName{ii} = strcat('s',num2str(ii+4));	%name of the subscales. Will be used to name output file which will be stored in the same folder as the files_in.
end

%SpecName = {'All'};%Name to give to specific subscales

%Permutations info (number of times and groups)
opt.contrast = {'CBxxx_Versus_SCxxx'};	%Group you want to compared to the others! Simply chance CBxxx and SCxxx for the names of your groups!
opt.numPermutations = 100000;	%Number of permutations to carry to verify statistical significance. 

gpath{2} = '/home/mpelland/database/Modularity_PierreCorrections_2017/Results/BASCRestOnlyCBSCMixedrandWholeBASC6only_OccRemoved_Right/';
gpath{1} = '/home/mpelland/database/Modularity_PierreCorrections_2017/Results/BASCRestOnlyCBSCMixedrandWholeBASC6only_OccRemoved_Left/';


pip.opt.psom.path_logs = '/home/mpelland/database/Modularity_PierreCorrections_2017/Results/BASCRestOnlyCBSCMixedRandWholeBasc6Only_OccRemoved_RightLeftLogs/CmpDiceT/';

pipeline = struct();

%%%%%%%%%%%%%%%
% Main loop!
%%%%%%%%%%%%%%

for ii = 1:length(SpecName),
    opt.scaleName = SpecName{ii};

	for ll = 1:length(gpath),

	    files_in = strcat( gpath{ll}, 'avg_OutputCmpTopo_',SpecName{ii},'.mat' );
 	    [pp,nn,ee] = fileparts(files_in);
	    files_out = strcat(pp,fs,'Permutated',fs,'Perm_',nn,'_PairedT',ee);
	
	    pipeline = psom_add_job(pipeline,strcat('CmpDicePath',num2str(ll),'Scales',num2str(ii)),'CompareDicePairedT',files_in,files_out,opt,0);


	end
end


%%%%%%
% Start pipeline
%%%%%%

pip.opt.psom.max_queued = 30;
psom_run_pipeline(pipeline,pip.opt.psom);
