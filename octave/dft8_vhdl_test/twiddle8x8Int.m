A=[1, 1, 1, 1, 1, 1, 1, 1; ...
   1, 3, 0, 3, -1, 3, 0, 3; ...
   1, 0, -1, 0, 1, 0, -1, 0; ...
   1, 3, 0, 3, -1, 3, 0, 3; ...
   1, -1, 1, -1, 1, -1, 1, -1; ...
   1, 3, 0, 3, -1, 3, 0, 3; ...
   1, 0, -1, 0, 1, 0, -1, 0; ...
   1, 3, 0, 3, -1, 3, 0, 3];
   
 B=[0, 0, 0, 0, 0, 0, 0, 0; ...
    0, 3, -1, 3, 0, 3, 1, 3; ...
    0, -1, 0, 1, 0, -1, 0, 1; ...
    0, 3, 1, 3, 0, 3, -1, 3; ...
    0, 0, 0, 0, 0, 0, 0, 0; ...
    0, 3, -1, 3, 0, 3, 1, 3; ...
    0, 1, 0, -1, 0, 1, 0, -1; ...
    0, 3, 1, 3, 0, 3, -1, 3];
    
  C = A+i*B
  
  C*(ones(8)+i*ones(8))