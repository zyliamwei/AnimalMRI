clear all
clc
close all

% Programmed on June 22, 2021 to read the exported CVR-related CBF
% information
addpath('spm12');
norchoice=1; % 1 for absolute CBF; and 2 for relative CBF; 

% Import the ASL data for the HD group
maindir='C:\Users\zwei11\Desktop\Mouse_HC_CVR';

fname=dir(maindir);

for ni=3:11
    filepath=[maindir filesep fname(ni).name]
    for mi=1:6
        tempdir={'Rep1_Base','Rep1_HC','Rep2_Base','Rep2_HC','Rep3_Base','Rep3_HC'};
        dataheader = spm_vol([fullfile(filepath,filesep,tempdir{mi},filesep,'wrrCBF.nii')]);
        data = spm_read_vols(dataheader);
        gcbf(:,:,:,ni-2,mi)=data;
        dataheader = spm_vol([fullfile(filepath,filesep,tempdir{mi},filesep,'wrrM0_clean.nii')]);
        data = spm_read_vols(dataheader);
        gM0(:,:,:,ni-2,mi)=data;
    end
end

scale=size(gcbf);
for mi=1:9
    for ni=1:6
        for pi=1:22
            gcbfave(:,:,pi,mi,ni)=squeeze(mean(gcbf(:,:,(pi-1)*10+1:pi*10,mi,ni),3));
            gM0ave(:,:,pi,mi,ni)=squeeze(mean(gM0(:,:,(pi-1)*10+1:pi*10,mi,ni),3));
        end
    end
end

load([maindir filesep 'roimask.mat']);

for mi=1:9
    for ni=1:6
        temp=W_MSplot(gcbfave(:,:,:,mi,ni),[4 6],0,[]);
        temp(133:133:end,:)=0;
        for pi=1:9
            regcbf(mi,ni,pi)=sum(sum(temp.*roimask(:,:,pi)))./sum(sum(roimask(:,:,pi)));
        end
    end
end

dirtitle={'Cerebellar','Midbrain','Hippocampus','Cortex','Thalamus','Hypothalamus','Striatum','Olfactory','Global'};

for mi=1:9
    temp=regcbf(:,:,mi);
    tempbase=temp(:,1:2:end);
    tempcvr=(temp(:,2:2:end)-temp(:,1:2:end))./temp(:,1:2:end)*100;
    tempbase=tempbase(:);
    tempcvr=tempcvr(:);
    figure;plot(tempbase,tempcvr,'ro');title(dirtitle{mi});
    [m n]=corr(tempbase,tempcvr);
       title([dirtitle{mi} ' P: ' num2str(n) ' R:' num2str(m)]);
end

abscbf=[325.8	358.8	354.6	372.4	370.0	399.8
285.8	323.4	315.4	342.7	337.7	369.2
259.9	350.3	360.0	390.6	397.1	418.9
424.3	418.8	406.0	408.4	420.6	402.5
295.2	356.8	351.5	370.5	366.4	372.6
289.3	329.9	302.7	338.7	336.5	349.8
275.8	330.9	333.4	350.8	358.6	373.5
264.9	328.2	317.8	352.4	343.1	374.0
176.8	255.5	201.2	260.8	219.5	303.4
];

for mi=1:9
    for ni=1:6
        for pi=1:9
            absregcbf(mi,ni,pi)=regcbf(mi,ni,pi)./regcbf(mi,ni,9).*abscbf(mi,ni);      
        end
    end
end

for mi=1:9
    temp=absregcbf(:,:,mi);
    tempbase=temp(:,1:2:end);
    tempcvr=(temp(:,2:2:end)-temp(:,1:2:end))./temp(:,1:2:end)*100;
    tempbase=tempbase(:);
    tempcvr=tempcvr(:);
    figure;plot(tempbase,tempcvr,'ro');   

    [m n]=corr(tempbase,tempcvr);
   
    title([dirtitle{mi} ' P: ' num2str(n) ' R:' num2str(m)]);
    axis([100 500 -50 100]);

end

shpcol={'ro','r*','bo','b*','go','g*','mo','m*','co'};    
figure;hold on;
for mi=1:9
    temp=absregcbf(:,:,mi);
    tempbase=temp(:,1:2:end);
    tempcvr=(temp(:,2:2:end)-temp(:,1:2:end))./temp(:,1:2:end)*100;
    tempbase=tempbase(:);
    tempcvr=tempcvr(:);  
    plot(tempbase,tempcvr,shpcol{mi});
    title(dirtitle{mi});
end











    