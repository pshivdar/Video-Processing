clc;
v=VideoReader('rgb-04-1.avi');
seg=3;
keyframeidx=[];
vectors=[];
skipimg=10;
l=1;
for i=1:seg:v.Duration-seg
    [videoclip]=read(v,[(i-1)*v.FrameRate+1 , (i+2)*v.FrameRate]);
    [~,~,~,nframes]=size(videoclip);
    k=1;
    for j=1:skipimg:nframes-skipimg-1    
        frame1=imresize(videoclip(:,:,:,j),0.33);
        frame2=imresize(videoclip(:,:,:,j+1),0.33);
        SegmentedImage=get_motionVect_perImg(frame1,frame2);
    SE=strel('square',15);
    DilatedImage= uint8(imdilate(SegmentedImage,SE));
    FrameMasked(:,:,1)=frame2(:,:,1).*DilatedImage(:,:);
    FrameMasked(:,:,2)=frame2(:,:,2).*DilatedImage(:,:);
    FrameMasked(:,:,3)=frame2(:,:,3).*DilatedImage(:,:);
        frameloc=(i-1)*v.FrameRate+j;
        videoclipseq(k,1)={FrameMasked};
        videoclipseq(k,2)={frameloc};
        k=k+1;
    end
    [histoclip,ind]=get_key_frame_in_clip(videoclipseq,0.007);
    if(isempty(ind))
    vectors=[vectors histoclip];
    else
    keyframeidx=[keyframeidx ind(:)];
    vectors=[vectors histoclip];
    end
    %l=l+1;
end
