A1=[1,  1,  1,  1,  1,  1,  1,  1; ...
    1,  3,  0, -3, -1, -3,  0,  3; ...
    1,  0, -1,  0,  1,  0, -1,  0; ...
    1, -3,  0,  3, -1,  3,  0, -3; ...
    1, -1,  1, -1,  1, -1,  1, -1; ...
    1, -3,  0,  3, -1,  3,  0, -3; ...
    1,  0, -1,  0,  1,  0, -1,  0; ...
    1,  3,  0, -3, -1, -3,  0,  3];
   
 A2=[0,  0,  0,  0, 0,  0,  0,  0; ...
     0,  3,  1,  3, 0, -3, -1, -3; ...
     0,  1,  0, -1, 0,  1,  0, -1; ...
     0,  3, -1,  3, 0, -3,  1, -3; ...
     0,  0,  0,  0, 0,  0,  0,  0; ...
     0, -3,  1, -3, 0,  3, -1,  3; ...
     0, -1,  0,  1, 0, -1,  0,  1; ...
     0, -3, -1, -3, 0,  3,  1,  3];
    
  A = (A1+i*A2);
  %size(A)
  #{
  C1=[1, 2, 3, 4, 5, 6, 7, 8;...
      6, 2, 3, 4, 5, 6, 7, 8;...
      3, 2, 3, 4, 2, 6, 7, 8;...
      1, 2, 3, 4, 5, 6, 7, 8;...
      1, 2, 3, 4, 4, 6, 7, 8;...
      1, 2, 3, 4, 5, 6, 7, 8;...
      1, 2, 3, 4, 5, 6, 7, 8;...
      1, 2, 3, 4, 5, 6, 7, 8];
      
  C2=[1, 2, 3, 4, 5, 6, 7, 8;...
      1, 2, 3, 4, 5, 6, 7, 8;...
      1, 3, 3, 4, 5, 6, 7, 8;...
      1, 2, 3, 4, 5, 6, 7, 8;...
      1, 5, 3, 4, 5, 6, 7, 8;...
      1, 2, 3, 4, 5, 4, 7, 8;...
      1, 2, 3, 4, 5, 5, 7, 8;...
      1, 2, 3, 4, 5, 6, 7, 8];
  #}
  C1=[    6    9    7    2    3    4    3    4;...
    3    5    2    8    0    6    4    4;...
    0    7    1    1    8    4    1    5;...
    4    0    8    7    8    7    7    0;...
    9    3    6    2    2    2    0    3;...
    5   10    6    2    0    5    1    9;...
    5    3    1    5    3    7    6    6;...
    3    9    3    4    8    0    6    4];
    
  C2=[    1    4    9    6    0    2    2    7;...
    4    9    7    8    5    8    7    0;...
    8    2    1    3    6    2    8   10;...
    7    6    7    4    2    9    1    1;...
    9    8    4    5   10    4    7    2;...
    4    1   10    6    6    9    8    4;...
    3    1    8    0    1    5    4    7;...
    9    9    2    7    8    7    6    8];
  
  C=(C1+i*C2);
  %size(C)
  
  E=A*C
  