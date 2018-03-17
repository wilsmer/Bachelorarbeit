%% Dateiname: s1q10_to_dec.m
%% Funktion:  Konvertiert eine binaere Zahl im S1Q10-Format als Dezimalzahl
%% Argumente: Vektor aus Nullen und Einsen
%% Author:    Thomas Lattmann
%% Datum:     02.11.17
%% Version:   1.0

function dec = s1q10_to_dec(bit_vector)
  
  % Dezimalzahl aus s1q10 Binaerzahl berechnen

  bit_width=length(bit_vector);
  dec = 0;

  if bit_vector(1) == 1
    dec = -2;
    if bit_vector(2) == 1
      dec = -1;
    end
  elseif bit_vector(2) == 1
    dec = 1;
  end
  
  for n = 3:bit_width
    if bit_vector(n) == 1
      dec = dec + 1/2^(n-2);
    end
  end
end
