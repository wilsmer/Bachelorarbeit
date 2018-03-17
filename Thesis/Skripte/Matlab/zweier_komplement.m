%% Dateiname: zweier_komplement.m
%% Funktion:  Bilden des 2er-Komplements eines "Bit"-Vektors
%% Argumente: Vektor aus Nullen und Einsen
%% Author:    Thomas Lattmann
%% Datum:     02.11.17
%% Version:   1.0

function bit_vector = zweier_komplement(bit_vector)
  bit_width=length(bit_vector);
  
  for j = 1:bit_width
    bit_vector(j) = not(bit_vector(j));
  end
  bit_vector(bit_width) = bit_vector(bit_width) + 1;
  for j = 1:bit_width-1
    if bit_vector(bit_width -j +1) == 2
      bit_vector(bit_width -j +1) = 0;
      bit_vector(bit_width -j) = bit_vector(bit_width -j) + 1;
    end
  end          
end
