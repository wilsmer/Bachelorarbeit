%% Dateiname: twiddle_coefficients.m
%% Funktion:  Erstellt eine Matrix (W) mit den Twiddlefaktoren fuer die DFT der
%%            Groesse, die mit N an das Skript uebergeben wurde.
%% Argumente: N (Groesse der NxN DFT-Matrix)
%% Author:    Thomas Lattmann
%% Datum:     02.11.17
%% Version:   1.0

function W = twiddle_coefficients(N)
  
  % Twiddlefaktoren fuer die DFT
  W = exp(-i*2*pi*[0:N-1]'*[0:N-1]/N)
  
  % auf 6 Nachkommastellen reduzieren
  W = round(W*1000000)/1000000;
  
  % negative Nullen auf 0 setzen
  W_real = real(W);
  W_imag = imag(W);
  W_real(abs(W_real)<00000.1) = 0;
  W_imag(abs(W_imag)<00000.1) = 0;
  W = W_real + i*W_imag;

end
