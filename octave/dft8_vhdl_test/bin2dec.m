filename_2 = 'InputMatrix_komplex.txt';

delimiterIn = ' ';

Input_bin = importdata(filename_2, delimiterIn);
Input_bin_real = Input_bin(:,1:2:end);
Input_bin_imag = Input_bin(:,2:2:end);

a=fi(0,1,12,10);

N = 8;
for m = 1:N
  for n = 1:N
    a.bin=mat2str(Input_bin_real(m,n));
    Input_dec_real(m,n) = 1; %a.double;
    a.bin=mat2str(Input_bin_imag(m,n));
    Input_dec_imag(m,n) = 1; %a.double;  
  end
end

Input_dec_real
Input_dec_imag
