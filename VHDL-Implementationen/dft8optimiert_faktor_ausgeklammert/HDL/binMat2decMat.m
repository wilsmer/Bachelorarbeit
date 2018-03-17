script_dir='/home/tlattmann/cadence/mat_mult/HDL/';

filename_1 = 'Results.txt';
filename_2 = 'InputMatrix_komplex_Einsen.txt';

filename_1 = strcat(script_dir, filename_1);
filename_2 = strcat(script_dir, filename_2);

delimiterIn = ' ';

Results_vhdl_bin = importdata(filename_1, delimiterIn);
Results_vhdl_bin_real = Results_vhdl_bin(:,1:2:end);
Results_vhdl_bin_imag = Results_vhdl_bin(:,2:2:end);

Input_bin = importdata(filename_2, delimiterIn);
Input_bin_real = Input_bin(:,1:2:end);
Input_bin_imag = Input_bin(:,2:2:end);

N = 8;
%bin2dec(sprintf('%d',Results_vhdl_bin_real(2,2)))
for m = 1:N
  for n = 1:N
      
    %Results_vhdl_dec_real(m,n) = bin2dec(sprintf('%d',Results_vhdl_bin_real(m,n)));
    %Results_vhdl_dec_imag(m,n) = bin2dec(sprintf('%d',Results_vhdl_bin_imag(m,n)));
    Results_vhdl_dec_real(m,n) = bin2dec(mat2str(Results_vhdl_bin_real(m,n)));
    Results_vhdl_dec_imag(m,n) = bin2dec(mat2str(Results_vhdl_bin_imag(m,n)));
  
    if Results_vhdl_dec_real(m,n) > 2047
        Results_vhdl_dec_real(m,n) = Results_vhdl_dec_real(m,n)-4096;
    end  
  
    if Results_vhdl_dec_imag(m,n) > 2047
        Results_vhdl_dec_imag(m,n) = Results_vhdl_dec_imag(m,n)-4096;
    end  
  
    %Input_dec_real(m,n) = bin2dec(sprintf('%d',Input_bin_real(m,n)));  
    %Input_dec_imag(m,n) = bin2dec(sprintf('%d',Input_bin_imag(m,n)));
    Input_dec_real(m,n) = bin2dec(mat2str(Input_bin_real(m,n)));  
    Input_dec_imag(m,n) = bin2dec(mat2str(Input_bin_imag(m,n)));
  end
end


Input_dec_real
Input_dec_imag

Input_dec=Input_dec_real+i*Input_dec_imag;

  
TW_real=[   
   1   1   1   1   1   1  1   1
   1   3   0  -3  -1  -3  0   3
   1   0  -1   0   1   0 -1   0
   1  -3   0   3  -1   3  0  -3
   1  -1   1  -1   1  -1  1  -1
   1  -3   0   3  -1   3  0  -3
   1   0  -1   0   1   0 -1   0
   1   3   0  -3  -1  -3  0   3];
   
TW_imag=[
   0   0   0   0   0   0   0   0
   0   3   1   3   0  -3  -1  -3
   0   1   0  -1   0   1   0  -1
   0   3  -1   3   0  -3   1  -3
   0   0   0   0   0   0   0   0
   0  -3   1  -3   0   3  -1   3
   0  -1   0   1   0  -1   0   1
   0  -3  -1  -3   0   3   1   3];
   

TW=TW_real+i*TW_imag;

TW(4,:)
Input_dec(:,1)

TW(4,:)*Input_dec(:,1)

Result_octave=TW*Input_dec;
Result_octave_real=real(Result_octave)
Result_octave_imag=imag(Result_octave)
 
Results_vhdl_dec_real
Results_vhdl_dec_imag
 
diff_real=Result_octave_real-Results_vhdl_dec_real
diff_imag=Result_octave_imag-Results_vhdl_dec_imag

 
quit
