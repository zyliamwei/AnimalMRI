function norm_job(norm_target, norm_source, norm_other)

matlabbatch{1}.spm.spatial.normalise.estwrite.subj.vol = {[deblank(norm_source), ',1']};

data1{1, 1} = [deblank(norm_source), ',1'];
data1{2, 1} = [deblank(norm_other{1}), ',1'];
data1{3, 1} = [deblank(norm_other{2}), ',1'];

matlabbatch{1}.spm.spatial.normalise.estwrite.subj.resample = data1;

matlabbatch{1}.spm.spatial.normalise.estwrite.eoptions.biasreg = 0.0001;
matlabbatch{1}.spm.spatial.normalise.estwrite.eoptions.biasfwhm = 30;
matlabbatch{1}.spm.spatial.normalise.estwrite.eoptions.tpm = {norm_target};
matlabbatch{1}.spm.spatial.normalise.estwrite.eoptions.affreg = '';
matlabbatch{1}.spm.spatial.normalise.estwrite.eoptions.reg = [0 0.001 0.5 0.05 0.2];
matlabbatch{1}.spm.spatial.normalise.estwrite.eoptions.fwhm = 0;
matlabbatch{1}.spm.spatial.normalise.estwrite.eoptions.samp = 3;
matlabbatch{1}.spm.spatial.normalise.estwrite.woptions.bb = [-5.3102 -4.9301 -7.9303
                                                             3.9298 6.4099 7.9597];
matlabbatch{1}.spm.spatial.normalise.estwrite.woptions.vox = [0.07 0.07 0.07];
matlabbatch{1}.spm.spatial.normalise.estwrite.woptions.interp = 4;
matlabbatch{1}.spm.spatial.normalise.estwrite.woptions.prefix = 'w';

spm_jobman('initcfg')
spm_jobman('run',matlabbatch)
return
