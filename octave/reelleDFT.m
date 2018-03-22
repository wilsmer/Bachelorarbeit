N=4;

A=round(rand(N)*10);
B=round(rand(N)*10);
W=exp(-i*2*pi*[0:N-1]'*[0:N-1]/N);

X1=W*A;
X2=W*B;

X1_r=real(X1);
X1_i=imag(X1);

X2_r=real(X2);
X2_i=imag(X2);


%falsch
%Y1=X1_r+X2_r;
%Y2=X1_i+X2_i;

%falsch
%Y1=X1_r+X2_i;
%Y2=X1_i+X2_r;

%falsch
%Y1=X1_i+X2_r;
%Y2=X2_i+X1_r;

%falsh
%Y1=X1_i+X1_r;
%Y2=X2_i+X2_r;




%falsch
%Y1=X1_r-X2_r;
%Y2=X1_i-X2_i;

%falsch
%Y1=X1_r-X2_i;
%Y2=X1_i-X2_r;

%falsch
%Y1=X1_i-X2_r;
%Y2=X2_i-X1_r;

%falsch
%Y1=X1_i-X1_r;
%Y2=X2_i-X2_r;




%falsch
%Y1=X1_r+X2_i;
%Y2=X2_r+X1_i;

%falsch
%Y1=X1_r+X2_i;
%Y2=X2_i+X1_r;

%falsch
Y1=X1_i+X2_r;
Y2=X2_i+X1_r;

%falsh
%Y1=X1_i+X1_r;
%Y2=X1_i+X2_r;


Z1=Y1*W;
Z2=Y2*W;

Z1_r=real(Z1);
Z2_r=real(Z2);

Z1_i=imag(Z1);
Z2_i=imag(Z2);

%Z=real(Z1)+imag(Z2)-i*(imag(Z1)+real(Z2))
Z=Z1_r+Z2_r+i*(Z1_i+Z2_i)

F=fft2(A+i*B)

%F-Z