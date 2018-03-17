function [ratio] = dct_info(N)

  ratio = zeros(N-1,6);
  differen_values_dct = zeros(N-1,1);
  different_values_noneasy_dct = zeros(N-1,1);

  T = zeros(N);
  for l = 2:N
    %T = [ones(1,l)*sqrt(1/l); cos(pi/2/l*([1:l-1]'*[1:2:2*l]))*sqrt(2/l)];
    T(1,:) = 2/sqrt(l);
    %T(2:N,:) = sqrt(2/l);
    %T(2:N,:) = T(2:N,:) .* [cos(pi/2/l*([1:l-1]'*[1:2:2*l]))];
    T(1,:) = 1/sqrt(8);
    T(2:N,:) = [cos(pi/2/l*([1:l-1]'*[1:2:2*l]))];
    T = T*0.5;
    [m,n] = size(T);
    
    mat_size = m*n;
    mat_values_dct = unique(round(abs(T).*1000000)/1000000);
    different_values_dct(l-1,1) = length(mat_values_dct);
    easy_values = [0, 0.5, 1];
    different_values_noneasy_dct(l-1) = length(setdiff(mat_values_dct, easy_values));
    
    % N (Spalte 1)
    ratio(l-1,1) = l;
    % Anzahl Werte, NxN (Spalte 2)
    ratio(l-1,2) = mat_size;
    % Anzahl verschiedner Werte (Betrag), einschließlich 0, 0.5, 1 (Spalte 3)
    ratio(l-1,3) = different_values_dct(l-1,1);
    % Bewertung DCT (Matrizengröße / Anzahl Werte) (Spalte 4)
    ratio(l-1,4) = mat_size / different_values_dct(l-1,1);
    % Anzahl verschiedener Werte (Betrag) ohne einfache Werte (Spalte 5)
    ratio(l-1,5) = different_values_noneasy_dct(l-1);
    % Bewertung ohne einfache Werte (Spalte 6)
    if (different_values_noneasy_dct(l-1) == 0)
      ratio(l-1,6) = 0;
    else
      ratio(l-1,6) = mat_size / different_values_noneasy_dct(l-1);
    end
  end
end