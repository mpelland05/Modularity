gp = 'E:\MammouthSave\Modularity_PierreCorrections_2017\fmri\BASC_RestOnly_CBSCMixed_randWhole_BASC6only_Left\stability_group_CBxxx\';
fs = filesep;
scales = 3:20;%num nets

scale_sil = zeros(1,max(scales));

for ii = scales,
    load(strcat(gp,'stability_group_CBxxx_',num2str(ii),'.mat'), 'hier','stab');
    [sil,intra,inter] = niak_build_avg_silhouette(niak_vec2mat(stab),hier{1},0);
    scale_sil(ii) = sil(ii);
end

save(strcat(gp,'SummarySil.mat'),'scale_sil');