function MakeOverlapMapBestNetworks(files_in,files_out),
%This script makes an overlap map based on individual networks which best fit a group network. 
%It also uses atoms in order to prepare a .mat file that will be used to make the statistical comparison. 
%
%files_in.
%	indpath,	string, path to folder containing the individual networks
%	grppath,	string, path to folder containing the group networks
%	scales,		matrix, size X by 2, X being the number of scales that will be tester. 
%			    column 1 contains the scale of the group networks, and collumn 2
%			    is the number of the network of interest within that group of networks
%			    ex: [8 4; 4 3;10 7; 4 2;11 1;9 2;6 5]
%	netnames	cell of strings, name of networks in the same order as above.
%			    ex:  {'Visual' 'Sensory' 'FEF' 'Language' 'Orbital' 'FrontoParietal' 'DMN'};
%	groups     	cell array of strings specifying the group ex: {'CBxxx' 'SCxxx'}
%   contrast    cell of strings, each cell contains the name of each group with the 	
%               string '_Versus_' in between them. Example: files_in.groups = {'CBxxx_Versus_SCxxx'};
%               this is equivalent to testing CBxxx - SCxxx   ("-" standing for minus)
%               The whole name is also what will be used as contrast name
%   numPermutations  integer, number of permutations that will be carried/highest statistical 
%			significance possible
%
%files_out		string, path to folder where 
indp = files_in.indpath;%individual data path
grpp = files_in.grppath;%group path
outp = files_out;%outputpath

fs = filesep;
soi = files_in.scales; %scales of interest left
sn = files_in.netnames;%scale name


%%%%%%%%%%%%%%%%%%%%%%%%%
%Record atom information
%%%%%%%%%%%%%%%%%%%%%%%%%
[hh Atom] = niak_read_vol(files_in.atoms);
uAtom = unique(Atom); if uAtom(1) == 0, uAtom(1) = [];end

% Measure size of each atom and their idx
%%%%%
Loc = zeros(1,length(uAtom));
AtmSiz = zeros(size(Loc));

for aa = 1:length(uAtom),
    ta = uAtom(aa);
    tLoc = find(Atom == ta);
    Loc(aa) = tLoc(1);
    AtmSiz(aa) = length(tLoc);
end
mLoc = find(ones(size(Atom)) == 1);
clear Atom;


%%%%%%%%%%%%%%%%%%%%%%%%
%Get participant's names
%%%%%%%%%%%%%%%%%%%%%%%%
dir_files = dir(indp);
mask_dir = [dir_files.isdir];
list_all = {dir_files.name};
mask_dot = ismember(list_all,{'.','..'});
dir_files = dir_files(~mask_dot);
mask_dir = mask_dir(~mask_dot);
list_all = list_all(~mask_dot);
list_files = list_all(~mask_dir);
pnam = list_all(mask_dir);        %Participant'snames


%%%%%%%
% Finding which group participants belong to
%%%%%%%%%%
GroupMat = zeros(1,length(pnam));
for gg = 1:length(files_in.groups),
    GroupMat(not(cellfun('isempty',strfind(pnam,files_in.groups{gg})))) = gg;
end


%%%%%
% Prepare the results structure
%%%%
Results.Legend = {'VoxelsIdx: Index of the voxels of interest'; 'AtomsIdx: first index of each atom';'Mask: Mask used to determine which voxels to use';'Path: Path to the partitions to use' ...
                    ;'PartitionType: Which file from the path is used for the partitions'; 'Filter: String that will be used to removed folders of non-interest'...
                    ;'Group: Names of the groups'; 'ParticipantsIdx: Index of participants names and groups to which they are affiliated'
                    ;'Atoms: link to the files containing the atoms (or smallest brain partition used'};
Results.VoxelsIdx = mLoc; 
Results.AtomsIdx = Loc;
Results.AtomsSize = AtmSiz;
Results.Atoms = files_in.atoms;
Results.ParticipantsIdx.Names = pnam;
Results.ParticipantsIdx.Groups = GroupMat;
Results.Parameters.Group = files_in.groups;
Results.Contrast_Legend = {'VoxelsIdx x Participtants Group 1 x Participants Group 2'};




