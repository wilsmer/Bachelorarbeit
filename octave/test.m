W=ones(4);%*(-1);%*sqrt(2)/2;
mat_size=length(W);
bin_mat=zeros(size(W));
bit_width=12;


for m = 1:1 %mat_size
  for n = 1:1 %mat_size
    % Twiddlefaktor an der stelle (m,n)
    val = real(abs(W(m,n)));
    dec_temp = 0;
    % binaeren Vektor erstellen
    bin = zeros(1,bit_width);
    if val >= 1
      bin(2) = 1;
    end
    
    for k = 1:bit_width-2
      % berechnen der Differenz des Twiddlefaktors und des derzeitigen Wertes der Binaerzahl
      d = val - dec_temp
      if d > 1/2^(k-1)
        bin(k+2) = 1;
        dec_temp = dec_temp+1/2^k;
      end
    end
    bin
    % 2er-Komplement bilden, falls Twiddlefaktor negativ
    
    if real(W(m,n)) < 0
      bin(1) = 1;
      if real(W(m,n)) > -1
        bin(2) = 1;
      end
      
      for j = 3:bit_width
        bin(j) = not(bin(j));
      end
      bin(bit_width) = bin(bit_width) + 1;
      for j = 1:bit_width-1
        if bin(bit_width -j +1) == 2
          bin(bit_width -j +1) = 0;
          bin(bit_width -j) = bin(bit_width -j) + 1;
        end
      end      
    end
    bin
    % Konvertierung von Vektor nach Integer
    for l = 1:bit_width
      bin_mat(m,n) = bin_mat(m,n) + bin(bit_width - l + 1)*10^(l-1);
    end
 
    % Dezimalzahl aus Binaerzahl berechnen
    % N = length(bin);
    dec = 0;

    if bin(1) == 1
      dec = -2;
    end
    
    for n = 2:bit_width
      if bin(n) == 1
        dec = dec + 1/2^(n-2);
      end
    end
    dec
  end
end
printf("bin = %012d\n", bin_mat(1,1));
