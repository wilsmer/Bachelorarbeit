
// Generated by Cadence Encounter(R) RTL Compiler RC14.25 - v14.20-s046_1

// Verification Directory fv/konstantenmultiplizierer 

module mult_signed_const(A, Z);
  input [12:0] A;
  output [12:0] Z;
  wire [12:0] A;
  wire [12:0] Z;
  wire n_0, n_2, n_3, n_4, n_5, n_6, n_8, n_9;
  wire n_10, n_11, n_12, n_13, n_14, n_15, n_16, n_18;
  wire n_19, n_20, n_21, n_22, n_23, n_24, n_25, n_27;
  wire n_28, n_29, n_30, n_31, n_32, n_33, n_34, n_35;
  wire n_36, n_38, n_39, n_40, n_42, n_44, n_46;
  XNR30 g562(.A (n_35), .B (n_38), .C (n_46), .Q (Z[12]));
  ADD31 g563(.A (n_31), .B (n_39), .CI (n_44), .CO (n_46), .S (Z[11]));
  ADD31 g564(.A (n_33), .B (n_32), .CI (n_42), .CO (n_44), .S (Z[10]));
  ADD31 g565(.A (n_27), .B (n_34), .CI (n_40), .CO (n_42), .S (Z[9]));
  ADD31 g566(.A (n_18), .B (n_28), .CI (n_36), .CO (n_40), .S (Z[8]));
  ADD31 g567(.A (n_22), .B (n_21), .CI (n_30), .CO (n_38), .S (n_39));
  ADD31 g568(.A (n_8), .B (n_19), .CI (n_25), .CO (n_36), .S (Z[7]));
  XNR30 g569(.A (n_29), .B (n_10), .C (n_24), .Q (n_35));
  ADD31 g570(.A (n_5), .B (n_14), .CI (n_0), .CO (n_33), .S (n_34));
  ADD31 g571(.A (n_11), .B (n_13), .CI (n_23), .CO (n_31), .S (n_32));
  ADD31 g572(.A (A[5]), .B (A[2]), .CI (n_12), .CO (n_29), .S (n_30));
  ADD31 g573(.A (A[2]), .B (n_2), .CI (n_15), .CO (n_27), .S (n_28));
  ADD31 g574(.A (A[2]), .B (n_9), .CI (n_16), .CO (n_25), .S (Z[6]));
  XNR30 g575(.A (A[6]), .B (A[3]), .C (n_20), .Q (n_24));
  ADD31 g576(.A (A[4]), .B (A[1]), .CI (n_4), .CO (n_22), .S (n_23));
  ADD31 g577(.A (A[9]), .B (A[7]), .CI (A[4]), .CO (n_20), .S (n_21));
  ADD31 g578(.A (A[1]), .B (A[0]), .CI (n_3), .CO (n_18), .S (n_19));
  ADD31 g579(.A (A[3]), .B (A[1]), .CI (n_6), .CO (n_16), .S (Z[5]));
  ADD31 g580(.A (A[6]), .B (A[4]), .CI (A[1]), .CO (n_14), .S (n_15));
  ADD31 g581(.A (A[8]), .B (A[6]), .CI (A[3]), .CO (n_12), .S (n_13));
  MAJ31 g582(.A (A[0]), .B (A[2]), .C (A[3]), .Q (n_11));
  XNR30 g584(.A (A[8]), .B (A[5]), .C (A[10]), .Q (n_10));
  ADD21 g585(.A (A[4]), .B (A[0]), .CO (n_8), .S (n_9));
  ADD21 g586(.A (A[2]), .B (A[0]), .CO (n_6), .S (Z[4]));
  ADD21 g587(.A (A[7]), .B (A[5]), .CO (n_4), .S (n_5));
  ADD21 g588(.A (A[5]), .B (A[3]), .CO (n_2), .S (n_3));
  XOR21 g2(.A (A[3]), .B (Z[4]), .Q (n_0));
endmodule

module konstantenmultiplizierer(a, x);
  input [12:0] a;
  output [12:0] x;
  wire [12:0] a;
  wire [12:0] x;
  wire UNCONNECTED, UNCONNECTED0, UNCONNECTED1, UNCONNECTED2,
       UNCONNECTED_HIER_Z, UNCONNECTED_HIER_Z0;
  assign x[0] = 1'b0;
  assign x[1] = 1'b0;
  assign x[2] = a[0];
  assign x[3] = a[1];
  mult_signed_const const_mul_28_15(.A ({UNCONNECTED_HIER_Z0,
       UNCONNECTED_HIER_Z, a[10:0]}), .Z ({x[12:4], UNCONNECTED2,
       UNCONNECTED1, UNCONNECTED0, UNCONNECTED}));
endmodule
