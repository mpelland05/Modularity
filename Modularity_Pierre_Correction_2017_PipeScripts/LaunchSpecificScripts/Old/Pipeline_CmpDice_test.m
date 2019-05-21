%This script will do statistical comparisons (using permutations) to assess
%the significance of the differences between the groups. 

fs=filesep;sp=filesep;

%number of samples for the bootstrap
nsamps = 1; %number of samples for the bootstrap

%Subscales information (names)
SpecName = {'All'}; %{'L36' 'M512' 'H1825' 'All'};%Name to give to specific subscales

%Permutations info (number of times and groups)
opt.contrast = {'CBxxx_Versus_SCxxx'};	%Group you want to compared to the others! Simply chance CBxxx and SCxxx for the names of your groups!
opt.numPermutations = 1;	%Number of permutations to carry to verify statistical significance. 

gpath{1} = '/home/mpelland/database/Modularity_Test/Results/TestCmpTopo/';
%gpath{2} = '/home/mpelland/database/Modularity_Test/Results/TestCmpTopo/';

pip.opt.psom.path_logs = '/home/mpelland/database/Modularity_OC_2016/Results/BASC_control_RestOnly_CBSCMixed_rand_OccMaskBasc6Only_RightLeftLogs/PipePermutations/';

pipeline = struct();

%%%%%%%%%%%%%%%
% Main loop!
%%%%%%%%%%%%%%

for ii = 1:length(SpecName),
    opt.scaleName = SpecName{ii};

    for kk = 1:nsamps,
	for ll = 1:length(gpath),

	    files_in = strcat( gpath{ll}, 'Samp', num2str(kk),fs,'avg_OutputCmpTopo_',SpecName{ii},'.mat' );
 	    [pp,nn,ee] = fileparts(files_in);
	    files_out = strcat(pp,fs,'Permutated',fs,'Perm_',nn,'_Paired',ee);
	
	    pipeline = psom_add_job(pipeline,strcat('CmpDicePath',num2str(ll),'Samp',num2str(kk),'Scales',num2str(ii)),'CompareDicePaired',files_in,files_out,opt,0);


	end
    end
end



%%%%%%
% Start pipeline
%%%%%%

psom_run_pipeline(pipeline,pip.opt.psom);