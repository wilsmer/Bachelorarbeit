function my_dct(m)
  [N,~]=size(m);
  %W=[ones(1,N)/sqrt(N); cos(pi*([1:N-1]'+0.5)*[0:N-1]/(N-1))];
  
%  W(1,1:8) = 2*ones(1,N)/sqrt(N);
  
%  for m=1:N-1
%    for n=1:N-2
%      W(n+1, m) = cos(pi*m*(n+0.5)/N);
%    end
%  end

W=cos(pi/N*([0:N-1]')*([0:N-1]+.5));
%W(1,:)=W(1,:)/sqrt(2);
W
  %A=W*m;
  %A=round(A*100000)/100000*sqrt(2/N)
end