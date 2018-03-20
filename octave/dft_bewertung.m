%% Dateiname: dft_bewertung.m
%% Funktion:  Bewertet die Koeffizienten der DFT-Twiddlefaktormatrix
%%            darauf basierend, wie trivial die Berechnungen mit 
%%            den Twiddlefaktoren sind.
%%            Als trivial gelten Berechnungen mit den Werten -1, -0.5, 0, +0.5, +1
%%            Es wird ein Verhaeltnis aus trivialen und nicht trivialen Werten
%%            erstellt.
%% Argumente: N (Groesse der NxN DFT-Matrix)
%% Author:    Thomas Lattmann
%% Datum:     17.10.2017
%% Version:   1.0

function dft_bewertung(N)

  % Twiddlefaktor-Matrix erzeugen  
  W = exp(-i*2*pi*[0:N-1]'*[0:N-1]/N);
  W = round(W*1000000)/1000000;
  
  % Matrix nach Im und Re trennen und Werte runden
  W_r = real(W);
  W_i = imag(W);
  
  % Werte kleiner 0,000001 auf 0 setzen (arithmetische Ungenauigkeiten)
  W_r(abs(W_r) < 0.000001) = 0;
  W_i(abs(W_i) < 0.000001) = 0;
  
  
  
  % Anzahl verschiedener Werte ermitteln
  different_nums_real = unique(W_r);
  different_nums_imag = unique(W_i);
  
  different_nums = [different_nums_real; different_nums_imag];
  different_nums = unique(different_nums);
  different_non_trivial_nums = different_nums(find(different_nums ~= 1));
  different_non_trivial_nums = different_non_trivial_nums(find(different_non_trivial_nums ~= -1));
  different_non_trivial_nums = different_non_trivial_nums(find(different_non_trivial_nums ~= 0.5));
  different_non_trivial_nums = different_non_trivial_nums(find(different_non_trivial_nums ~= -0.5));
  different_non_trivial_nums = different_non_trivial_nums(find(different_non_trivial_nums ~= 0));
  
  different_non_trivial_nums = unique(abs(different_non_trivial_nums));
  non_trivial = length(abs(different_non_trivial_nums))
  
  % Jeweils die Menge der verschiedenen Werte ermitteln (hier Re)
  num_count_real = zeros(1, length(different_nums_real));
  for k = 1:length(different_nums_real)
    for n = 1:N
      for m = 1:N
        if different_nums_real(k) == W_r(m,n)
          num_count_real(k) = num_count_real(k) +1;
        end
      end
    end
  end

  
  % Jeweils die Anzahl der verschiedenen Werte ermitteln (hier Im)
  num_count_imag = zeros(1,length(different_nums_imag));
  for k = 1:length(different_nums_imag)
    for n = 1:N
      for m = 1:N
        if different_nums_imag(k) == W_i(m,n)
          num_count_imag(k) = num_count_imag(k) +1;
        end
      end
    end
  end
  
  
  % nicht triviale Werte der reellen Matrix zählen 
  nontrivial_nums_real = 0;
  for k = 1:length(different_nums_real)
    if abs(different_nums_real(k)) != 1
      if abs(different_nums_real(k)) != 0.5
        if different_nums_real(k) != 0
          nontrivial_nums_real = nontrivial_nums_real + num_count_real(k);
        end
      end
    end
  end
  
  % nicht triviale Werte der imaginären Matrix zählen 
  nontrivial_nums_imag = 0;
  for k = 1:length(different_nums_imag)
    if abs(different_nums_imag(k)) != 1
      if abs(different_nums_imag(k)) != 0.5
        if different_nums_imag(k) != 0
          nontrivial_nums_imag = nontrivial_nums_imag + num_count_imag(k);
        end
      end
    end
  end  
  
  nums_of_each_matrix = N*N;
  
  trivial_nums_real = N*N - nontrivial_nums_real
  trivial_nums_imag = N*N - nontrivial_nums_imag
  
  nontrivial_nums_real
  nontrivial_nums_imag
  
  trivial_nums_total = trivial_nums_real + trivial_nums_imag
  nontrivial_nums_total = nontrivial_nums_real + nontrivial_nums_imag
  
  v = trivial_nums_total/nontrivial_nums_total 

end
