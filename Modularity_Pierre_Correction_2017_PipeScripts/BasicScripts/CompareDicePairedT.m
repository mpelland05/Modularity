function CompareDicePairedT(files_in,files_out,opt),
%This script will take Dice results and use permutation tests to assess statistical significance.
%This is done by randomly shuffling participants in two groups followed by reaveraging the
%within dice score for each participant. Same for between group dice. 
%
%files_in	string, full path to .mat file created as output from AverageDiceGeneral. 
%
%files_out	string, full path to .mat file in which results will be outputed. 
%
%opt.
%   contrast 	cell of strings, each cell contains the name of each group with the 	
%		    string '_Versus_' in between them. Example: opt.groups = {'CBxxx_Versus_SCxxx'};
%		    this is equivalent to testing CBxxx - SCxxx   ("-" standing for minus)
%		    The whole name is also what will be used as contrast name. 
%
%   scaleName	string, name of subscale to analyze. 
%
%   numPermutations	integer, number of permutations that will be carried/highest statistical 
%			significance possible
%   

%opt.contrast = {'CBxxx_Versus_SCxxx'};
%opt.numPermutations = 1000000;
%Modified from first version to be faster by doing calculations only once
%per atom.
%
%NOTE: %ok comments were writtent to make sure everysteps were carried as they should. Don't mind
% them. 

%%%%%%%%%%%%%%%%%%%%%
% General preparation %
%%%%%%%%%%%%%%%%%%%%%
load(files_in);

Perm.Legend = Avg.Legend;
Perm.Atoms = Avg.Atoms;
Perm.VoxelsIdx = Avg.VoxelsIdx;
Perm.ParticipantsIdx = Avg.ParticipantsIdx;
Perm.Parameters = Avg.Parameters;
Perm.Parameters.NumPerm = opt.numPermutations;
Perm.Contrast = opt.contrast;


%%%%%%%%%%%%%%%%%%%%%%
% Extract group names and select the data to be contrasted
%%%%%%%%%%%%%%%%%%
tt = strfind(opt.contrast{1},'_Versus_');
grpnam1 = opt.contrast{1}(1:tt-1);
grpnam2 = opt.contrast{1}(tt+8:end);

ctrst1 = strcat('Self_',grpnam1);
ctrst2 = strcat(grpnam1,'_vs_',grpnam2);

%%%%%%%%%%%%%%%%%%
% Compute differences between the original groups
% as well as average and standard deviation
%%%%%%%%%%%%%%%%%%
ogrp1 = Avg.(opt.scaleName).(strcat('avg_',ctrst1)); %Original self(within) Dice
ogrp2 = Avg.(opt.scaleName).(strcat('avg_',ctrst2)); %Orginal between Dice
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

%%%%%%%%%%%%%%%%%%%%%%%%%%
% Prepare permutations variables
%%%%%%%%%%%%%%%%%%%%%%%%%

% Make matrix containing Dice scores for every participant pair.
temp1 = cat( 3, Avg.(opt.scaleName).(strcat('Self_',grpnam1)), Avg.(opt.scaleName).(strcat(grpnam1,'_vs_',grpnam2)) );		%ok on size
temp2 = cat( 3, Avg.(opt.scaleName).(strcat(grpnam2,'_vs_',grpnam1)), Avg.(opt.scaleName).(strcat('Self_',grpnam2)) );		%ok on size AND see below
omat = cat(2,temp1,temp2);													%ok on size and numbers

clear temp1 temp2;

%find original size of groups
sz1 = size(Avg.(opt.scaleName).(strcat('Self_',grpnam1)),2);
sz2 = size(Avg.(opt.scaleName).(strcat('Self_',grpnam2)),2);
sztot = sz1+sz2;

%Number of seeds
tt = size(odiff,1);
Count = zeros(tt,1);

clear Avg;


%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Launch the Permutation test 
%%%%%%%%%%%%%%%%%%%%%%%%%%
for pe = 1:opt.numPermutations,
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

    clear order tmat trawgrp1 trawgrp2 aa bb len tgrp1 tgrp2 tdiff mtdiff tpos tneg; 
end

pvalues = (Count +1)./ (opt.numPermutations +1);


%%%%%%%%%%%%%%%%%%
% Saving output
%%%%%%%%%%%%%%%%%%%%%%%%%
Perm.(opt.contrast{1}).pvalues = pvalues;
Perm.(opt.contrast{1}).Average.(ctrst1) = mo1;
Perm.(opt.contrast{1}).Average.(ctrst2) = mo2;
Perm.(opt.contrast{1}).Average.Difference = modiff;
Perm.(opt.contrast{1}).STD.(ctrst1) = sdo1;
Perm.(opt.contrast{1}).STD.(ctrst2) = sdo2;
Perm.(opt.contrast{1}).STD.Difference = sdodiff;

save(files_out,'Perm');

clear
end
