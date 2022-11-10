function y=W_MShrink(mask,N)
% Shrinking a mask by a designated proportions (1/N)
% Every one voxel in N voxels will be removed to achieve shirinking
scale=size(mask);
tmask=zeros(scale);
temp=mask;
temp(1:N(1):end,:,:)=[];
temp(:,1:N(2):end,:)=[];
scale1=size(temp);
shift=fix(0.5*(scale-scale1));
tmask(shift(1):shift(1)+scale1(1)-1,shift(2):shift(2)+scale1(2)-1,:)=temp;
y=tmask;
end

