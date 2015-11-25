function create_database(dirname)
% creates database based on the files present under dirname
cd(dirname);
filenames=dir;
for i=3:size(filenames,1)
   vectors=video_to_vector(filenames(i));
   matName=[filenames(i).name(1:end-4) '_vectors.mat'];
   save(matName,'vectors');
   source=['C:\Users\sshukla5\Documents\Video-Processing-master\Videos\' matName]
   copyfile(source,'T:\VideoToVectors');
end
cd('..');
end
