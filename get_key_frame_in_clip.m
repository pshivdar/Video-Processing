function [histoclip,ind]=get_key_frame_in_clip(videoclip, thresh)
%videoseq is a structure that holds all the frames and their frame number
%your task is to calculate  the histogram for those images and save it into
%the matrix to as information also save another matrix depicting the change
% in consequtive images if the change is more mark it as key image
% threshhold will be between 0 and 1
[n,~]=size(videoclip);
    tempimg=videoclip{1,1};
    [imgm,imgn]=size(tempimg);
temphist(:,1)=imhist(tempimg(:,:,1));
temphist(:,2)=imhist(tempimg(:,:,2));
temphist(:,3)=imhist(tempimg(:,:,3));
cliphist(1,:,:)=temphist;
changehist(1)=0;
for i=2:n
    tempimg=videoclip{i,1};
temphist(:,1)=imhist(tempimg(:,:,1));
temphist(:,2)=imhist(tempimg(:,:,2));
temphist(:,3)=imhist(tempimg(:,:,3));
cliphist(i,:,:)=temphist;
din=sum(sum(sum(tempimg~=0)));
changehist(i)=sum(sum(((cliphist(i,2:256,:)/din)-(cliphist(i-1,2:256,:)/din)).^2));
end
%% look for change in consequtive frames
tind=changehist>thresh;
if(sum(tind)==0)
    ind=[];
    histoclip={cliphist,videoclip{:,2}};
else
    ind=videoclip{tind,2};
    histoclip={cliphist,videoclip{:,2}};    
end

