%% Dateiname:        twiddle2file.m
%% Funktion:         Erzeugt eine Datei mit den binaeren komplexen 
%%                   Twiddlefaktoren
%% Argumente:        N (Groesse der NxN DFT-Matrix)
%% Aufbau der Datei: Wie die Matrix, enthaelt Realteil und Imaginaerteil.
%%                   Alle Werte sind wie im Beispiel durch Leerzeichen getrennt:
%%                   Re{W(1,1)} Im{W(1,1)} Re{W(1,2)} Im{W(1,2)} 
%%                   Re{W(2,1)} Im{W(2,1)} Re{W(2,2)} Im{W(2,2)}
%% Abhaenigkeiten:   (1) twiddle_coefficients.m
%%                   (2) dec_to_s1q10.m
%%                   (3) bit_vector2integer.m
%%                   (4) zweier_komplement.m
%% Author:           Thomas Lattmann
%% Datum:            02.11.17
%% Version:          1.0

function twiddle2file(N)
  
  % Dezimale Twiddlefaktormatrix erstellen
  W_dec = twiddle_coefficients(N);
  %save('Twiddle_komplex_Int','W_dec')
  W_dec_real = real(W_dec);
  W_dec_imag = imag(W_dec);
  
  W_bin_int_real = zeros(size(W_dec_real));
  W_bin_int_imag = zeros(size(W_dec_imag));
  
  for m = 1:N
    for n = 1:N
      bit_vector = dec_to_s1q10(W_dec_real(m,n));
      W_bin_int_real(m,n) = bit_vector2integer(bit_vector);
      
      bit_vector = dec_to_s1q10(W_dec_imag(m,n));
      W_bin_int_imag(m,n) = bit_vector2integer(bit_vector);
    end
  end

  fid=fopen('Twiddle_s1q10_komplex.txt', 'w+');

  for m=1:N
    for n=1:N
      fprintf(fid, '%012d ', W_bin_int_real(m,n));
      fprintf(fid, '%012d', W_bin_int_imag(m,n));
      if n < N
        fprintf(fid, ' ');
      end
    end
    if m < N
      fprintf(fid, '\n');
    end
  end

  fclose(fid);
  
end