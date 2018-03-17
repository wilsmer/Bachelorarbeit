%% Dateiname:      dec_to_s1q10.m
%% Funktion:       Konvertiert eine Dezimalzahl in das binaere S1Q10-Format
%% Argumente:      Dezimalzahl im Bereich von -2...+2-1/2^10
%% Abhaenigkeiten: (1) zweier_komplement.m
%% Author:         Thomas Lattmann
%% Datum:          02.11.17
%% Version:        1.0

function bit_vector = dec_to_s1q10(val)
  
  bit_width=12;
  bit_vector=zeros(1,bit_width);
  dec_temp=0;
  val_abs=abs(val);
  val_int=floor(val_abs);
  val_frac=val_abs-val_int;
    
  if val > 2-1/2^(bit_width-2) % 1.99902... bei 12 Bit und somit 10 Bit fuer Nachkomma
    disp('Diese Zahl kann nicht im s1q11-Format dargestellt werden.')
  elseif val < -2
    disp('Diese Zahl kann nicht im s1q11-Format dargestellt werden.')
  else  
    
    % Vorkommastellen
    if abs(val) >= 1
      bit_vector(2) = 1;
      if val == -2
        bit_vector(1) = 1;
      end
    end
    
    % Nachkommastellen
    for k = 1:bit_width-2
      % berechnen der Differenz des Twiddlefaktors und des derzeitigen Wertes der Binaerzahl
      d = val_frac - dec_temp;
      if d >= 1/2^k
        bit_vector(k+2) = 1;
        dec_temp = dec_temp+1/2^k;
      end
    end
  
    % 2er-Komplement bilden, falls val negativ
    if val < 0
      bit_vector=zweier_komplement(bit_vector);
    end
  end
end