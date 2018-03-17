function inputValues2file(V_re, V_im)
  
  bit_width = 12;
  N=8;
  
  %V_re = ones(N);
  %V_im = 2*ones(N);
  
  fid=fopen('Input_komplex.txt', 'w+');

  for m=1:N
    for n=1:N
      fprintf(fid, '%s ', dec2bin(V_re(m,n), bit_width));
      fprintf(fid, '%s', dec2bin(V_im(m,n), bit_width));
      if n < N
        fprintf(fid, ' ');
      end
    end
    if m < N
      fprintf(fid, '\n');
    end
  end

  fclose(fid);
  
end