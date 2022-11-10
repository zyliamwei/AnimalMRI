function y=W_Show3D(data,Thr,mode)
% for displaying the 3D matrix in 3D coordination
% data is the 3D matrix to be contoursliced;
% Thr for purifying the data ;
% mode=1,2,3 when informed with words that no finite values, change the
% mode to another value, there will always be a proper value;
MaxT=max(max(max(data)));
disp(['maximum in data is: ' num2str(MaxT)]);
data=data.*(data>Thr*MaxT*0.01);
scale=size(data);

% the display parameters can be set as below
% as to a certain 3D matrix, one of the following set can display the 
% corresponding 3D figures
switch mode
    case 1
        xi=[];yi=1:scale(2);zi=1:scale(3);
    case 2
        xi=1:scale(1);yi=[];zi=1:scale(3);
    case 3
        xi=1:scale(1);yi=1:scale(2);zi=[];
    otherwise
        disp('Error in setting sel...');
end


figure();
contourslice(data,xi,yi,zi,3,'cubic');
% axis([1 scale(1) 1 scale(2) 1 scale(3)]);
% colormap spring;
view(3);
grid on;
y=data;
end