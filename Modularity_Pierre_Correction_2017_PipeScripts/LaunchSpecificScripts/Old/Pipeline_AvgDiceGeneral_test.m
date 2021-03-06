%Launch_AverageDiceGeneral for multiple bootstrap samples (made with previous script: compare topo)
%This is done for a number of subscales as listed under SpecName
fs = filesep;

%number of samples for the bootstrap
nsamps = 1; 

%Subscales information
SpecName = {'All'}; %{'L36' 'M512' 'H1825' 'All'};	%name of the subscales. Will be used to name output file which will be stored in the same folder as the files_in.
nSpec = 1; %Number of subscales

slist{1} = 3:4; 	%list of scales within subscale 1
%slist{2} = 5:12;	%list of scales within subscale 2
%slist{3} = 18:25;	%list of scales within subscale 3
%slist{4} = 3:25;	%list of scales within subscale 4

%Name of folder were the logs of the analysis will be kept. 
pip.opt.psom.path_logs = '/home/mpelland/database/Modularity_OC_2016/Results/BASC_control_RestOnly_CBSCMixed_rand_OccMaskBasc6Only_RightLeftLogs/PipeTestAvgGeneral/';
pip.opt.psom.mode = 'session'; %Try removing it first, if the script then takes to long to run, add the line back.

%Paths to folders containing results to be analyzed. Results from different folders are not mixed together
gpath{1} = '/home/mpelland/database/Modularity_Test/Results/TestCmpTopo/';
%gpath{2} = ???;

%%%%%%%%%%%%%%%%%%%%
%%% Loop for pipeline creation over samples and scales
%%%%%%%%%%%%%%%%%%%
pipeline = struct();

for ii = 1:nSpec,
    opt.name = SpecName{ii};

    for jj = 1:length(slist{ii}),
	nustr = num2str(slist{ii}(jj));
	opt.scales{jj} = strcat('sci',nustr,'_scf',nustr);
    end

    for kk = 1:nsamps,			%%Loop for bootstrap samples
	for ll = 1:length(gpath), 	%%%%% Loop for different gpaths, Left and Rigth in the original analysis.  

    	    files_in = strcat( gpath{ll}, 'Samp', num2str(kk),'/OutputCmpTopo.mat' );
 	    [pp,nn,ee] = fileparts(files_in);
	    files_out = strcat(pp,fs,'avg_OutputCmpTopo_',opt.name,ee);

	    pipeline = psom_add_job(pipeline,strcat('AvgTopoPath',num2str(ll),'Samp',num2str(kk),'Scale',num2str(ii)),'AverageDiceGeneral',files_in,files_out,opt,0);
	end
    end
end

%%%%%%
% Start pipeline
%%%%%%

psom_run_pipeline(pipeline,pip.opt.psom);