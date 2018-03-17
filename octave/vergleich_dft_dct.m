function [C] = vergleich_dft_dct(N)
  if nargin == 0
    N = 16;
  end
  
  [ratio_dct] = dct_info(N);
  [ratio_dft] = dft_info(N);
  C = zeros(N-1,8);
    
  disp('N, Anzahl Werte (NxN), versch. Werte DCT (Betrag), Bewertung DCT (N*N / versch. Werte), versch. Werte DFT (Betrag), Bewertung DFT (N*N / versch. Werte), Verhältnis DFT/DCT')
  % N (Spalte 1)
  %size(ratio_dct(:,1))
  C(:,1) = [ratio_dct(:,1)];
  % Anzahl Werte, NxN (Spalte 2)
  C(:,2) = [ratio_dct(:,2)];
  %% DCT 
  % Anzahl verschiedner Werte der DCT (Betrag), einschließlich 0, 0.5, 1 (Spalte 3)
  C(:,3) = [ratio_dct(:,3)];
  % Anzahl verschiedener Werte (Betrag) ohne einfache Werte (Spalte 4)
  C(:,4) = [ratio_dct(:,5)];
  % Bewertung DCT (Matrizengröße / Anzahl Werte) (Spalte 5)
  C(:,5) = [ratio_dct(:,4)];
  % Bewertung DCT ohne einfache Werte (Matrizengröße / Anzahl Werte) (Spalte 5)
  C(:,6) = [ratio_dct(:,6)];
  %% DFT
  % Anzahl verschiedner Werte der DFT (Betrag), einschließlich 0, 0.5, 1 (Spalte 6)
  C(:,7) = [ratio_dft(:,3)];
  % Anzahl verschiedener Werte (Betrag) ohne einfache Werte (Spalte 7)
  C(:,8) = [ratio_dft(:,5)];
  % Bewertung DFT (Matrizengröße / Anzahl Werte) (Spalte 4)
  C(:,9) = [ratio_dft(:,4)];
  % Bewertung DFT (Matrizengröße / Anzahl Werte) (Spalte 4)
  C(:,10) = [ratio_dft(:,6)];
  %% Verhältnis
  % Verhältnis DFT / DCT einschließlich einfacher Werte
  C(:,11) = [ratio_dft(:,4)./ratio_dct(:,4)];
  % Verhältnis DFT / DCT ohne einfache Werte
  C(:,12) = [ratio_dft(:,6)./ratio_dct(:,6)];
end