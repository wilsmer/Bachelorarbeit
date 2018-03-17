function differences = binary_approximation(N)

real_values = dft(ones(N));
difficult_value_count = sum(real_values(:,3));
difficult_values = zeros(difficult_value_count, 1);
bit_width = 12;

k2=0;
for k = 1:length(real_values)
  if real_values(k,3) == 1
    k2 = k2+1;
    difficult_values(k2) = real_values(k,1);
  end
end
  
difficult_values = unique(difficult_values);
difficult_value_count = length(difficult_values);
  
binary_values = zeros(difficult_value_count, bit_width + 1);

for l = 1:difficult_value_count
    binary_values(l,1:bit_width) = sq12(difficult_values(l,1));
    binary_values(l,bit_width+1) = sq2dec(binary_values(l,1:bit_width));
end

differences = zeros(difficult_value_count, 3);
for m = 1:difficult_value_count
  differences(m,1) = difficult_values(m,1);
  differences(m,2) = binary_values(m,bit_width+1);
  differences(m,3) = perc_diff(difficult_values(m), binary_values(m,bit_width+1));
end

%differences