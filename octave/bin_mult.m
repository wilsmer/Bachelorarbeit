function bin_out = bin_mult(bin_in1, bin_in2)

N = length(bin_in1);
bin_temp = zeros(N, 2*N);
bin_out = zeros(1, 2*N);

for m = 1:N
  bin_temp(m,N-m+2:2*N-m+1) = bin_in1(N-m+1) .* bin_in2;
end

for l = 1:N
  for m = 1:2*N
    for n = 1:2*N
      if bin_out(2*N-n+1) == 2
        bin_out(2*N-n) = bin_out(2*N-n) + 1;
        bin_out(2*N-n+1) = 0;
      end
    end
    bin_out(m) = bin_out(m) + bin_temp(l,m);
  end
end

for n = 1:2*N
  if bin_out(2*N-n+1) == 2
    bin_out(2*N-n) = bin_out(2*N-n) + 1;
    bin_out(2*N-n+1) = 0;
  end
end