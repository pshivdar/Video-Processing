function [ OutputMap ,VideoName_diff] = Classification2(KeyFrameMV, MapObj )
VideoNameDB=keys(MapObj)
KeyFrame_u=KeyFrameMV{1}
KeyFrame_v=KeyFrameMV{2}
[DB_sizer DB_sizec]=size(VideoNameDB)
VideoName_diff=containers.Map();
for DB=1:DB_sizec
    VideoName=VideoNameDB{DB}
    FrameLOC_MV=MapObj(VideoName)
    
    [Nframes MV]= size(FrameLOC_MV)
    diff_VideoName=zeros(1,Nframes)
    %diff1=containers.Map('KeyType','double','ValueType','double');
    diff1=[];
    for N=1:Nframes
       MV_N=FrameLOC_MV{N,2}
       FrameLOC_MV{1}
       FrameLOC_MV{2}
       diff=(sqrt(abs(((MV_N{1}-KeyFrame_u)^2)+((MV_N{2}-KeyFrame_v)^2))))
       diff_VideoName=norm(diff)
       diff1=[diff1 ;{FrameLOC_MV{N} diff_VideoName}]
       %diff1(FrameLOC_MV{N})=diff_VideoName;
    end
  VideoName_diff(VideoName)=diff1
    %diff_VideoName=sort(diff_VideoName)





end
outputVideo=keys(VideoName_diff)
outputLOC_MV=values(VideoName_diff)
[size1 size2]=size(outputLOC_MV)
OutputMap=containers.Map();
for i=1:size2
    Name=outputVideo{i}
    LOC_MV=cell2mat(outputLOC_MV{i})
    [sorteddiff(:,2),I]=sort(LOC_MV(:,2))
    sorteddiff(:,1)=LOC_MV(I,1)
    OutputMap(Name)=sorteddiff;
end
    
