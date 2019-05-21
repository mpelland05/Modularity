function CompareMapsFromNet_Stats(files_in,files_out),
%This will take the output of MakeOverlapMapBestNetworks and extract an
%atomwise statistic to compare the topography of the networks across the
%groups. A chi2 test is used. 
%It will also carry a network analysis (not atomwise) on the main networks
%to test whether their topography differs. 
%
%files_in
%       .matfile      string, full path to .mat file outputted by MakeOverlapMapBestNetworks
%
%       .groups     cell array of strings specifying the group ex: {'CBxxx' 'SCxxx'}
%                   This should be the EXACT same input as for MakeOverlapMapBestNetworks
%
%       .contrast    cell of strings, each cell contains the name of each group with the 	
%                   string '_Versus_' in between them. Example: files_in.groups = {'CBxxx_Versus_SCxxx'};
%                   this is equivalent to testing CBxxx - SCxxx   ("-" standing for minus)
%                   The whole name is also what will be used as contrast name
%
%       .scales,     matrix, size X by 2, X being the number of scales that will be tester. 
%                   column 1 contains the scale of the group networks, and collumn 2
%                   is the number of the network of interest within that group of networks
%                   ex: [8 4; 4 3;10 7; 4 2;11 1;9 2;6 5]
%
%       .netnames    cell of strings, name of networks in the same order as above.
%			    	ex:  {'Visual' 'Sensory' 'FEF' 'Language' 'Orbital' 'FrontoParietal' 'DMN'};
%
%       .numPermutations  integer, number of permutations that will be carried/highest statistical 
%                       significance possible
%
%files_out          string, full path to folder in which results should be
%                           saved

load(files_in.matfile);
fs = filesep;
soi = files_in.scales; %scales of interest left
sn = files_in.netnames;%scale name

%%%%%%%%%%%%%
% Setting up Permutation file
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Perm.Legend = Results.Legend;
Perm.Atoms = Results.Atoms;
Perm.VoxelsIdx = Results.VoxelsIdx;
Perm.ParticipantsIdx = Results.ParticipantsIdx;
Perm.Parameters = Results.Parameters;
Perm.Parameters.NumPerm = files_in.numPermutations;
Perm.Contrast = files_in.contrast;

%%%%%%%%%%%%%%%%%%%%%%
% Extract group names and select the data to be contrasted
%%%%%%%%%%%%%%%%%%
tt = strfind(files_in.contrast{1},'_Versus_');
grpnam1 = files_in.contrast{1}(1:tt-1);
grpnam2 = files_in.contrast{1}(tt+8:end);

ctrst1 = strcat('Self_',grpnam1);
ctrst2 = strcat(grpnam1,'_vs_',grpnam2);

