%This script will take a voxel, check for each participants what its
%network looks like and add them together, allowing to see differences
%between the groups

fs = filesep;

for side = 1:2,%1:2, %loop over left and right stuff

if side == 1, %left
    files_in = '/media/thecelticcircle/DataStorage/MammouthSave/Modularity_PierreCorrections_2017/fmri/BASC_RestOnly_CBSCMixed_OccMaskBasc6Only_Left/stability_ind';
    files_out = '/media/thecelticcircle/MyPassport/MyStudies/Modularity/Modularity_Pierre_Corrections_2017/FutureFigures/CompareMaps/';%general name of file
    idx = [62289 65307];%  %lMT 75321; lTipp 74803; lFFA 48721; ltipp2 115986; lother 88529; LS70 62289 LS91 65307
    seedname = {'LS70' 'LS91'};%{'lMT' 'lTipp' 'lFFA'};
else
    files_in = '/media/thecelticcircle/DataStorage/MammouthSave/Modularity_PierreCorrections_2017/fmri/BASC_RestOnly_CBSCMixed_OccMaskBasc6Only_Right/stability_ind';
    files_out = '/media/thecelticcircle/MyPassport/MyStudies/Modularity/Modularity_Pierre_Corrections_2017/FutureFigures/CompareMaps/';%general name of file
    idx = [61250 72070];%[78857 54682 102222]; %rMT 78857; rTipp 54682; rother 102222; rtipp2 (high) 74818; LR71 61250 LR85 72070
    seedname = {'LR71' 'LR85'};%{'rMT' 'rTipp' 'rother'};
end

%mscale{1} = {'sci18_scf18' 'sci19_scf19' 'sci20_scf20' 'sci21_scf21' 'sci22_scf22' 'sci23_scf23' 'sci24_scf24' 'sci25_scf25'};
mscale{1} = {'sci3_scf3' 'sci4_scf4' 'sci5_scf5' 'sci6_scf6'};


mscalename ={'L36'} ;%{'H1825' 'L36'};

groups = {'CBxxx' 'SCxxx'}; 

%%%%%
%loop seeds and mscales
%%%%% 
for se = 1:length(idx),
for mm = 1:length(mscale),

%%%%%%%%%
% Pierre's way of getting rid of folders or files
%%%%%%%%%
dir_files = dir(files_in);
mask_dir = [dir_files.isdir];
list_all = {dir_files.name};
mask_dot = ismember(list_all,{'.','..'});
dir_files = dir_files(~mask_dot);
mask_dir = mask_dir(~mask_dot);
list_all = list_all(~mask_dot);
list_files = list_all(~mask_dir);
list_dir = list_all(mask_dir);


aa = ones(1,length(groups));
counter = zeros(1,length(groups));

for gg = 1:length(groups),
    for ss = 1:length(mscale{mm}),
        scale = mscale{mm}{ss};
	 
        for pp = 1:length(list_dir),
            fname = strcat(files_in,fs,list_dir{pp},fs,scale,fs,'brain_partition_consensus_ind_',list_dir{pp},'_',scale,'.mnc.gz');
    
            if ~isempty(strfind(fname,groups{gg})),
                counter(gg) = counter(gg) + 1;
            
                [hdr,tvol] = niak_read_vol(fname);
            
                if aa(gg) == 1,
                    svol = zeros(size(tvol));
                    aa(gg) = 0;
                end
            
                svol = svol + (tvol == tvol(idx(se)));
            
            end
        end
    end
    avol{gg} = svol./counter(gg);
    hdr.file_name = strcat(files_out,seedname{se},'_',mscalename{mm},'_',groups{gg},'.mnc.gz');
    niak_write_vol(hdr,avol{gg});
end

%Save difference volume between groups
hdr.file_name = strcat(files_out,seedname{se},'_',mscalename{mm},'_Diff_Groups.mnc.gz');
dvol = avol{1}-avol{2};
niak_write_vol(hdr,dvol);

end
end
end
