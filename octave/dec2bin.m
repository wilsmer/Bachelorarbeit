value = sqrt(2)/2;
%value = 0.75;
bitwidth = 16;
w = zeros(1,bitwidth);
y = 1;

if value < 0
  w(1) = 1;
end

for b = 2:bitwidth
  if y - 1/2^b >= value
    w(b) = 1;
    y = y - 1/2^b;
  end
end
w
y
