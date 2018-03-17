function [X_mn] = dct_2(x_kl)
  if nargout == 1
    mat_values_dct = [];
  else
    ratio = [];
    mat_values_dct = [];
  end 

  [~,N] = size(x_kl);
  X_mn = zeros(N,N);
  
  for n = 2:N
    T = [ones(1,n)*sqrt(1/n); cos(pi/2/n*([1:n-1]'*[1:2:2*n]))*sqrt(2/n)];
  end
  
  T = round(T*10000)/10000
  
  X_mn = T*x_kl*T';
  
end