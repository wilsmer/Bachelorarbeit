%% Dateiname: bit_vector2integer.m
%% Funktion:  Wandelt einen Vektor von Zahlen in eine einzelne Zahl (Integer)
%%            Beispiel: [0 1 1 0 0 1] => 11001
%%            Um fuehrende Nullen zu erhalten muss z.B.  printf('%06d', Integer)
%%            genutzt werden. Hierbei wird vorne mit Nullen aufgefuellt, wenn
%%            'Integer' weniger als 6 stellen hat.
%% Argumente: Vektor (aus Nullen und Einsen)
%% Author:    Thomas Lattmann
%% Datum:     02.11.17
%% Version:   1.0

function bin_int = bit_vector2integer(bit_vector)
  
  bin_int=0;
  bit_width=length(bit_vector);
  
  % Konvertierung von Vektor nach Integer
  for l = 1:bit_width
    bin_int = bin_int + bit_vector(bit_width - l + 1)*10^(l-1);
  end
 
end
