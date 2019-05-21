%This script will do statistical comparisons (using permutations) to assess
%the significance of the differences between the groups. 

fs=filesep;sp=filesep;

%number of samples for the bootstrap
nsamps = 9000; %number of samples for the bootstrap

%Subscales information (names)
SpecName ={'All'} ;% {'L36' 'H1825' 'All'};%Name to give to specific subscales

%Permutations info (number of times and groups)
opt.contrast = {'CBxxx_Versus_SCxxx'};	%Group you want to compared to the others! Simply chance CBxxx and SCxxx for the names of your groups!
opt.numPermutations = 200;	%Number of permutations to carry to verify statistical significance. 

%gpath{2} = '/home/mpelland/database/Modularity_PierreCorrections_2017/Results/BASC_control_RestOnly_CBSCMixed_rand_OccMaskBasc6Only_Left/';
gpath{1} = '/home/mpelland/database/Modularity_PierreCorrections_2017/Results/BASC_control_RestOnly_CBSCMixed_rand_OccMaskBasc6Only_Right2/';


pip.opt.psom.path_logs = '/home/mpelland/database/Modularity_PierreCorrections_2017/Results/BASC_control_RestOnly_CBSCMixed_rand_OccMaskBasc6Only_RightLeftLogs/CmptDice2t/';   %<---------------log outputs

pipeline = struct();

%%%%%%%%%%%%%%%
% Main loop!
%%%%%%%%%%%%%%

for ii = 1:length(SpecName),
    opt.scaleName = SpecName{ii};

    for kk = 1001:9000,
	for ll = 1:length(gpath),

	    files_in = strcat( gpath{ll}, 'Samp', num2str(kk),fs,'avg_OutputCmpTopo_',SpecName{ii},'.mat' );
 	    [pp,nn,ee] = fileparts(files_in);
	    files_out = strcat(pp,fs,'Permutated',fs,'Perm_',nn,'_PairedT',ee);
	
	    pipeline = psom_add_job(pipeline,strcat('CmpDicePath',num2str(ll),'Samp',num2str(kk),'Scales',num2str(ii)),'CompareDicePairedT',files_in,files_out,opt,0);


	end
    end
end

%fn = fieldnames(pipeline);
%for ii = 1:(900),
%   pipeline=rmfield(pipeline,fn{ii});
%end


%%%%%%
% Start pipeline
%%%%%%

pip.opt.psom.max_queued = 30;
psom_run_pipeline(pipeline,pip.opt.psom);
