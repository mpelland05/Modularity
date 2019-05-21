%Launch_AverageDiceGeneral for multiple bootstrap samples (made with previous script: compare topo)
%This is done for a number of subscales as listed under SpecName
fs = filesep;


%Subscales information

nSpec = 0; %Number of subscales

for ii = 1:16,
    slist{ii} = ii+4; 	%list of scales within subscale 1
    SpecName{ii} = strcat('s',num2str(ii+4));	%name of the subscales. Will be used to name output file which will be stored in the same folder as the files_in.
    nSpec = nSpec+1;
end

%Name of folder were the logs of the analysis will be kept. 
pip.opt.psom.path_logs = '/home/mpelland/database/Modularity_PierreCorrections_2017/Results/BASCRestOnlyCBSCMixedRandWholeBasc6Only_OccRemoved_RightLeftLogs/AvgDiceGeneraluni/';

%Paths to folders containing results to be analyzed. Results from different folders are not mixed together
gpath{2} = '/home/mpelland/database/Modularity_PierreCorrections_2017/Results/BASCRestOnlyCBSCMixedrandWholeBASC6only_OccRemoved_Right/OutputCmpTopo';
gpath{1} = '/home/mpelland/database/Modularity_PierreCorrections_2017/Results/BASCRestOnlyCBSCMixedrandWholeBASC6only_OccRemoved_Left/OutputCmpTopo';

%%%%%%%%%%%%%%%%%%%%
%%% Loop for pipeline creation over samples and scales
%%%%%%%%%%%%%%%%%%%
pipeline = struct();

for ii = 1:nSpec,
    opt.name = SpecName{ii};

    for jj = 1:length(slist{ii}),
	clear opt.scales; 
	nustr = num2str(slist{ii}(jj));
	opt.scales{jj} = strcat('sci',nustr,'_scf',nustr);
    end

	for ll = 1:length(gpath), 	%%%%% Loop for different gpaths, Left and Rigth in the original analysis.  
	    clear files_in;
	    for jj = 1:length(slist{ii}),
    	    	files_in{jj} = strcat(gpath{ll},num2str(slist{ii}(jj)),'.mat');
	    end

 	    [pp,nn,ee] = fileparts(files_in{1});
	    files_out = strcat(pp,fs,'avg_OutputCmpTopo_',opt.name,ee);

	    pipeline = psom_add_job(pipeline,strcat('AvgTopoPath',num2str(ll),'Scale',num2str(ii)),'AverageDiceGeneral',files_in,files_out,opt,0);
	end
end

%%%%%%
% Start pipeline
%%%%%%

psom_run_pipeline(pipeline,pip.opt.psom);