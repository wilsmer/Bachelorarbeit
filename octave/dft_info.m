function [ratio] = dft_info(N)

  ratio = zeros(N-1,6);
  differen_values_dft = zeros(N-1,1);
  different_values_noneasy_dft = zeros(N-1,1);
  
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
  
    mat_values_dft = unique(abs([twiddle_mat_real twiddle_mat_imag]));
    different_values_dft(l-1,1) = length(mat_values_dft);
    easy_values = [0, 0.5, 1];
    different_values_noneasy_dft(l-1) = length(setdiff(mat_values_dft, easy_values));
  
    mat_size = l*l;    
    % N (Spalte 1)
    ratio(l-1,1) = l;
    % Anzahl Werte, NxN (Spalte 2)
    ratio(l-1,2) = mat_size;
    % Anzahl verschiedner Werte (Betrag), einschließlich 0, 0.5, 1 (Spalte 3)
    ratio(l-1,3) = different_values_dft(l-1,1);
    % Bewertung DFT (Matrizengröße / Anzahl Werte) (Spalte 4)
    ratio(l-1,4) = mat_size / different_values_dft(l-1,1);
    % Anzahl verschiedener Werte (Betrag) ohne einfache Werte (Spalte 5)
    ratio(l-1,5) = different_values_noneasy_dft(l-1);
    % Bewertung ohne einfache Werte (Spalte 6)
    if (different_values_noneasy_dft(l-1) == 0)
      ratio(l-1,6) = 0;
    else
      ratio(l-1,6) = mat_size / different_values_noneasy_dft(l-1);
    end
  end 
end