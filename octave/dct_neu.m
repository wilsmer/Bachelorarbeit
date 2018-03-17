function [X_n] = dct_neu(x_k)

  [~,N_col] = size(x_k);
  twiddle_mat = zeros(N_col,N_col);
  X_n = zeros(1,N_col);
  
  for n = 1:N_col     % n: Elemente in X_n
    for k = 1:N_col   % k: Elemente in x_k
      %twiddle_mat(n,k) = cos(((pi*(n-1))*(k-1+0.5))/N_col);
      X_n(n) = X_n(n) + x_k(k) * cos(pi/N_col*(k-0.5)*(n-1));
    end
  end
  
  X_n(1) = X_n(1)/sqrt(2);
  X_n = X_n./sqrt(1/N_col);
  
  %X_n(n) = X_n(n) + x_k(k) * cos(pi*(n-1)/N_col*(k-0.5));
  %X_n = x_k * twiddle_mat;
  %X_n = round(X_n*1000000)/1000000;
end