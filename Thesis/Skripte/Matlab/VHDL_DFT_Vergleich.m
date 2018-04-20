filename_2 = 'InputMatrix_komplex.txt';
filename_1 = 'Results.txt';

delimiterIn = ' ';
bit_width_extern = 12

Input_bin = importdata(filename_2, delimiterIn);
Input_bin_real = Input_bin(:,1:2:end);
Input_bin_imag = Input_bin(:,2:2:end);

Results_vhdl_bin = importdata(filename_1, delimiterIn);
Results_vhdl_bin_real = Results_vhdl_bin(:,1:2:end);
Results_vhdl_bin_imag = Results_vhdl_bin(:,2:2:end);

Input_dec_imag = nan(8);
Results_vhdl_dec_real = nan(8);
Results_vhdl_dec_imag = nan(8);
Result_octave_real_1d = nan(8);
Result_octave_imag_1d = nan(8);

a=fi(0,1,bit_width_extern,bit_width_extern-2);

N = 8;
for m = 1:N
  for n = 1:N
    a.bin=mat2str(Results_vhdl_bin_real(m,n),bit_width_extern);
    Results_vhdl_dec_real(m,n) = a.double;
    a.bin=mat2str(Results_vhdl_bin_imag(m,n),bit_width_extern);
    Results_vhdl_dec_imag(m,n) = a.double;
  
    a.bin=mat2str(Input_bin_real(m,n),bit_width_extern);
    Input_dec_real(m,n) = a.double;
    a.bin=mat2str(Input_bin_imag(m,n),bit_width_extern);
    Input_dec_imag(m,n) = a.double;      
  end
end


Input_dec=Input_dec_real+1i*Input_dec_imag;
TW=exp(-i*2*pi*[0:7]'*[0:7]/8);

%Result_octave_1d=TW*Input_dec;
%Result_octave_real_1d=real(Result_octave_1d.')/16
%Result_octave_imag_1d=imag(Result_octave_1d)

Result_octave=TW*Input_dec*TW.';
Result_octave=Result_octave./256;

Results_vhdl_dec_real
Result_octave_real=real(Result_octave)

Result_octave_imag=imag(Result_octave);
Results_vhdl_dec_imag;
 
diff_real=Result_octave_real-Results_vhdl_dec_real
diff_imag=Result_octave_imag-Results_vhdl_dec_imag;

quit
