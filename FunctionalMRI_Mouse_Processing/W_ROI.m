function y=W_ROI(data,range,roi,color)
% Overlaying the ROI to the data
figure;imshow(data,range,'initialmag','fit');colorbar;hold on;
scale0=size(data);
% Construct the color matrix
scale=size(roi);
if length(scale)==2
    scale(3)=1;
end
scale
for ni=1:scale(3)
    eval(['colormask.d' num2str(ni) '=cat(3,ones(scale0).*color(ni,1),'...
        'ones(scale0).*color(ni,2),ones(scale0).*color(ni,3));']);
end
% Display the color with ROI boundary
for ni=1:scale(3)
    eval(['H=imshow(colormask.d' num2str(ni) ');']);
    set(H,'alphadata',roi(:,:,ni));
end
y=0;    
end