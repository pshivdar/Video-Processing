function [histoclip,ind]=get_key_frame_in_clip(videoclip, thresh)
%videoseq is a structure that holds all the frames and their frame number
%your task is to calculate  the histogram for those images and save it into
%the matrix to as information also save another matrix depicting the change
% in consequtive images if the change is more mark it as key image
% threshhold will be between 0 and 1
[n,~]=size(videoclip);
din=255*255;
    tempimg=videoclip{1,1};
temphist(:,1)=imhist(tempimg(:,:,1));
temphist(:,2)=imhist(tempimg(:,:,2));
temphist(:,3)=imhist(tempimg(:,:,3));
cliphist(1,:,:)=temphist;
changehist(1)=0;
for i=1:n
    tempimg=videoclip{i,1};
temphist(:,1)=imhist(tempimg(:,:,1));
temphist(:,2)=imhist(tempimg(:,:,2));
temphist(:,3)=imhist(tempimg(:,:,3));
cliphist(i,:,:)=temphist;
changehist(i)=sum(sum((temphist-cliphist(i-1,:,:))^2/din));
end
%% look for change in consequtive frames
tind=changehist>thresh;
ind=videoclip{tind,2};
histoclip={cliphist,videoclip{:,2}};
