fs=filesep;sp=filesep;
files_in.groups = {'CBxxx'};
files_in.scales =  repmat(3:25,3,1);
files_in.numPermutations = 100000;


%%%%%%%%%%%%%%%%%%%%%% Right short %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
files_in.path = '/home/mpelland/database/Modularity_OC_2016/Results/BASC_RestOnly_CBSCMixed_OccMaskAALBASC_Right/avg_OutputCmpTopo.mat';
lsep = strfind(files_in.path,filesep);
gPath = files_in.path(1:lsep(end)); 

fname = strcat('Perm_', files_in.path(lsep(end)+1:end-4));

for ii = 1:size(files_in.scales,2),%scales    
   if size(files_in.scales,2) == 1,
        files_in.ScaleStr = strcat('sci',num2str(files_in.scales(ii)),'_scf',num2str(files_in.scales(ii)))
        files_in.contrast_name = strcat('CBvsSC_',files_in.ScaleStr);
    else
        files_in.ScaleStr = strcat('sci',num2str(files_in.scales(1,ii)),'_scf',num2str(files_in.scales(3,ii)));
	files_in.ScaleStr
        files_in.contrast_name = strcat('CBvsSC_',files_in.ScaleStr);
    end
      
    files_out = strcat(gPath,'Permutated',sp,fname,files_in.ScaleStr,'_Paired','.mat');
    mkdir(gPath,'Permutated');    


    CompareDiCePaired(files_in,files_out);
end

%%%%%%%%%%%%%%%%%%%%%% Left short %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
files_in.path = '/home/mpelland/database/Modularity_OC_2016/Results/BASC_RestOnly_CBSCMixed_OccMaskAALBASC_Left/avg_OutputCmpTopo.mat';
lsep = strfind(files_in.path,filesep);
gPath = files_in.path(1:lsep(end)); 

fname = strcat('Perm_', files_in.path(lsep(end)+1:end-4));

for ii = 1:size(files_in.scales,2),%scales    
   if size(files_in.scales,2) == 1,
        files_in.ScaleStr = strcat('sci',num2str(files_in.scales(ii)),'_scf',num2str(files_in.scales(ii)))
        files_in.contrast_name = strcat('CBvsSC_',files_in.ScaleStr);
    else
        files_in.ScaleStr = strcat('sci',num2str(files_in.scales(1,ii)),'_scf',num2str(files_in.scales(3,ii)));
	files_in.ScaleStr
        files_in.contrast_name = strcat('CBvsSC_',files_in.ScaleStr);
    end
      
    files_out = strcat(gPath,'Permutated',sp,fname,files_in.ScaleStr,'_Paired','.mat');
    mkdir(gPath,'Permutated');    


    CompareDiCePaired(files_in,files_out);
end

%%%%%%%%%%%%%%%%%%%%%% Right long %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
files_in.path = '/home/mpelland/database/Modularity_OC_2016/Results/BASC_RestOnly_CBSCMixed_OccMaskAAL_Right/avg_OutputCmpTopo.mat';
lsep = strfind(files_in.path,filesep);
gPath = files_in.path(1:lsep(end)); 

fname = strcat('Perm_', files_in.path(lsep(end)+1:end-4));

for ii = 1:size(files_in.scales,2),%scales    
   if size(files_in.scales,2) == 1,
        files_in.ScaleStr = strcat('sci',num2str(files_in.scales(ii)),'_scf',num2str(files_in.scales(ii)))
        files_in.contrast_name = strcat('CBvsSC_',files_in.ScaleStr);
    else
        files_in.ScaleStr = strcat('sci',num2str(files_in.scales(1,ii)),'_scf',num2str(files_in.scales(3,ii)));
	files_in.ScaleStr
        files_in.contrast_name = strcat('CBvsSC_',files_in.ScaleStr);
    end
      
    files_out = strcat(gPath,'Permutated',sp,fname,files_in.ScaleStr,'_Paired','.mat');
    mkdir(gPath,'Permutated');    


    CompareDiCePaired(files_in,files_out);
end

%%%%%%%%%%%%%%%%%%%%%% Left long %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
files_in.path = '/home/mpelland/database/Modularity_OC_2016/Results/BASC_RestOnly_CBSCMixed_OccMaskAAL_Left/avg_OutputCmpTopo.mat';
lsep = strfind(files_in.path,filesep);
gPath = files_in.path(1:lsep(end)); 

fname = strcat('Perm_', files_in.path(lsep(end)+1:end-4));

for ii = 1:size(files_in.scales,2),%scales    
   if size(files_in.scales,2) == 1,
        files_in.ScaleStr = strcat('sci',num2str(files_in.scales(ii)),'_scf',num2str(files_in.scales(ii)))
        files_in.contrast_name = strcat('CBvsSC_',files_in.ScaleStr);
    else
        files_in.ScaleStr = strcat('sci',num2str(files_in.scales(1,ii)),'_scf',num2str(files_in.scales(3,ii)));
	files_in.ScaleStr
        files_in.contrast_name = strcat('CBvsSC_',files_in.ScaleStr);
    end
      
    files_out = strcat(gPath,'Permutated',sp,fname,files_in.ScaleStr,'_Paired','.mat');
    mkdir(gPath,'Permutated');    


    CompareDiCePaired(files_in,files_out);
