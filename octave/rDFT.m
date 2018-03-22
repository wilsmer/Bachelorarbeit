clear

N=4;

A=round(rand(N)*10);
B=round(rand(N)*10);
W=exp(-i*2*pi*[0:N-1]'*[0:N-1]/N);

X1=W*A;
X1_r=real(X1);
X1_i=imag(X1);

X2=W*B;
X2_r=real(X2);
X2_i=imag(X2);


Y1=X1_r*W;
Y2=X1_i*W;

Y1_r=real(Y1);
Y1_i=imag(Y1);
Y2_r=real(Y2);
Y2_i=imag(Y2);


rp_y=Y1_r-Y2_i;
ip_y=Y2_r+Y1_i;

Y=rp_y+i*ip_y

F1=fft2(A)


Z1=X2_r*W;
Z2=X2_i*W;

Z1_r=real(Z1);
Z1_i=imag(Z1);
Z2_r=real(Z2);
Z2_i=imag(Z2);

rp_z=Z1_r-Z2_i;
ip_z=Z2_r+Z1_i;

Z=rp_z+i*ip_z

F2=fft2(B)


%C=real(Y)-imag(Z)+i*(real(Z)+imag(Y))

%fft2(A+i*B)



 

