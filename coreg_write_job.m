%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function coreg_write_job(target,source,other)
% coregister source to target and apply transform matrix to source and 
% varargin
% dependent package - spm12

% test
% other = {'Y:\data\vcid\CVR_1001\meanhlu_vcid1001_cvr-d0281.img';'Y:\data\vcid\CVR_1001\rhlu_vcid1001_cvr-d0281.img'};

all_list   = {[source ',1']};

if nargin > 2
    num_otr     = length(other);
    for ii = 1:num_otr
        all_list = [all_list; [other{ii},',1']]; % n*1 cell
    end
end


matlabbatch{1}.spm.spatial.coreg.estwrite.ref = {target};
matlabbatch{1}.spm.spatial.coreg.estwrite.source = {[source ',1']};
matlabbatch{1}.spm.spatial.coreg.estwrite.other = all_list;
matlabbatch{1}.spm.spatial.coreg.estwrite.eoptions.cost_fun = 'nmi';
matlabbatch{1}.spm.spatial.coreg.estwrite.eoptions.sep = [4 2];
matlabbatch{1}.spm.spatial.coreg.estwrite.eoptions.tol = [0.02 0.02 0.02 0.001 0.001 0.001 0.01 0.01 0.01 0.001 0.001 0.001];
matlabbatch{1}.spm.spatial.coreg.estwrite.eoptions.fwhm = [7 7];
matlabbatch{1}.spm.spatial.coreg.estwrite.roptions.interp = 4;
matlabbatch{1}.spm.spatial.coreg.estwrite.roptions.wrap = [0 0 0];
matlabbatch{1}.spm.spatial.coreg.estwrite.roptions.mask = 0;
matlabbatch{1}.spm.spatial.coreg.estwrite.roptions.prefix = 'r';

spm('defaults','fmri'); 
spm_jobman('initcfg')
spm_jobman('run',matlabbatch)
return

