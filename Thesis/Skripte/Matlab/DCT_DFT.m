function dct_dft(N)

%N=9;
%T = [ones(1,N)*sqrt(1/N); cos(pi/2/N*[1:N-1]'*[1:2:2*N])*sqrt(2/N)];
T = cos(pi/8*[0:7]'*([0:7]-0.5))*sqrt(2/N);
W=exp(i*2*pi*[0:N-1]'*[0:N-1]/N);
Wc=real(W);
Ws=imag(W);


mat_values_dct = unique(round(abs(T).*1000000)/1000000)

mat_values_dft_real = unique(round(abs(Wc).*1000000)/1000000);
mat_values_dft_imag = unique(round(abs(Ws).*1000000)/1000000);
mat_values_dft = unique(vertcat(mat_values_dft_real, mat_values_dft_imag))
[s,~]=size(mat_values_dct);

%plot(Wc(1,:),Ws(1,:),'k*', Wc(2,:),Ws(2,:),'y+', Wc(3,:),Ws(3,:),'ro', Wc(4,:),Ws(4,:),'mx', Wc(5,:),Ws(5,:),'bs', Wc(6,:),Ws(6,:),'gp', Wc(7,:),Ws(7,:),'c^', Wc(8,:),Ws(8,:),'r>')
%
%          '+'  crosshair
%          'o'  circle
%          '*'  star
%          '.'  point
%          'x'  cross
%          's'  square
%          'd'  diamond
%          '^'  upward-facing triangle
%          'v'  downward-facing triangle
%          '>'  right-facing triangle
%          '<'  left-facing triangle
%          'p'  pentagram
%          'h'  hexagram

end