%%%%%%%%%%%%%%%%
%Build comparison matrix and overlap map
%%%%%%%%%%%%%%%%
for nn = 1:size(soi,1),
    %prepare basics and load group networks
    
    tsni = strcat('sci',num2str(soi(nn,1)),'_scf',num2str(soi(nn,1)));
    %tsn = strcat('sci',num2str(soi(nn,1)),'_scg',num2str(soi(nn,1)),'_scf',num2str(soi(nn,1)));%----------------------------------------
    %[hdr tt] = niak_read_vol(strcat(grpp,tsn,fs,'brain_partition_consensus_group_',tsn,'.mnc.gz'));%<------------------------------------Line to change if using a single group partition or combined group one
    tsn = strcat('Scale_',num2str(soi(nn,1)));
    [hdr tt] = niak_read_vol(strcat(grpp,tsn,fs,'Consensus.mnc.gz'));

    
    %Extract network of interest and size
    volg = tt == soi(nn,2);
    sizg = sum(volg(:));
    
    %output volumc
    ovol = zeros(size(volg));
    for gg = 1:length(files_in.groups),
        govol{gg} = zeros(size(volg));
    end
    
    %Loop through participant to find best fitting individual network
    for pp = 1:length(pnam),
        [hdr volp] = niak_read_vol(strcat(indp,pnam{pp},fs,tsni,fs,'brain_partition_consensus_ind_',pnam{pp},'_',tsni,'.mnc.gz'));
        
        netcomp = zeros(1,soi(nn,1));
        for ii = 1:soi(nn,1),
            volt = volp ==ii;
            sizi = sum(volt(:));
            
            sizgi = sum(volg(:).*volt(:));
            
            netcomp(ii) = (2*sizgi)/(sizg+sizi);
        end
        hnet = find(netcomp == max(netcomp));
        
        cnet = (volp == hnet);
        
        ovol = ovol + cnet;
        
        govol{GroupMat(pp)} = govol{GroupMat(pp)}+cnet;

        tGroup(:,pp) = cnet(Loc);
    end
    %Create volume of overlap across all participants
    hdr.file_name = strcat(outp,'OverlapIndNets_withGrpNet_',num2str(soi(nn,1)),'_',num2str(soi(nn,2)),'.mnc.gz');
    niak_write_vol(hdr,ovol./length(pnam));
    for gg = 1:length(files_in.groups),
        hdr.file_name = strcat(outp,'OverlapIndNets_withGrpNet_',num2str(soi(nn,1)),'_',num2str(soi(nn,2)),'_',files_in.groups{gg},'.mnc.gz');
        niak_write_vol(hdr,govol{gg}./sum(GroupMat == gg));
    end

    %Create matrices, each containing the results of a single group. 
    for gg = 1:length(files_in.groups),
	    Group{gg}=tGroup(:,find(GroupMat==gg));
    end
    
 %SELF!!!!
    'Starting self'
    
    for gg = 1:length(files_in.groups),%groups
    
        Results.(sn{nn}).(strcat('Self_',files_in.groups{gg})) = zeros(1,size(Group{gg},2),size(Group{gg},2));
    
        for pph = 1:size(Group{gg},2),%horizon of matrix
            for ppv = 1:size(Group{gg},2),  %Vertical of matri
                
                [gg pph ppv]

		        NumTarget = sum(Group{gg}(:,pph).*AtmSiz);
		        NumVol = sum(Group{gg}(:,ppv).*AtmSiz);

                NumTV = sum(Group{gg}(:,ppv).*Group{gg}(:,pph).*AtmSiz);
               
                tDice = (2.*NumTV)/(NumTarget+NumVol);

		        Results.(sn{nn}).(strcat('Self_',files_in.groups{gg}))(1,pph,ppv) = tDice;
                                  
            end
        end
        
        [aa bb len] = size(Results.(sn{nn}).(strcat('Self_',files_in.groups{gg})));
        Results.(sn{nn}).(strcat('avg_Self_',files_in.groups{gg})) = (sum(Results.(sn{nn}).(strcat('Self_',files_in.groups{gg})),3)-1)./(len-1);
        
    end

    %OTHER !!!!
    'Starting group comparisons'
    
    for gg = 1:length(files_in.groups),%groups
        %Make list of other groups
        List2ndGroup = 1:length(files_in.groups); List2ndGroup(List2ndGroup == gg) = [];
        
        for gg2 = List2ndGroup,%other groups
          
           Results.(sn{nn}).(strcat( files_in.groups{gg},'_vs_',files_in.groups{gg2} )) = zeros(1,size(Group{gg},2),size(Group{gg2},2));
            
            for pph = 1:size(Group{gg},2),%horizon of matrix
                for ppv = 1:size(Group{gg2},2),  %Vertical of matrix
                    
                    [gg gg2 pph ppv]

                    NumTarget = sum(Group{gg}(:,pph).*AtmSiz);
                    NumVol = sum(Group{gg2}(:,ppv).*AtmSiz);

                    NumTV = sum(Group{gg2}(:,ppv).*Group{gg}(:,pph).*AtmSiz);
               
                    tDice = (2.*NumTV)/(NumTarget+NumVol);

                    Results.(sn{nn}).(strcat( files_in.groups{gg},'_vs_',files_in.groups{gg2} ))(1,pph,ppv) = tDice;
                    
                end
            end
            
            Results.(sn{nn}).(strcat('avg_',files_in.groups{gg},'_vs_',files_in.groups{gg2} )) =  mean(Results.(sn{nn}).(strcat( files_in.groups{gg},'_vs_',files_in.groups{gg2} )),3);
            
        end
    end

    Results.(sn{nn}).MatrixIndividualNetworks = Group;

end

save('-mat7-binary',strcat(files_out,'OutputCmpTopoBesNetwork.mat'),'Results');
end
