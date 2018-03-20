%% Dateiname: dct_bewertung.m
%% Funktion:  Bewertet die Koeffizienten der DCT-Twiddlefaktormatrix
%%            darauf basierend, wie trivial die Berechnungen mit 
%%            den Twiddlefaktoren sind.
%%            Als trivial gelten Berechnungen mit den Werten -1, -0.5, 0, +0.5, +1
%%            Es wird ein Verhaeltnis aus trivialen und nicht trivialen Werten
%%            erstellt.
%% Argumente: N (Groesse der NxN DCT-Matrix)
%% Author:    Thomas Lattmann
%% Datum:     17.10.2017
%% Version:   1.0

function dct_bewertung(N)

  % Twiddlefaktor-Matrix erzeugen  
  W = cos(pi/N*([0:N-1]')*([0:N-1]+.5));
  W = round(W*1000000)/1000000;
  
  % Werte kleiner 0,000001 auf 0 setzen (arithmetische Ungenauigkeiten)
  W(abs(W) < 0.000001) = 0;
  
  
  % Anzahl verschiedener Werte ermitteln
  different_nums = unique(W);
  different_non_trivial_nums = different_nums(find(different_nums ~= 1));
  different_non_trivial_nums = different_non_trivial_nums(find(different_non_trivial_nums ~= -1));
  different_non_trivial_nums = different_non_trivial_nums(find(different_non_trivial_nums ~= 0.5));
  different_non_trivial_nums = different_non_trivial_nums(find(different_non_trivial_nums ~= -0.5));
  different_non_trivial_nums = different_non_trivial_nums(find(different_non_trivial_nums ~= 0));
  
  different_non_trivial_nums = unique(abs(different_non_trivial_nums));
  different_non_trivial_nums
  %non_trivial = length(abs(different_non_trivial_nums))
  
  
  % Jeweils die Menge der verschiedenen Werte ermitteln
  num_count = zeros(1, length(different_nums));
  for k = 1:length(different_nums)
    for n = 1:N
      for m = 1:N
        if different_nums(k) == W(m,n)
          num_count(k) = num_count(k) +1;
        end
      end
    end
  end

  
  % nicht triviale Werte der Matrix zählen 
  nontrivial_nums = 0;
  for k = 1:length(different_nums)
    if abs(different_nums(k)) != 1
      if abs(different_nums(k)) != 0.5
        if different_nums(k) != 0
          nontrivial_nums = nontrivial_nums + num_count(k);
        end
      end
    end
  end
    
  nums_of_matrix = N*N;
  
  trivial_nums = N*N - nontrivial_nums
  
  nontrivial_nums
  
  v = trivial_nums/nontrivial_nums

end
