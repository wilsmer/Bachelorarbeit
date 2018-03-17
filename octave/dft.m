function [tw_real, tw_imag] = dft(x_k)
  
  N=length(x_k);
  X_n = zeros(1,N);
  
  twiddle_mat = exp(-i*2*pi*[0:N-1]'*[0:N-1]/N);
  
  tw_real = round(real(twiddle_mat)*100000)/100000;
  tw_imag = round(imag(twiddle_mat)*100000)/100000;
  
  
  %% make numbers close to 0 exactly 0 (-0.000 i.e.)
  for n = 1:N
    for m = 1:N
      if abs(tw_real(m,n)) < 0.000001 
        tw_real(m,n) = 0;
      end
      if abs(tw_imag(m,n)) < 0.000001 
        tw_imag(m,n) = 0;
      end
    end
  end
  
  %% count amount of different numbers
  different_nums_real = unique(tw_real);
  different_nums_imag = unique(tw_imag);
  
  num_count_real = zeros(1, length(different_nums_real));
  for k = 1:length(different_nums_real)
    for n = 1:N
      for m = 1:N
        if different_nums_real(k) == tw_real(m,n)
          num_count_real(k) = num_count_real(k) +1;
        end
      end
    end
  end
  
  list_real = zeros(length(num_count_real), 3);
  list_real(:,1) = different_nums_real;
  list_real(:,2) = num_count_real;
  list_real(:,3) = 0;
  
  
  num_count_imag = zeros(1,length(different_nums_imag));
  for k = 1:length(different_nums_imag)
    for n = 1:N
      for m = 1:N
        if different_nums_imag(k) == tw_imag(m,n)
          num_count_imag(k) = num_count_imag(k) +1;
        end
      end
    end
  end
    
  list_imag = zeros(length(num_count_imag), 3);
  list_imag(:,1) = different_nums_imag;
  list_imag(:,2) = num_count_imag;
  list_imag(:,3) = 0;  
  
  %list_real
  %list_imag
  
  difficult_nums_real = 0;
  
  for k = 1:length(list_real)
    if abs(list_real(k, 1)) != 1
      if abs(list_real(k, 1)) != 0.5
        if list_real(k, 1) != 0
          difficult_nums_real = difficult_nums_real + list_real(k, 2);
          list_real(k,3) = 1;
        end
      end
    end
  end
  
  difficult_nums_imag = 0;
  
  for k = 1:length(list_imag)
    if abs(list_imag(k, 1)) != 1
      if abs(list_imag(k, 1)) != 0.5
        if list_imag(k, 1) != 0
          difficult_nums_imag = difficult_nums_imag + list_imag(k, 2);
          list_imag(k,3) = 1;
        end
      end
    end
  end  
  
  NxN = N*N;
  
  easy_nums_real = NxN - difficult_nums_real;
  %difficult_nums_real
  
  %disp("")
  easy_nums_imag = NxN - difficult_nums_imag;
  %difficult_nums_imag
  
  %disp("")
  NxN_mal_2 = N*N*2;
  
  easy_nums_total = easy_nums_real + easy_nums_imag
  difficult_nums_total = difficult_nums_real + difficult_nums_imag
  
  %disp("")
  v = easy_nums_total/difficult_nums_total %NxN_mal_2
  
  %tw_real
  tw_imag
  
  X_n = x_k * twiddle_mat;
  
  %ret_val = zeros(length(list_real) + length(list_imag), 3);
  %ret_val(1:length(list_real), :) = list_real;
  %ret_val(length(list_real)+1:length(list_real)+length(list_imag), :) = list_imag;
  
end