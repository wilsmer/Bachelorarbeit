
// Generated by Cadence Encounter(R) RTL Compiler RC14.25 - v14.20-s046_1

// Verification Directory fv/konstantenmultiplizierer 

module mult_signed_const(A, Z);
  input [12:0] A;
  output [21:0] Z;
  wire [12:0] A;
  wire [21:0] Z;
  wire n_0, n_2, n_3, n_4, n_5, n_6, n_7, n_8;
  wire n_9, n_10, n_11, n_12, n_13, n_14, n_15, n_16;
  wire n_17, n_18, n_19, n_20, n_21, n_22, n_23, n_24;
  wire n_25, n_26, n_27, n_28, n_29, n_30, n_31, n_32;
  wire n_33, n_34, n_35, n_36, n_37, n_38, n_39, n_40;
  wire n_41, n_42, n_43, n_44, n_45, n_46, n_47, n_48;
  wire n_49, n_50, n_51, n_52, n_53, n_54, n_55, n_56;
  wire n_57, n_58, n_59, n_60, n_61, n_62, n_63, n_64;
  wire n_65, n_66, n_67, n_68, n_69, n_70, n_71, n_72;
  wire n_73, n_74, n_75, n_76, n_77, n_78, n_79, n_80;
  wire n_81, n_82, n_83, n_84, n_85, n_86, n_87, n_88;
  wire n_89, n_90, n_91, n_92, n_93, n_94, n_95, n_96;
  wire n_97, n_98, n_100, n_102, n_104, n_106, n_108, n_110;
  wire n_112, n_114, n_116, n_118, n_120;
  XNR20 g1240(.A (n_120), .B (n_15), .Q (Z[21]));
  ADD31 g1241(.A (n_8), .B (n_64), .CI (n_118), .CO (n_120), .S
       (Z[20]));
  ADD31 g1242(.A (n_63), .B (n_77), .CI (n_116), .CO (n_118), .S
       (Z[19]));
  ADD31 g1243(.A (n_86), .B (n_78), .CI (n_114), .CO (n_116), .S
       (Z[18]));
  ADD31 g1244(.A (n_96), .B (n_87), .CI (n_112), .CO (n_114), .S
       (Z[17]));
  ADD31 g1245(.A (n_97), .B (n_94), .CI (n_110), .CO (n_112), .S
       (Z[16]));
  ADD31 g1246(.A (n_88), .B (n_95), .CI (n_108), .CO (n_110), .S
       (Z[15]));
  ADD31 g1247(.A (n_92), .B (n_89), .CI (n_106), .CO (n_108), .S
       (Z[14]));
  ADD31 g1248(.A (n_90), .B (n_93), .CI (n_104), .CO (n_106), .S
       (Z[13]));
  ADD31 g1249(.A (n_84), .B (n_91), .CI (n_102), .CO (n_104), .S
       (Z[12]));
  ADD31 g1250(.A (n_79), .B (n_85), .CI (n_100), .CO (n_102), .S
       (Z[11]));
  ADD31 g1251(.A (n_82), .B (n_80), .CI (n_98), .CO (n_100), .S
       (Z[10]));
  ADD31 g1252(.A (n_69), .B (n_83), .CI (n_81), .CO (n_98), .S (Z[9]));
  ADD31 g1253(.A (n_40), .B (n_72), .CI (n_73), .CO (n_96), .S (n_97));
  ADD31 g1254(.A (n_16), .B (n_50), .CI (n_74), .CO (n_94), .S (n_95));
  ADD31 g1255(.A (n_67), .B (n_0), .CI (n_76), .CO (n_92), .S (n_93));
  ADD31 g1256(.A (n_52), .B (n_68), .CI (n_55), .CO (n_90), .S (n_91));
  ADD31 g1257(.A (n_75), .B (n_39), .CI (n_65), .CO (n_88), .S (n_89));
  ADD31 g1258(.A (n_71), .B (n_42), .CI (n_44), .CO (n_86), .S (n_87));
  ADD31 g1259(.A (n_53), .B (n_60), .CI (n_56), .CO (n_84), .S (n_85));
  ADD31 g1260(.A (n_61), .B (n_25), .CI (n_48), .CO (n_82), .S (n_83));
  MAJ31 g1261(.A (n_57), .B (n_70), .C (n_66), .Q (n_81));
  ADD31 g1262(.A (n_47), .B (n_54), .CI (n_36), .CO (n_79), .S (n_80));
  ADD31 g1263(.A (n_30), .B (n_38), .CI (n_35), .CO (n_77), .S (n_78));
  ADD31 g1264(.A (A[7]), .B (A[4]), .CI (n_51), .CO (n_75), .S (n_76));
  ADD31 g1265(.A (n_26), .B (n_41), .CI (n_34), .CO (n_73), .S (n_74));
  ADD31 g1266(.A (A[9]), .B (n_33), .CI (n_13), .CO (n_71), .S (n_72));
  ADD31 g1267(.A (A[2]), .B (n_19), .CI (n_62), .CO (n_69), .S (n_70));
  ADD31 g1268(.A (A[6]), .B (A[3]), .CI (n_59), .CO (n_67), .S (n_68));
  MAJ31 g1269(.A (n_21), .B (n_58), .C (n_49), .Q (n_66));
  OAI210 g1270(.A (n_28), .B (n_43), .C (n_50), .Q (n_65));
  OAI210 g1271(.A (n_27), .B (n_45), .C (n_9), .Q (n_64));
  IMUX20 g1272(.A (n_29), .B (n_28), .S (n_45), .Q (n_63));
  ADD31 g1273(.A (A[6]), .B (A[4]), .CI (A[1]), .CO (n_61), .S (n_62));
  ADD31 g1274(.A (A[9]), .B (A[7]), .CI (A[4]), .CO (n_59), .S (n_60));
  ADD31 g1275(.A (A[1]), .B (A[0]), .CI (n_20), .CO (n_57), .S (n_58));
  ADD31 g1276(.A (A[5]), .B (A[2]), .CI (n_18), .CO (n_55), .S (n_56));
  ADD31 g1277(.A (A[4]), .B (A[1]), .CI (n_24), .CO (n_53), .S (n_54));
  ADD31 g1278(.A (A[10]), .B (A[8]), .CI (A[5]), .CO (n_51), .S (n_52));
  NAND20 g1279(.A (n_43), .B (n_28), .Q (n_50));
  OAI210 g1280(.A (n_10), .B (n_23), .C (n_46), .Q (n_49));
  ADD31 g1281(.A (A[3]), .B (A[2]), .CI (A[0]), .CO (n_47), .S (n_48));
  OAI210 g1282(.A (n_22), .B (n_17), .C (A[2]), .Q (n_46));
  AOI210 g1283(.A (n_11), .B (n_2), .C (n_33), .Q (n_45));
  NAND20 g1284(.A (n_38), .B (n_37), .Q (n_44));
  AOI210 g1285(.A (n_11), .B (A[6]), .C (n_33), .Q (n_43));
  OAI210 g1286(.A (n_7), .B (n_27), .C (n_9), .Q (n_42));
  MAJ31 g1287(.A (A[5]), .B (A[7]), .C (A[8]), .Q (n_41));
  IMUX20 g1288(.A (n_28), .B (n_29), .S (A[7]), .Q (n_40));
  IMUX20 g1290(.A (n_4), .B (A[8]), .S (n_25), .Q (n_39));
  NAND20 g1291(.A (n_32), .B (n_4), .Q (n_38));
  NAND20 g1292(.A (n_31), .B (A[8]), .Q (n_37));
  XNR20 g1293(.A (n_16), .B (A[3]), .Q (n_36));
  XNR20 g1294(.A (n_15), .B (A[9]), .Q (n_35));
  ADD21 g1295(.A (A[11]), .B (A[9]), .CO (n_33), .S (n_34));
  INV2 g1296(.A (n_31), .Q (n_32));
  ADD21 g1297(.A (A[11]), .B (A[10]), .CO (n_30), .S (n_31));
  CLKIN3 g1298(.A (n_29), .Q (n_28));
  INV2 g1299(.A (n_9), .Q (n_26));
  ADD21 g1300(.A (n_5), .B (A[12]), .CO (n_27), .S (n_29));
  ADD21 g1301(.A (A[7]), .B (A[5]), .CO (n_24), .S (n_25));
  INV2 g1302(.A (n_22), .Q (n_23));
  ADD21 g1303(.A (A[4]), .B (A[0]), .CO (n_21), .S (n_22));
  ADD21 g1304(.A (A[5]), .B (A[3]), .CO (n_19), .S (n_20));
  OAI210 g1305(.A (n_6), .B (n_12), .C (n_14), .Q (n_18));
  MAJ31 g1306(.A (A[1]), .B (A[3]), .C (A[0]), .Q (n_17));
  NAND20 g1307(.A (n_13), .B (n_14), .Q (n_16));
  IMUX20 g1308(.A (n_2), .B (A[12]), .S (A[11]), .Q (n_15));
  NAND20 g1309(.A (A[8]), .B (A[6]), .Q (n_14));
  CLKIN3 g1310(.A (n_12), .Q (n_13));
  NOR20 g1311(.A (A[6]), .B (A[8]), .Q (n_12));
  NAND20 g1312(.A (n_3), .B (n_8), .Q (n_11));
  NAND20 g1313(.A (A[3]), .B (A[1]), .Q (n_10));
  NAND20 g1314(.A (n_2), .B (A[10]), .Q (n_9));
  INV2 g1315(.A (A[11]), .Q (n_8));
  INV2 g1316(.A (A[7]), .Q (n_7));
  INV2 g1317(.A (A[3]), .Q (n_6));
  INV2 g1318(.A (A[10]), .Q (n_5));
  INV2 g1319(.A (A[8]), .Q (n_4));
  INV2 g1320(.A (A[9]), .Q (n_3));
  INV2 g1321(.A (A[12]), .Q (n_2));
  XOR21 g2(.A (A[6]), .B (n_34), .Q (n_0));
endmodule

module konstantenmultiplizierer(a, x);
  input [12:0] a;
  output [12:0] x;
  wire [12:0] a;
  wire [12:0] x;
  wire [25:0] f_int;
  mult_signed_const const_mul_28_15(.A (a), .Z ({x, f_int[8:0]}));
endmodule

