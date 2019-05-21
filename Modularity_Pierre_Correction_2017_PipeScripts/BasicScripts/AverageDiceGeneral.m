function AverageDiceGeneral(files_in,files_out,opt),
%This script will take the output of DiCe score calculator (CompareTopographies), and put it in a
%format which will be an average of selected subscales. 
%
%Note that listing all scales 
%effectively won't do any scale averaging, thus yielding results for each scales independently.
%This should be used when one doesn't want to study results at the subscale level. 
%
%Then, for each voxels/atoms results are averaged within participants to yield scores which show 
%1) on average how similar are this participants clusters to that of other participants in the 
% same group (Within Dice) and 2) on average how similar are the clusters of this participant to
% that of participants in the other group (Between Dice)
%
%files_in 	string, full path to the .mat file used by the script (output from Compare topographies)
%files_out	string, full path to a .mat file in which the results will be stocked. 
%opt.
%	scales	cell of strings, must contain the name of the scales that will be averaged together
%		i.e. {'sci1_scf1' 'sci2_scf2'} will average scale 1 and 2 together
%	name	string, simple name of output variable
%
%Input example
%files_in = '/home/mpelland/database/Modularity_OC_2016/Results/BASC_RestOnly_CBSCMixed_OccMaskAALBASC_Right/avg_OutputCmpTopo.mat'; 
%opt.scales = {'sci1_scf1'}; 
%opt.name = 'LowScales';

load(files_in);

%%%%%%
% Saves basic info to output structure
%%%%%%
Avg.Legend = Results.Legend;
Avg.Atoms = Results.Atoms;
Avg.VoxelsIdx = Results.VoxelsIdx;
Avg.ParticipantsIdx = Results.ParticipantsIdx;
Avg.Parameters = Results.Parameters;
clear Results;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % % %%% Average across scales
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fn = opt.scales;

switcher = 1;
counter = 0;

for ff = 1:length(fn),
        counter = counter + 1; %count the number of scales
        
	load(files_in);

        %short loop to set up variables
        if switcher,
            switcher = 0;
            comparisons = fieldnames(Results.(fn{ff}));
            for gg = 1:length(comparisons),
                Avg.(opt.name).(comparisons{gg}) = zeros(size(Results.(fn{ff}).(comparisons{gg})));
            end
        end
        
        %main loop to fill in variables
        for gg = 1:length(comparisons),
            Avg.(opt.name).(comparisons{gg}) = Avg.(opt.name).(comparisons{gg}) + Results.(fn{ff}).(comparisons{gg});
        end
    	
	clear Results;
end

for gg = 1:length(comparisons),
    Avg.(opt.name).(comparisons{gg}) = Avg.(opt.name).(comparisons{gg})./counter;
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % % %%% Within participants
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Find the name of the groups
counter = 0;
for cc = 1:length(comparisons),
     if ~isempty(findstr('Self',comparisons{cc})),
	counter = counter+1;
	groups{counter} = regexprep(comparisons{cc},'Self_','');
    end
end

%Average for within group Dice
for gg = 1:length(groups),
        
    tname = strcat('Self_',groups{gg});
    [aa bb len] = size(Avg.(opt.name).(tname));
    Avg.(opt.name).(strcat('avg_',tname)) = (sum(Avg.(opt.name).(tname),3)-1)./(len-1); 
        
end
    
    
%Average dice between groups
for gg = 1:length(groups),
        
    List2ndGroup = 1:length(groups); List2ndGroup(List2ndGroup == gg) = [];
       
    for gg2 = List2ndGroup,
            
        tname = strcat( groups{gg},'_vs_',groups{gg2} );
            
        [aa bb len] = size(Avg.(opt.name).(tname));
        Avg.(opt.name).(strcat('avg_',tname)) = mean(Avg.(opt.name).(tname),3);
    end
end
    
save(files_out,'Avg');
    
end