%%%%%%%%%%%%
% Network loop
%%%%%%%%%%%%
for nn = 1:size(soi,1),%%%<-------------------------------------------------------------------------Start loop of networks


    %%%%%%%%%%%%%%%%%%
    % Compute differences between the original groups
    % as well as average and standard deviation
    %%%%%%%%%%%%%%%%%%
    ogrp1 = Results.(sn{nn}).(strcat('avg_',ctrst1)); %Original self(within) Dice
    ogrp2 = Results.(sn{nn}).(strcat('avg_',ctrst2)); %Orginal between Dice
    odiff = ogrp1 - ogrp2;

    mo1 = mean(ogrp1,2)'; 								%ok
    mo2 = mean(ogrp2,2)'; 								%ok
    modiff = mean(odiff,2)'./( std(odiff,0,2)'./sqrt(size(ogrp1,2)) );

    sdo1 = std(ogrp1,0,2)';
    sdo2 = std(ogrp2,0,2)';
    sdodiff = std(odiff,0,2)';

    Perm.(strcat(grpnam1,'_mean')) = mo1;
    Perm.(strcat(grpnam1,'_sd')) = sdo1;

    Perm.(strcat(grpnam2,'_mean')) = mo2;
    Perm.(strcat(grpnam2,'_sd')) = sdo2;

    Perm.(strcat('Group_diff_mean')) = modiff;
    Perm.(strcat('Group_diff_sd')) = sdodiff;

    %Compute difference at the atom level for each group
    idxg1 = find(strcmp(grpnam1,files_in.groups));
    idxg2 = find(strcmp(grpnam2,files_in.groups));
    MatIndNetComp = cat(2,Results.(sn{nn}).MatrixIndividualNetworks{idxg1},Results.(sn{nn}).MatrixIndividualNetworks{idxg2});
    monet1 = mean(Results.(sn{nn}).MatrixIndividualNetworks{idxg1},2);
    monet2 = mean(Results.(sn{nn}).MatrixIndividualNetworks{idxg2},2);
    modiffnet = monet1-monet2;
    
    Perm.(strcat(grpnam1,'_atomwise_mean')) = monet1;
    Perm.(strcat(grpnam2,'_atomwise_mean')) = monet2;
    Perm.(strcat('Group_diff_atomwise_mean')) = modiffnet;

    %%%%%%%%%%%%%%%%%%%%%%%%%%
    % Prepare permutations variables
    %%%%%%%%%%%%%%%%%%%%%%%%%

    % Make matrix containing Dice scores for every participant pair.
    temp1 = cat( 3, Results.(sn{nn}).(strcat('Self_',grpnam1)), Results.(sn{nn}).(strcat(grpnam1,'_vs_',grpnam2)) );		%ok on size
    temp2 = cat( 3, Results.(sn{nn}).(strcat(grpnam2,'_vs_',grpnam1)), Results.(sn{nn}).(strcat('Self_',grpnam2)) );		%ok on size AND see below
    omat = cat(2,temp1,temp2);													%ok on size and numbers

    clear temp1 temp2;
    
    %find original size of groups
    sz1 = size(Results.(sn{nn}).(strcat('Self_',grpnam1)),2);
    sz2 = size(Results.(sn{nn}).(strcat('Self_',grpnam2)),2);
    sztot = sz1+sz2;

    %Number of seeds
    Count = zeros(1);
    CountAtmWisPos = zeros(size(modiffnet));
    CountAtmWisNeg = zeros(size(modiffnet));
     
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    %Launch the Permutation test 
    %%%%%%%%%%%%%%%%%%%%%%%%%%
    for pe = 1:files_in.numPermutations,
        order = randperm(sztot);
        idx1 = order(1:sz1); 							

        tmat = omat(:,idx1,order);%reodrer matrix for new groups				%ok in size and numbers	(participant 2 and 12) for at least 3 values								
        trawgrp1 = tmat(:,:,1:sz1);								%ok same as above
        trawgrp2 = tmat(:,:,sz1+1:sz2+sz1);							%ok same as above

        %within participant averaging
        [aa bb len] = size(trawgrp1);
        tgrp1 = (sum(trawgrp1,3)-1) ./ (len-1);					%ok in size and numbers (participans 2 and 12)
        tgrp2 = mean(trawgrp2,3);							% same as above
    
        tdiff = tgrp1-tgrp2;
        mtdiff = mean(tdiff,2)./(std(tdiff,0,2)./sqrt(size(ogrp1,2)) );							%ok size

        Count = Count + ((mtdiff - modiff') > 0);   

        %Compare groups atomwise
        mtdiffnet = mean(MatIndNetComp(:,order(1:sz1)),2)-mean(MatIndNetComp(:,order(sz1+1:end)),2);
        CountAtmWisPos = CountAtmWisPos + ((mtdiffnet - modiffnet)>= 0);
        CountAtmWisNeg = CountAtmWisNeg + ((mtdiffnet - modiffnet)<= 0);
            
        clear order tmat trawgrp1 trawgrp2 aa bb len tgrp1 tgrp2 tdiff mtdiff tpos tneg; 
    end

    pvalues = (Count +1)./ (files_in.numPermutations +1);
    CountAtmWisPos(find(CountAtmWisPos == 0)) = files_in.numPermutations;
    CountAtmWisNeg(find(CountAtmWisPos == 0)) = files_in.numPermutations;
    pvalPos = (CountAtmWisPos +1)./ (files_in.numPermutations +1);
    pvalNeg = (CountAtmWisNeg +1)./ (files_in.numPermutations +1);
    
    
    %%%%%%%%%%%%%%%%%%%%%%%
    % Chi square test atomwise
    %%%%%%%%%%%%%%%%%%%%%%%%%%
    x2grp1=sum(Results.(sn{nn}).MatrixIndividualNetworks{idxg1},2);
    x2grp2=sum(Results.(sn{nn}).MatrixIndividualNetworks{idxg2},2);
    
    OO(:,1,:) = [x2grp1'; sz1-x2grp1'];
    OO(:,2,:) = [x2grp2'; sz2-x2grp2'];
    
    [ChiVal df] = ChiTest(OO,[]);
    p = chi2cdf(ChiVal,df);
    
    
    
    %%%%%%%%%%%%%%%%%%
    % Saving output
    %%%%%%%%%%%%%%%%%%%%%%%%%
    Perm.(files_in.contrast{1}).pvalues = pvalues;
    Perm.(files_in.contrast{1}).pvalues_AtomWise_Pos = pvalPos;
    Perm.(files_in.contrast{1}).pvalues_AtomWise_Neg = pvalNeg;
    Perm.(files_in.contrast{1}).pvalues_AtomWise_Pos_chi2 =(modiffnet<=0)+((modiffnet>0).*p');
    Perm.(files_in.contrast{1}).pvalues_AtomWise_Neg_chi2 = (modiffnet>=0)+((modiffnet<0).*p');
    Perm.(files_in.contrast{1}).Average.(ctrst1) = mo1;
    Perm.(files_in.contrast{1}).Average.(ctrst2) = mo2;
    Perm.(files_in.contrast{1}).Average.Difference = modiff;
    Perm.(files_in.contrast{1}).STD.(ctrst1) = sdo1;
    Perm.(files_in.contrast{1}).STD.(ctrst2) = sdo2;
    Perm.(files_in.contrast{1}).STD.Difference = sdodiff;

    %save('-mat7-binary',strcat(files_out,'OutputCmpTopoBesNetwork_',num2str(soi(nn,1)),'_',num2str(soi(nn,2)),'.mat'),'Perm');
    save(strcat(files_out,'OutputCmpTopoBesNetwork_',num2str(soi(nn,1)),'_',num2str(soi(nn,2)),'.mat'),'Perm');

end
end