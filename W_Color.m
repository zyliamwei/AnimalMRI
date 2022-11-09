function y=W_Color(target)
% Generating randomized color for display
if length(target)==1 % randomized color
    y=rand(target,3);
else             % same color repeated for a designated number
    y=zeros(sum(target),3);
    y(1:target(1),:)=ones(target(1),1)*rand(1,3);
    for mi=2:length(target)
        y(sum(target(1:mi-1))+1:sum(target(1:mi)),:)=ones(target(mi),1)*rand(1,3);
    end
end
end