N = 12;       % Anzahl der Bits, hier SQ12
dec_temp = 0;

if dec >= 0   % dezimale Zahl
  bin = zeros(1,N);
  for n = 2:N
    if dec_temp + 1/2^(n-1) <= dec + 1/2^(N+1)
      dec_temp = dec_temp + 1/2^(n-1);
      bin(n) = 1;
    end
  end
else
  bin = ones(1,N);
  for n = 2:N
    if dec_temp - 1/2^(n-1) >= dec - 1/2^(N+1)
      dec_temp = dec_temp - 1/2^(n-1);
      bin(n) = 0;
    end
  end
end