function [ratio, mat_values_dft] = dft_info_bak(N)
  if nargout == 1
    mat_values_dft = [];
  else
    ratio = [];
    mat_values_dft = [];
  end 


  ratio = zeros(N-1,4);
  mat_value_count_dft = zeros(N-1,1);
  %mat_values_dft = zeros(N-1,1);
  mat_values_dft = cell(1,1);
  
  for l = 2:N
    twiddle_mat = zeros(l);
    twiddle_mat_real = zeros(l);
    twiddle_mat_imag = zeros(l);
  
    for m = 1:l
      for n = 1:l
        twiddle_mat(m,n) = exp(-(i*2*pi*(m-1)*(n-1))/(l));
      end
    end
    
    twiddle_mat_real = round(real(twiddle_mat)*1000000)/1000000;
    twiddle_mat_imag = round(imag(twiddle_mat)*1000000)/1000000;
  
    mat_values_dft(l-1) = {unique(abs([twiddle_mat_real twiddle_mat_imag]))};
    mat_value_count_dft(l-1,1) = length(unique(abs([twiddle_mat_real twiddle_mat_imag])));
  
    mat_size = l*l;
    
    ratio(l-1,1) = l;
    ratio(l-1,2) = l*l;
    ratio(l-1,3) = mat_size / mat_value_count_dft(l-1,1);
    ratio(l-1,4) = mat_value_count_dft(l-1,1);
  end
end