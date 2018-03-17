function bin_int_matrix(N)
  
  I1 = floor(rand(N)*10);
  I2 = floor(rand(N)*10);
  W1 = floor(rand(N)*10);
  W2 = floor(rand(N)*10);
  
  filename1='InputMatrix_komplex.txt';
  filename2='InputMatrix_komplex_Int.mat';
  
  filename3='TwiddleMatrix_komplex.txt';
  filename4='TwiddleMatrix_komplex.mat';
  
  fid1 = fopen(filename1, 'w+');
  fid2 = fopen(filename3, 'w+');
  save(filename2)
  
  for m = 1:N
    for n = 1:N
      fprintf(fid1, '%s ', dec2bin(I1(m,n),12));
      fprintf(fid1, '%s', dec2bin(I2(m,n),12));
      
      fprintf(fid2, '%s ', dec2bin(W1(m,n),12));
      fprintf(fid2, '%s', dec2bin(W2(m,n),12));
      
      if n<N
        fprintf(fid1, ' ');
        fprintf(fid2, ' ');
      end
    end
    if m<N
      fprintf(fid1, '\n');
      fprintf(fid2, '\n');
    end
  end
  fclose(fid1);
  fclose(fid2);
end
