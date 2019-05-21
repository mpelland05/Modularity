%This script will launch compare topographies for the BASC06 occipital mask  
%Comparison is made between Men and Women from the Cambridge database. 
pipeline = struct();

for ii = 3:25,
%Variables for all analyses
opt.scales = ii;
opt.groups = {'Female','Male'};
opt.contrast = {[1 2]};
opt.filter = {'NoFilt'};
opt.pType = 'consensus';



%%%%%%%%%%%%%%%
%% big loop 
%%%%%%%%%%%%%%

pip.opt.psom.path_logs = '/home/mpelland/database/Modularity_PierreCorrections_2017/Results/BASCRestOnlyCBSCMixedRandOccMaskBasc6Only_CambMenWomen_RightLeftLogs/CmpTopo/';   %<---------------log outputs

%%%%%%%%%%%%%%%%%%%%%% Right %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
files_in.path = '/home/mpelland/database/Modularity_PierreCorrections_2017/fmri/BASC_control_RestOnly_CBSCMixed_rand_OccMaskBasc6Only_Right/stability_ind';
files_in.mask = '/home/mpelland/database/Modularity_PierreCorrections_2017/mask/Occipital/CBSC_Rest_Scale6_Occ_Right.mnc.gz';   
files_in.atoms = '/home/mpelland/database/Modularity_PierreCorrections_2017/fmri/region_growing_rand_OccMaskAALetBASC_RL/Atoms_rand_OccBASC6_Right.mnc'; 

files_out = strcat('/home/mpelland/database/Modularity_PierreCorrections_2017/Results/BASCRestOnlyCBSCMixedRandOccMaskBasc6Only_CambMenWomen_Right/OutputCmpTopo',num2str(ii),'.mat');


%%%% select sample %%%%%%

opt.tpnames = {'sub88445' 'sub51050' 'sub98528' 'sub20543' 'sub13093' 'sub60797' 'sub39065' 'sub53059' 'sub81289' 'sub83683'...
            'sub53296' 'sub90674' 'sub99085' 'sub08588' 'sub58360' 'sub51671' 'sub23869' 'sub20389' 'sub24670' 'sub90699'...
            'sub72068' 'sub78614' 'sub49998' 'sub62424' 'sub68425' 'sub13216' 'sub25044' 'sub43358' 'sub04187' 'sub95644'...
            'sub61185' 'sub53107' 'sub88464' 'sub27796' 'sub65373' 'sub61209' 'sub58682' 'sub05306' 'sub43304' 'sub45354'...
            'sub88853' 'sub20563' 'sub50454' 'sub78547' 'sub14278' 'sub29800' 'sub84256' 'sub52442' 'sub41567' 'sub47231'...
            'sub55874' 'sub87846' 'sub49259' 'sub07902' 'sub69287' 'sub50953' 'sub51172' 'sub66351' 'sub73477' 'sub50272'...
            'sub34741' 'sub73399' 'sub35512'...
            'sub41773' 'sub15432' 'sub92288' 'sub89894' 'sub04270' 'sub82113' 'sub94304' 'sub17772' 'sub39737' 'sub77598'...
            'sub58874' 'sub12346' 'sub06987' 'sub69315' 'sub39053' 'sub71849' 'sub15258' 'sub47498' 'sub53615' 'sub06272'...
            'sub76631' 'sub77337' 'sub57221' 'sub93488' 'sub82435' 'sub80557' 'sub23780' 'sub53193' 'sub86115' 'sub18295'...
            'sub40635' 'sub21755' 'sub25058' 'sub13902' 'sub10268' 'sub27230' 'sub13187' 'sub58470' 'sub01361' 'sub84504'...
            'sub90681' 'sub29425' 'sub27065' 'sub76745' 'sub59434' 'sub35430' 'sub90059' 'sub07413' 'sub59729' 'sub81562'...
            'sub99330' 'sub84845' 'sub93269' 'sub10619' 'sub34586' 'sub54846' 'sub82213' 'sub92440' 'sub16846' 'sub69397'...
            'sub64985' 'sub55114' 'sub07798'};


opt.GroupMat = [ones(1,63)  (ones(1,63).*2)];

%%%%% Create job %%%%%%%%%
pipeline = psom_add_job(pipeline,strcat('CmptTopoRight',num2str(ii)),'CompareTopographies',files_in,files_out,opt,0);


%%%%%%%%%%%%%%%%%%%%%% Left %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
files_in.path = '/home/mpelland/database/Modularity_PierreCorrections_2017/fmri/BASC_control_RestOnly_CBSCMixed_rand_OccMaskBasc6Only_Left/stability_ind';
files_in.mask = '/home/mpelland/database/Modularity_PierreCorrections_2017/mask/Occipital/CBSC_Rest_Scale6_Occ_Left.mnc.gz';   
files_in.atoms = '/home/mpelland/database/Modularity_PierreCorrections_2017/fmri/region_growing_rand_OccMaskAALetBASC_RL/Atoms_rand_OccBASC6_Left.mnc'; 

files_out = strcat('/home/mpelland/database/Modularity_PierreCorrections_2017/Results/BASCRestOnlyCBSCMixedRandOccMaskBasc6Only_CambMenWomen_Left/OutputCmpTopo',num2str(ii),'.mat');


%%%%% Create job %%%%%%%%%
pipeline = psom_add_job(pipeline,strcat('CmptTopoLeft',num2str(ii)),'CompareTopographies',files_in,files_out,opt,0);

%pip.opt.psom.mode = 'session';

end
pip.opt.psom.max_queued = 1; 
psom_run_pipeline(pipeline,pip.opt.psom);