end




%%%%%rand
%%%%%%%%%%%%%%%%%%%%%% Right short %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
files_in.path = '/home/mpelland/database/Modularity_OC_2016/Results/BASC_RestOnly_CBSCMixed_rand_OccMaskAALBASC_Right/avg_OutputCmpTopo.mat';
lsep = strfind(files_in.path,filesep);
gPath = files_in.path(1:lsep(end)); 

fname = strcat('Perm_', files_in.path(lsep(end)+1:end-4));

for ii = 1:size(files_in.scales,2),%scales    
   if size(files_in.scales,2) == 1,
        files_in.ScaleStr = strcat('sci',num2str(files_in.scales(ii)),'_scf',num2str(files_in.scales(ii)))
        files_in.contrast_name = strcat('CBvsSC_',files_in.ScaleStr);
    else
        files_in.ScaleStr = strcat('sci',num2str(files_in.scales(1,ii)),'_scf',num2str(files_in.scales(3,ii)));
	files_in.ScaleStr
        files_in.contrast_name = strcat('CBvsSC_',files_in.ScaleStr);
    end
      
    files_out = strcat(gPath,'Permutated',sp,fname,files_in.ScaleStr,'_Paired','.mat');
    mkdir(gPath,'Permutated');    


    CompareDiCePaired(files_in,files_out);
end

%%%%%%%%%%%%%%%%%%%%%% Left short %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
files_in.path = '/home/mpelland/database/Modularity_OC_2016/Results/BASC_RestOnly_CBSCMixed_rand_OccMaskAALBASC_Left/avg_OutputCmpTopo.mat';
lsep = strfind(files_in.path,filesep);
gPath = files_in.path(1:lsep(end)); 

fname = strcat('Perm_', files_in.path(lsep(end)+1:end-4));

for ii = 1:size(files_in.scales,2),%scales    
   if size(files_in.scales,2) == 1,
        files_in.ScaleStr = strcat('sci',num2str(files_in.scales(ii)),'_scf',num2str(files_in.scales(ii)))
        files_in.contrast_name = strcat('CBvsSC_',files_in.ScaleStr);
    else
        files_in.ScaleStr = strcat('sci',num2str(files_in.scales(1,ii)),'_scf',num2str(files_in.scales(3,ii)));
	files_in.ScaleStr
        files_in.contrast_name = strcat('CBvsSC_',files_in.ScaleStr);
    end
      
    files_out = strcat(gPath,'Permutated',sp,fname,files_in.ScaleStr,'_Paired','.mat');
    mkdir(gPath,'Permutated');    


    CompareDiCePaired(files_in,files_out);
end

%%%%%%%%%%%%%%%%%%%%%% Right long %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
files_in.path = '/home/mpelland/database/Modularity_OC_2016/Results/BASC_RestOnly_CBSCMixed_rand_OccMaskAAL_Right/avg_OutputCmpTopo.mat';
lsep = strfind(files_in.path,filesep);
gPath = files_in.path(1:lsep(end)); 

fname = strcat('Perm_', files_in.path(lsep(end)+1:end-4));

for ii = 1:size(files_in.scales,2),%scales    
   if size(files_in.scales,2) == 1,
        files_in.ScaleStr = strcat('sci',num2str(files_in.scales(ii)),'_scf',num2str(files_in.scales(ii)))
        files_in.contrast_name = strcat('CBvsSC_',files_in.ScaleStr);
    else
        files_in.ScaleStr = strcat('sci',num2str(files_in.scales(1,ii)),'_scf',num2str(files_in.scales(3,ii)));	
	files_in.ScaleStr
        files_in.contrast_name = strcat('CBvsSC_',files_in.ScaleStr);
    end
      
    files_out = strcat(gPath,'Permutated',sp,fname,files_in.ScaleStr,'_Paired','.mat');
    mkdir(gPath,'Permutated');    


    CompareDiCePaired(files_in,files_out);
end

%%%%%%%%%%%%%%%%%%%%%% Left long %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
files_in.path = '/home/mpelland/database/Modularity_OC_2016/Results/BASC_RestOnly_CBSCMixed_rand_OccMaskAAL_Left/avg_OutputCmpTopo.mat';
lsep = strfind(files_in.path,filesep);
gPath = files_in.path(1:lsep(end)); 

fname = strcat('Perm_', files_in.path(lsep(end)+1:end-4));

for ii = 1:size(files_in.scales,2),%scales    
   if size(files_in.scales,2) == 1,
        files_in.ScaleStr = strcat('sci',num2str(files_in.scales(ii)),'_scf',num2str(files_in.scales(ii)))
        files_in.contrast_name = strcat('CBvsSC_',files_in.ScaleStr);
    else
        files_in.ScaleStr = strcat('sci',num2str(files_in.scales(1,ii)),'_scf',num2str(files_in.scales(3,ii)));
	files_in.ScaleStr
        files_in.contrast_name = strcat('CBvsSC_',files_in.ScaleStr);
    end
      
    files_out = strcat(gPath,'Permutated',sp,fname,files_in.ScaleStr,'_Paired','.mat');
    mkdir(gPath,'Permutated');    


    CompareDiCePaired(files_in,files_out);
end