close all 
clear all 
clc  

disp('1')

A = rand(8,8)+1i.*rand(8,8);
pkg load symbolic

syms    r11 r12 r13 r14 r15 r16 r17 r18 ...
        r21 r22 r23 r24 r25 r26 r27 r28 ...
        r31 r32 r33 r34 r35 r36 r37 r38 ...
        r41 r42 r43 r44 r45 r46 r47 r48 ...
        r51 r52 r53 r54 r55 r56 r57 r58 ...
        r61 r62 r63 r64 r65 r66 r67 r68 ...
        r71 r72 r73 r74 r75 r76 r77 r78 ...
        r81 r82 r83 r84 r85 r86 r87 r88 ...
        i11 i12 i13 i14 i15 i16 i17 i18 ...
        i21 i22 i23 i24 i25 i26 i27 i28 ...
        i31 i32 i33 i34 i35 i36 i37 i38 ...
        i41 i42 i43 i44 i45 i46 i47 i48 ...
        i51 i52 i53 i54 i55 i56 i57 i58 ...
        i61 i62 i63 i64 i65 i66 i67 i68 ...
        i71 i72 i73 i74 i75 i76 i77 i78 ...
        i81 i82 i83 i84 i85 i86 i87 i88
    
    
%% Create komplex matrix 

Im = [  i11 i12 i13 i14 i15 i16 i17 i18
        i21 i22 i23 i24 i25 i26 i27 i28
        i31 i32 i33 i34 i35 i36 i37 i38
        i41 i42 i43 i44 i45 i46 i47 i48
        i51 i52 i53 i54 i55 i56 i57 i58
        i61 i62 i63 i64 i65 i66 i67 i68
        i71 i72 i73 i74 i75 i76 i77 i78
        i81 i82 i83 i84 i85 i86 i87 i88];

Re = [  r11 r12 r13 r14 r15 r16 r17 r18
        r21 r22 r23 r24 r25 r26 r27 r28
        r31 r32 r33 r34 r35 r36 r37 r38
        r41 r42 r43 r44 r45 r46 r47 r48
        r51 r52 r53 r54 r55 r56 r57 r58
        r61 r62 r63 r64 r65 r66 r67 r68
        r71 r72 r73 r74 r75 r76 r77 r78
        r81 r82 r83 r84 r85 r86 r87 r88];

Z = Re+1i*Im; 

%%
N = 8; 
for n = 0 : N-1
  for m = 0 : N-1
    W(n+1,m+1) = exp(-1i*2*pi*n*m/N); 
  end 
end 
% 
% W2 = (W); 
% disp(W2)
W = round(W.*1e3)./1e3;
res1 = W*A*W;  
res2 = fft2(A);




clc
R = res1-res2; 
R(R<1*10^-8)=0; 
disp(real(R))


% result2 = W2*((A))*W2'; 
%  
% x = 4.3; 
% 
% y1 = x*sqrt(0.5); 
% y2 = x.^2*0.5;

%% First step 

%%
fileID = fopen('dftTEST.txt','w');
for f = 1
    RES = W*Z(:,f);   
    for row = 1 : 8
            sRE = char(real(RES(row))); 
            sIM = char(imag(RES(row))); 
            
            sRE = strrep(sRE,'real','');
            sRE = strrep(sRE,'/1000','');
            sRE = strrep(sRE,'707','0.7071');
            sRE = strrep(sRE,'imag','');
            sRE = strrep(sRE,')','');
            sRE = strrep(sRE,'(','');
            sIM = strrep(sIM,'real','');
            sIM = strrep(sIM,'imag','');
            sIM = strrep(sIM,'/1000','');
            sIM = strrep(sIM,'707','0.7071');
            sIM = strrep(sIM,')','');
            sIM = strrep(sIM,'(','');
            
            fprintf(fileID,['RE',mat2str(row),mat2str(f),' = ',sRE]);
            fprintf(fileID,'\n\n');
            fprintf(fileID,['IM',mat2str(row),mat2str(f),' = ',sIM]);
            fprintf(fileID,'\n\n');
    end
end
fclose(fileID);

















