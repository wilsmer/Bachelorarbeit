%matfiles = dir('*.mat');
%numfiles = length(matfiles);

for k = 0:180 %numfiles-1

  if k == 1
    pause
  end
  
  if k < 10
    myfilename = sprintf('/home/tlattmann/Documents/Bachelorarbeit/octave/Messwerte/messwerte _rmp_3/messung_1_1_25mm_1_31.05.2017/000000%d.mat', k);
  elseif k < 100
    myfilename = sprintf('/home/tlattmann/Documents/Bachelorarbeit/octave/Messwerte/messwerte _rmp_3/messung_1_1_25mm_1_31.05.2017/00000%d.mat', k);
  else
    myfilename = sprintf('/home/tlattmann/Documents/Bachelorarbeit/octave/Messwerte/messwerte _rmp_3/messung_1_1_25mm_1_31.05.2017/0000%d.mat', k);
  end
  
  b=importdata(myfilename);

  subplot(1,2,1)
  imagesc(b.COS_SIG)
  subplot(1,2,2)
  imagesc(b.SIN_SIG)
  
  sleep(0.1)
end