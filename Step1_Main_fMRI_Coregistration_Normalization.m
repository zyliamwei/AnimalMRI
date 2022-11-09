clear all
clc
close all

% Programmed June 8, 2021 to process the regional maps of physiological
% changes under stimulus
addpath('spm12');
spm_get_defaults;
global defaults;

% <------------------ matrices to be imported ... ------------------>
datadir='C:\Users\zwei11\Desktop\APPPS_ASL_20221008\pCASL_4600_20221008_094211_APPPS1_1_27_12';
load([datadir filesep 'Mat0.mat']);         % M0 scan of the ASL MRI
load([datadir filesep 'msmask.mat']);
load([datadir filesep 'ImageNew.mat']);       % Anatomic scan in the same mouse
load([datadir filesep 'relCBF.mat']);              % Perfusion map

M0_clean=Mat0.*msmask;
anat_clean=ImageNew;
CBF=relCBF;

% Write the matrices into "nii" files
if exist([datadir filesep 'M0_clean.nii'])
    delete([datadir filesep 'M0_clean.nii']);
end
write_hdrimg(M0_clean,[datadir filesep 'M0_clean.nii'], [0.1563, 0.1563, 0.75], 16);
if exist([datadir filesep 'anat_clean.nii'])
    delete([datadir filesep 'anat_clean.nii']);
end
write_hdrimg(anat_clean,[datadir filesep 'anat_clean.nii'], [0.1172, 0.1172, 0.5], 16);
if exist([datadir filesep 'CBF.nii'])
    delete([datadir filesep 'CBF.nii']);
end
write_hdrimg(CBF,[datadir filesep 'CBF.nii'], [0.1563, 0.1563, 0.75], 16);

% coregister Anatomy to M0 image
coreg_target = spm_select('FPList', datadir, ['^anat_clean.nii']);
coreg_source = spm_select('FPList', datadir, ['^M0_clean.nii']);
coreg_other = {spm_select('FPList', datadir, ['^CBF.nii'])};
coreg_write_job(coreg_target, coreg_source, coreg_other);

% coregister anatomy to mean template
source_dir = 'D:\Zhiliang\ZoneLib\MatlabScript_B\fMRI';
tpm_dir = [source_dir filesep 'MSA_TPM'];
coreg_mean_template = spm_select('FPList', tpm_dir, ['^mean_template_mouse_new.nii']);   % Averaged global template
coreg_source = spm_select('FPList', datadir, ['^anat_clean.nii']);
coreg_other = {spm_select('FPList', datadir, ['^rM0_clean.nii']); spm_select('FPList', datadir, ['^rCBF.nii'])};
coreg_write_job(coreg_mean_template, coreg_source, coreg_other);

% normalize Anatomy to template
norm_source_dir = source_dir;
norm_target = spm_select('FPList', tpm_dir, ['^MSA_tpm_new.nii']);   % templates of gray matter, white matter, and CSF   
norm_source = spm_select('FPList', datadir, ['^ranat_clean.nii']);
norm_other = {spm_select('FPList', datadir, ['^rrM0_clean.nii']); spm_select('FPList', datadir, ['^rrCBF.nii'])};
norm_job(norm_target, norm_source, norm_other);

% % coregister ROI to the anatomy
% roi_dir=[source_dir filesep 'NITRC'];
% coreg_target = spm_select('FPList', source_dir, ['^wranat_clean.nii']);
% coreg_source = spm_select('FPList', roi_dir, ['^MBAT_anat_new_clean.nii']);
% coreg_other = {spm_select('FPList', roi_dir, ['^MBAT_label_new.nii'])};
% coreg_write_job(coreg_target, coreg_source, coreg_other);



