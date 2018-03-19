function [ratio] = dct_info(N_max)

  ratio = zeros(N_max-1,6);
  differen_values_dct = zeros(N_max-1,1);
  different_values_noneasy_dct = zeros(N_max-1,1);

  for N = 2:N_max

    W = cos(pi/N*([0:N-1]')*([0:N-1]+.5));
    W = round(W*1000000)/1000000;
    
  
  
    mat_values_dct = unique(abs(W));
    different_values_dct(N-1,1) = length(mat_values_dct);
    easy_values = [0, 0.5, 1];
    different_values_noneasy_dct(N-1) = length(setdiff(mat_values_dct, easy_values));
  
    mat_size = N*N;
    
    % N (Spalte 1)
    ratio(N-1,1) = N;
    
    % Anzahl Werte, NxN (Spalte 2)
    ratio(N-1,2) = mat_size;
    
    % Anzahl verschiedner Werte (Betrag), einschließlich 0, 0.5, 1 (Spalte 3)
    ratio(N-1,3) = different_values_dct(N-1,1);
    
    % Bewertung DCT (Matrizengröße / Anzahl Werte) (Spalte 4)
    ratio(N-1,4) = mat_size / different_values_dct(N-1,1);
    
    % Anzahl verschiedener Werte (Betrag) ohne einfache Werte (Spalte 5)
    ratio(N-1,5) = different_values_noneasy_dct(N-1);
    
    % Bewertung ohne einfache Werte (Spalte 6)
    if (different_values_noneasy_dct(N-1) == 0)
      ratio(N-1,6) = 0;
    else
      ratio(N-1,6) = mat_size / different_values_noneasy_dct(N-1);
    end
    
  end
end
