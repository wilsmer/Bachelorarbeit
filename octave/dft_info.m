function [ratio] = dft_info(N_max)

  ratio = zeros(N_max-1,6);
  differen_values_dft = zeros(N_max-1,1);
  different_values_noneasy_dft = zeros(N_max-1,1);
  
  for N = 2:N_max
    
    W = exp(-i*2*pi*[0:N-1]'*[0:N-1]/N);
    W = round(W*1000000)/1000000;
    W_r = real(W);
    W_i = imag(W);
  
    mat_values_dft = unique(abs([W_r W_i]));
    different_values_dft(N-1,1) = length(mat_values_dft);
    easy_values = [0, 0.5, 1];
    different_values_noneasy_dft(N-1) = length(setdiff(mat_values_dft, easy_values));
  
    mat_size = N*N;
    
    % N (Spalte 1)
    ratio(N-1,1) = N;
    
    % Anzahl Werte, NxN (Spalte 2)
    ratio(N-1,2) = mat_size;
    
    % Anzahl verschiedner Werte (Betrag), einschließlich 0, 0.5, 1 (Spalte 3)
    ratio(N-1,3) = different_values_dft(N-1,1);
    
    % Bewertung DFT (Matrizengröße / Anzahl Werte) (Spalte 4)
    ratio(N-1,4) = mat_size / different_values_dft(N-1,1);
    
    % Anzahl verschiedener Werte (Betrag) ohne einfache Werte (Spalte 5)
    ratio(N-1,5) = different_values_noneasy_dft(N-1);
    
    % Bewertung ohne einfache Werte (Spalte 6)
    if (different_values_noneasy_dft(N-1) == 0)
      ratio(N-1,6) = 0;
    else
      ratio(N-1,6) = mat_size / different_values_noneasy_dft(N-1);
    end
    
  end 
end
