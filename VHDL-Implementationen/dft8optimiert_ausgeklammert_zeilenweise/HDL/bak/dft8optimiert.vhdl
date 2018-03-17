
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
library work;
use work.all;
use datatypes.all;
use constants.all;
use functions.all;


entity dft8optimiert is
port(
     clk           : in  bit;
     nReset        : in  bit;
     loaded        : in  bit;
     multState_out : out t_dft8_states;
     input_real    : in  t_2d_array;
     input_imag    : in  t_2d_array;
     result_real   : out t_2d_array;
     result_imag   : out t_2d_array;
     constMult1_1_re_out : out signed(bit_width_extern-1 downto 0);
     constMult1_3_re_out : out signed(bit_width_extern-1 downto 0);
     constMult1_5_re_out : out signed(bit_width_extern-1 downto 0);
     constMult1_7_re_out : out signed(bit_width_extern-1 downto 0);
     constMult1_1_im_out : out signed(bit_width_extern-1 downto 0);
     constMult1_3_im_out : out signed(bit_width_extern-1 downto 0);
     constMult1_5_im_out : out signed(bit_width_extern-1 downto 0);
     constMult1_7_im_out : out signed(bit_width_extern-1 downto 0);
     sum1_stage1_1v6_re_out : out signed(bit_width_adder-1 downto 0);
     sum1_stage1_2v6_re_out : out signed(bit_width_adder-1 downto 0);
     sum1_stage1_3v6_re_out : out signed(bit_width_adder-1 downto 0);
     sum1_stage1_4v6_re_out : out signed(bit_width_adder-1 downto 0);
     sum1_stage1_5v6_re_out : out signed(bit_width_adder-1 downto 0);
     sum1_stage1_6v6_re_out : out signed(bit_width_adder-1 downto 0)
    );
end dft8optimiert;

architecture arch of dft8optimiert is

------------------------------ 1. Zeile-----------------------------------
-- Stufe 1
-- Real
signal sum0_stage1_1v4_re             : signed(bit_width_adder-1 downto 0) := (others => '0');
signal sum0_stage1_2v4_re             : signed(bit_width_adder-1 downto 0) := (others => '0');
signal sum0_stage1_3v4_re             : signed(bit_width_adder-1 downto 0) := (others => '0');
signal sum0_stage1_4v4_re             : signed(bit_width_adder-1 downto 0) := (others => '0');
-- Imag
signal sum0_stage1_1v4_im             : signed(bit_width_adder-1 downto 0) := (others => '0');
signal sum0_stage1_2v4_im             : signed(bit_width_adder-1 downto 0) := (others => '0');
signal sum0_stage1_3v4_im             : signed(bit_width_adder-1 downto 0) := (others => '0');
signal sum0_stage1_4v4_im             : signed(bit_width_adder-1 downto 0) := (others => '0');

-- Stufe 2
--Real
signal sum0_stage2_1v2_re         : signed(bit_width_adder downto 0) := (others => '0');
signal sum0_stage2_2v2_re         : signed(bit_width_adder downto 0) := (others => '0');
--Imag
signal sum0_stage2_1v2_im         : signed(bit_width_adder downto 0) := (others => '0');
signal sum0_stage2_2v2_im         : signed(bit_width_adder downto 0) := (others => '0');

-- Stufe 3
--Real
signal sum0_stage3_1v1_re : signed(bit_width_adder+1 downto 0) := (others => '0');
--Imag
signal sum0_stage3_1v1_im : signed(bit_width_adder+1 downto 0) := (others => '0');


------------------------------ 2. Zeile-----------------------------------
-- Stufe 1
-- Werte fuer Konstantenmultiplikation
signal constMult          : t_1d_array64;  --t_1d_array127

-- Stufe 2
-- Real
signal sum1_stage1_1v6_re          : signed(bit_width_adder-1 downto 0) := (others => '0');
signal sum1_stage1_2v6_re          : signed(bit_width_adder-1 downto 0) := (others => '0');
signal sum1_stage1_3v6_re          : signed(bit_width_adder-1 downto 0) := (others => '0');
signal sum1_stage1_4v6_re          : signed(bit_width_adder-1 downto 0) := (others => '0');
signal sum1_stage1_5v6_re          : signed(bit_width_adder-1 downto 0) := (others => '0');
signal sum1_stage1_6v6_re          : signed(bit_width_adder-1 downto 0) := (others => '0');

--Imag
signal sum1_stage1_1v6_im          : signed(bit_width_adder-1 downto 0) := (others => '0');
signal sum1_stage1_2v6_im          : signed(bit_width_adder-1 downto 0) := (others => '0');
signal sum1_stage1_3v6_im          : signed(bit_width_adder-1 downto 0) := (others => '0');
signal sum1_stage1_4v6_im          : signed(bit_width_adder-1 downto 0) := (others => '0');
signal sum1_stage1_5v6_im          : signed(bit_width_adder-1 downto 0) := (others => '0');
signal sum1_stage1_6v6_im          : signed(bit_width_adder-1 downto 0) := (others => '0');


-- Stufe 3
-- Real
signal sum1_stage2_1v3_re      : signed(bit_width_adder downto 0) := (others => '0');
signal sum1_stage2_2v3_re      : signed(bit_width_adder downto 0) := (others => '0');
signal sum1_stage2_3v3_re      : signed(bit_width_adder downto 0) := (others => '0');
--Imag
signal sum1_stage2_1v3_im      : signed(bit_width_adder downto 0) := (others => '0');
signal sum1_stage2_2v3_im      : signed(bit_width_adder downto 0) := (others => '0');
signal sum1_stage2_3v3_im      : signed(bit_width_adder downto 0) := (others => '0');

-- Stufe 4
-- Real
signal sum1_stage3_1v1_re   : signed(bit_width_adder+1 downto 0) := (others => '0');
-- Imag
signal sum1_stage3_1v1_im   : signed(bit_width_adder+1 downto 0) := (others => '0');

--Stufe 5
-- Real
signal sum1_stage4_1v1_re     : signed(bit_width_adder+2 downto 0) := (others => '0');
-- Imag
signal sum1_stage4_1v1_im     : signed(bit_width_adder+2 downto 0) := (others => '0');


------------------------------ 3. Zeile-----------------------------------

-- Stufe 2
-- Real
signal sum2_stage1_1v4_re             : signed(bit_width_adder-1 downto 0) := (others => '0');
signal sum2_stage1_2v4_re             : signed(bit_width_adder-1 downto 0) := (others => '0');
signal sum2_stage1_3v4_re             : signed(bit_width_adder-1 downto 0) := (others => '0');
signal sum2_stage1_4v4_re             : signed(bit_width_adder-1 downto 0) := (others => '0');
-- Imag
signal sum2_stage1_1v4_im             : signed(bit_width_adder-1 downto 0) := (others => '0');
signal sum2_stage1_2v4_im             : signed(bit_width_adder-1 downto 0) := (others => '0');
signal sum2_stage1_3v4_im             : signed(bit_width_adder-1 downto 0) := (others => '0');
signal sum2_stage1_4v4_im             : signed(bit_width_adder-1 downto 0) := (others => '0');

-- Stufe 2
-- Real
signal sum2_stage2_1v2_re         : signed(bit_width_adder downto 0) := (others => '0');
signal sum2_stage2_2v2_re         : signed(bit_width_adder downto 0) := (others => '0');
-- Imag
signal sum2_stage2_1v2_im         : signed(bit_width_adder downto 0) := (others => '0');
signal sum2_stage2_2v2_im         : signed(bit_width_adder downto 0) := (others => '0');

-- Stufe 3
-- Real
signal sum2_stage3_1v1_re : signed(bit_width_adder+1 downto 0) := (others => '0');
-- Imag
signal sum2_stage3_1v1_im : signed(bit_width_adder+1 downto 0) := (others => '0');

------------------------------ 4. Zeile-----------------------------------
-- Stufe 1
signal constMult3_1_re        : signed(bit_width_extern-1 downto 0) := (others => '0');
signal constMult3_3_re        : signed(bit_width_extern-1 downto 0) := (others => '0');
signal constMult3_5_re        : signed(bit_width_extern-1 downto 0) := (others => '0');
signal constMult3_7_re        : signed(bit_width_extern-1 downto 0) := (others => '0');

signal constMult3_1_im        : signed(bit_width_extern-1 downto 0) := (others => '0');
signal constMult3_3_im        : signed(bit_width_extern-1 downto 0) := (others => '0');
signal constMult3_5_im        : signed(bit_width_extern-1 downto 0) := (others => '0');
signal constMult3_7_im        : signed(bit_width_extern-1 downto 0) := (others => '0');

-- Stufe 2
-- Real
signal sum3_stage1_1v6_re          : signed(bit_width_adder-1 downto 0) := (others => '0');
signal sum3_stage1_2v6_re          : signed(bit_width_adder-1 downto 0) := (others => '0');
signal sum3_stage1_3v6_re          : signed(bit_width_adder-1 downto 0) := (others => '0');
signal sum3_stage1_4v6_re          : signed(bit_width_adder-1 downto 0) := (others => '0');
signal sum3_stage1_5v6_re          : signed(bit_width_adder-1 downto 0) := (others => '0');
signal sum3_stage1_6v6_re          : signed(bit_width_adder-1 downto 0) := (others => '0');
--Imag
signal sum3_stage1_1v6_im          : signed(bit_width_adder-1 downto 0) := (others => '0');
signal sum3_stage1_2v6_im          : signed(bit_width_adder-1 downto 0) := (others => '0');
signal sum3_stage1_3v6_im          : signed(bit_width_adder-1 downto 0) := (others => '0');
signal sum3_stage1_4v6_im          : signed(bit_width_adder-1 downto 0) := (others => '0');
signal sum3_stage1_5v6_im          : signed(bit_width_adder-1 downto 0) := (others => '0');
signal sum3_stage1_6v6_im          : signed(bit_width_adder-1 downto 0) := (others => '0');

-- Stufe 3
-- Real
signal sum3_stage2_1v3_re     : signed(bit_width_adder downto 0) := (others => '0');
signal sum3_stage2_2v3_re     : signed(bit_width_adder downto 0) := (others => '0');
signal sum3_stage2_3v3_re     : signed(bit_width_adder downto 0) := (others => '0');
--Imag
signal sum3_stage2_1v3_im     : signed(bit_width_adder downto 0) := (others => '0');
signal sum3_stage2_2v3_im     : signed(bit_width_adder downto 0) := (others => '0');
signal sum3_stage2_3v3_im     : signed(bit_width_adder downto 0) := (others => '0');

-- Stufe 4
-- Real
signal sum3_stage3_1v1_re         : signed(bit_width_adder+1 downto 0) := (others => '0');
-- Imag
signal sum3_stage3_1v1_im         : signed(bit_width_adder+1 downto 0) := (others => '0');

--Stufe 5
-- Imag
signal sum3_stage4_1v1_re : signed(bit_width_adder+2 downto 0) := (others => '0');
-- Imag
signal sum3_stage4_1v1_im : signed(bit_width_adder+2 downto 0) := (others => '0');

------------------------------ 5. Zeile-----------------------------------
-- Stufe 1
-- Real
signal sum4_stage1_1v4_re       : signed(bit_width_adder-1 downto 0) := (others => '0');
signal sum4_stage1_2v4_re       : signed(bit_width_adder-1 downto 0) := (others => '0');
signal sum4_stage1_3v4_re       : signed(bit_width_adder-1 downto 0) := (others => '0');
signal sum4_stage1_4v4_re       : signed(bit_width_adder-1 downto 0) := (others => '0');
-- Imag
signal sum4_stage1_1v4_im       : signed(bit_width_adder-1 downto 0) := (others => '0');
signal sum4_stage1_2v4_im       : signed(bit_width_adder-1 downto 0) := (others => '0');
signal sum4_stage1_3v4_im       : signed(bit_width_adder-1 downto 0) := (others => '0');
signal sum4_stage1_4v4_im       : signed(bit_width_adder-1 downto 0) := (others => '0');

-- Stufe 2
-- Real
signal sum4_stage2_1v2_re     : signed(bit_width_adder downto 0) := (others => '0');
signal sum4_stage2_2v2_re     : signed(bit_width_adder downto 0) := (others => '0');
-- Imag
signal sum4_stage2_1v2_im     : signed(bit_width_adder downto 0) := (others => '0');
signal sum4_stage2_2v2_im     : signed(bit_width_adder downto 0) := (others => '0');

-- Stufe 3
-- Real
signal sum4_stage3_1v1_re : signed(bit_width_adder+1 downto 0) := (others => '0');
-- Imag
signal sum4_stage3_1v1_im : signed(bit_width_adder+1 downto 0) := (others => '0');


------------------------------ 6. Zeile-----------------------------------
-- Stufe 1
signal constMult5_1_re        : signed(bit_width_extern-1 downto 0) := (others => '0');
signal constMult5_3_re        : signed(bit_width_extern-1 downto 0) := (others => '0');
signal constMult5_5_re        : signed(bit_width_extern-1 downto 0) := (others => '0');
signal constMult5_7_re        : signed(bit_width_extern-1 downto 0) := (others => '0');

signal constMult5_1_im        : signed(bit_width_extern-1 downto 0) := (others => '0');
signal constMult5_3_im        : signed(bit_width_extern-1 downto 0) := (others => '0');
signal constMult5_5_im        : signed(bit_width_extern-1 downto 0) := (others => '0');
signal constMult5_7_im        : signed(bit_width_extern-1 downto 0) := (others => '0');

-- Stufe 2
-- Real
signal sum5_stage1_1v6_re       : signed(bit_width_adder-1 downto 0) := (others => '0');
signal sum5_stage1_2v6_re       : signed(bit_width_adder-1 downto 0) := (others => '0');
signal sum5_stage1_3v6_re       : signed(bit_width_adder-1 downto 0) := (others => '0');
signal sum5_stage1_4v6_re       : signed(bit_width_adder-1 downto 0) := (others => '0');
signal sum5_stage1_5v6_re       : signed(bit_width_adder-1 downto 0) := (others => '0');
signal sum5_stage1_6v6_re       : signed(bit_width_adder-1 downto 0) := (others => '0');
--Imag
signal sum5_stage1_1v6_im       : signed(bit_width_adder-1 downto 0) := (others => '0');
signal sum5_stage1_2v6_im       : signed(bit_width_adder-1 downto 0) := (others => '0');
signal sum5_stage1_3v6_im       : signed(bit_width_adder-1 downto 0) := (others => '0');
signal sum5_stage1_4v6_im       : signed(bit_width_adder-1 downto 0) := (others => '0');
signal sum5_stage1_5v6_im       : signed(bit_width_adder-1 downto 0) := (others => '0');
signal sum5_stage1_6v6_im       : signed(bit_width_adder-1 downto 0) := (others => '0');

-- Stufe 3
-- Real
signal sum5_stage2_1v3_re     : signed(bit_width_adder downto 0) := (others => '0');
signal sum5_stage2_2v3_re     : signed(bit_width_adder downto 0) := (others => '0');
signal sum5_stage2_3v3_re     : signed(bit_width_adder downto 0) := (others => '0');
--Imag
signal sum5_stage2_1v3_im     : signed(bit_width_adder downto 0) := (others => '0');
signal sum5_stage2_2v3_im     : signed(bit_width_adder downto 0) := (others => '0');
signal sum5_stage2_3v3_im     : signed(bit_width_adder downto 0) := (others => '0');

-- Stufe 4
-- Real
signal sum5_stage3_1v1_re   : signed(bit_width_adder+1 downto 0) := (others => '0');
-- Imag
signal sum5_stage3_1v1_im   : signed(bit_width_adder+1 downto 0) := (others => '0');

--Stufe 5
-- Real
signal sum5_stage4_1v1_re     : signed(bit_width_adder+2 downto 0) := (others => '0');
-- Imag
signal sum5_stage4_1v1_im     : signed(bit_width_adder+2 downto 0) := (others => '0');

------------------------------ 7. Zeile-----------------------------------

-- Stufe 2
-- Real
signal sum6_stage1_1v4_re       : signed(bit_width_adder-1 downto 0) := (others => '0');
signal sum6_stage1_2v4_re       : signed(bit_width_adder-1 downto 0) := (others => '0');
signal sum6_stage1_3v4_re       : signed(bit_width_adder-1 downto 0) := (others => '0');
signal sum6_stage1_4v4_re       : signed(bit_width_adder-1 downto 0) := (others => '0');
-- Imag
signal sum6_stage1_1v4_im       : signed(bit_width_adder-1 downto 0) := (others => '0');
signal sum6_stage1_2v4_im       : signed(bit_width_adder-1 downto 0) := (others => '0');
signal sum6_stage1_3v4_im       : signed(bit_width_adder-1 downto 0) := (others => '0');
signal sum6_stage1_4v4_im       : signed(bit_width_adder-1 downto 0) := (others => '0');

-- Stufe 2
-- Real
signal sum6_stage2_1v2_re     : signed(bit_width_adder downto 0) := (others => '0');
signal sum6_stage2_2v2_re     : signed(bit_width_adder downto 0) := (others => '0');
-- Imag
signal sum6_stage2_1v2_im     : signed(bit_width_adder downto 0) := (others => '0');
signal sum6_stage2_2v2_im     : signed(bit_width_adder downto 0) := (others => '0');

-- Stufe 3
-- Real
signal sum6_stage3_1v1_re     : signed(bit_width_adder+1 downto 0) := (others => '0');
-- Imag
signal sum6_stage3_1v1_im     : signed(bit_width_adder+1 downto 0) := (others => '0');

------------------------------ 8. Zeile-----------------------------------
-- Stufe 1
signal constMult7_1_re        : signed(bit_width_extern-1 downto 0) := (others => '0');
signal constMult7_3_re        : signed(bit_width_extern-1 downto 0) := (others => '0');
signal constMult7_5_re        : signed(bit_width_extern-1 downto 0) := (others => '0');
signal constMult7_7_re        : signed(bit_width_extern-1 downto 0) := (others => '0');

signal constMult7_1_im        : signed(bit_width_extern-1 downto 0) := (others => '0');
signal constMult7_3_im        : signed(bit_width_extern-1 downto 0) := (others => '0');
signal constMult7_5_im        : signed(bit_width_extern-1 downto 0) := (others => '0');
signal constMult7_7_im        : signed(bit_width_extern-1 downto 0) := (others => '0');

-- Stufe 2
-- Real
signal sum7_stage1_1v6_re       : signed(bit_width_adder-1 downto 0) := (others => '0');
signal sum7_stage1_2v6_re       : signed(bit_width_adder-1 downto 0) := (others => '0');
signal sum7_stage1_3v6_re       : signed(bit_width_adder-1 downto 0) := (others => '0');
signal sum7_stage1_4v6_re       : signed(bit_width_adder-1 downto 0) := (others => '0');
signal sum7_stage1_5v6_re       : signed(bit_width_adder-1 downto 0) := (others => '0');
signal sum7_stage1_6v6_re       : signed(bit_width_adder-1 downto 0) := (others => '0');
--Imag
signal sum7_stage1_1v6_im       : signed(bit_width_adder-1 downto 0) := (others => '0');
signal sum7_stage1_2v6_im       : signed(bit_width_adder-1 downto 0) := (others => '0');
signal sum7_stage1_3v6_im       : signed(bit_width_adder-1 downto 0) := (others => '0');
signal sum7_stage1_4v6_im       : signed(bit_width_adder-1 downto 0) := (others => '0');
signal sum7_stage1_5v6_im       : signed(bit_width_adder-1 downto 0) := (others => '0');
signal sum7_stage1_6v6_im       : signed(bit_width_adder-1 downto 0) := (others => '0');

-- Stufe 3
-- Real
signal sum7_stage2_1v3_re     : signed(bit_width_adder downto 0) := (others => '0');
signal sum7_stage2_2v3_re     : signed(bit_width_adder downto 0) := (others => '0');
signal sum7_stage2_3v3_re     : signed(bit_width_adder downto 0) := (others => '0');
--Imag
signal sum7_stage2_1v3_im     : signed(bit_width_adder downto 0) := (others => '0');
signal sum7_stage2_2v3_im     : signed(bit_width_adder downto 0) := (others => '0');
signal sum7_stage2_3v3_im     : signed(bit_width_adder downto 0) := (others => '0');

-- Stufe 4
-- Real
signal sum7_stage3_1v1_re   : signed(bit_width_adder+1 downto 0) := (others => '0');
-- Imag
signal sum7_stage3_1v1_im   : signed(bit_width_adder+1 downto 0) := (others => '0');

--Stufe 5
-- Real
signal sum7_stage4_1v1_re     : signed(bit_width_adder+2 downto 0) := (others => '0');
-- Imag
signal sum7_stage4_1v1_im     : signed(bit_width_adder+2 downto 0) := (others => '0');

-- Ausgabe-Prozess

signal result_real_int : t_2d_array;
signal result_imag_int : t_2d_array;



signal my_constant_pos : signed(bit_width_extern-1 downto 0) := "000000000011";
signal my_constant_neg : signed(bit_width_extern-1 downto 0) := "111111111101";
    
signal multState, nextMultState : t_dft8_states;


begin


  FSM_TAKT: process(clk)
  begin
    if clk='1' and clk'event then
     
      if nReset='0' then
        multState <= idle;
        multState_out <= idle;
      elsif loaded = '0' then
        multState <= idle;
        multState_out <= idle;
      elsif loaded='1' and multState = idle then
        multState <= const_mult;
        multState_out <= const_mult;
      else
        multState <= nextMultState;
        multState_out <= nextMultState;
      end if;
    else
      multState <= multState;
    end if;
    
  end process;

  
  FSM_KOMB: process(multState)
  variable constMult_long   : t_1d_array64_long; -- t_1d_array127_long
  variable row : integer := 0;
  
  begin
    case multState is
          when const_mult => 
          
            for i in 0 to 7 loop
              constMult_long(i*8) := my_constant_pos*input_real(1)(i);
              constMult_long(i*8+1) := my_constant_pos*input_imag(1)(i);
              constMult_long(i*8+2) := my_constant_pos*input_real(3)(i);
              constMult_long(i*8+3) := my_constant_pos*input_imag(3)(i);
              constMult_long(i*8+4) := my_constant_pos*input_real(5)(i);
              constMult_long(i*8+5) := my_constant_pos*input_imag(5)(i);
              constMult_long(i*8+6) := my_constant_pos*input_real(7)(i);
              constMult_long(i*8+7) := my_constant_pos*input_imag(7)(i);
            end loop;
            
            for j in 0 to 63 loop
              constMult(j) <= constMult_long(j)(bit_width_extern-1 downto 0);
            end loop;
            
            nextMultState <= additions_stage1;
            

          when additions_stage1 =>
            -- 1. Zeile aus W -> nur Additionen
            -- Real
            sum0_stage1_1v4_re <= RESIZE(input_real(0)(row)) + RESIZE(input_real(1)(row));
            sum0_stage1_2v4_re <= RESIZE(input_real(2)(row)) + RESIZE(input_real(3)(row));
            sum0_stage1_3v4_re <= RESIZE(input_real(4)(row)) + RESIZE(input_real(5)(row));
            sum0_stage1_4v4_re <= RESIZE(input_real(6)(row)) + RESIZE(input_real(7)(row));
            -- Imag
            sum0_stage1_1v4_im <= RESIZE(input_imag(0)(row)) + RESIZE(input_imag(1)(row));
            sum0_stage1_2v4_im <= RESIZE(input_imag(2)(row)) + RESIZE(input_imag(3)(row));
            sum0_stage1_3v4_im <= RESIZE(input_imag(4)(row)) + RESIZE(input_imag(5)(row));
            sum0_stage1_4v4_im <= RESIZE(input_imag(6)(row)) + RESIZE(input_imag(7)(row));
            
            -- 2. Zeile aus W -> Zwischenergebnisse aufsummieren
            -- Real
            sum1_stage1_1v6_re <= RESIZE(input_real(0)(row)) - RESIZE(constMult(1));   --  my_const * input_imag(1)(0)
            sum1_stage1_2v6_re <= RESIZE(constMult(0))  - RESIZE(input_imag(2)(row));  --  my_const * input_real(1)(0)
            sum1_stage1_3v6_re <= RESIZE(constMult(5))  - RESIZE(constMult(2));       --  my_const * input_imag(5)(0), my_const * input_real(3)(0)
            sum1_stage1_4v6_re <= RESIZE(input_imag(6)(row)) - RESIZE(constMult(3));   --  my_const * input_imag(3)(0)
            sum1_stage1_5v6_re <= RESIZE(constMult(6))  - RESIZE(input_real(4)(row)); --  my_const * input_real(7)(0)
            sum1_stage1_6v6_re <= RESIZE(constMult(7))  - RESIZE(constMult(4));      --  my_const * input_imag(7)(0), my_const * input_real(7)(0)
            -- Imag
            sum1_stage1_1v6_im <= RESIZE(input_imag(0)(row)) - RESIZE(constMult(3));
            sum1_stage1_2v6_im <= RESIZE(constMult(0))  - RESIZE(input_imag(4)(row));
            sum1_stage1_3v6_im <= RESIZE(constMult(1))  - RESIZE(constMult(4));
            sum1_stage1_4v6_im <= RESIZE(input_real(2)(row)) - RESIZE(constMult(5));
            sum1_stage1_5v6_im <= RESIZE(constMult(2))  - RESIZE(input_real(6)(row));
            sum1_stage1_6v6_im <= RESIZE(constMult(7))  - RESIZE(constMult(6));
            
            
            -- 3. Zeile aus W
            -- Real
            sum2_stage1_1v4_re <= RESIZE(input_real(0)(row)) - RESIZE(input_real(2)(row));
            sum2_stage1_2v4_re <= RESIZE(input_imag(1)(row)) - RESIZE(input_imag(3)(row));
            sum2_stage1_3v4_re <= RESIZE(input_real(4)(row)) - RESIZE(input_real(6)(row));
            sum2_stage1_4v4_re <= RESIZE(input_imag(5)(row)) - RESIZE(input_imag(7)(row));
            --Imag
            sum2_stage1_1v4_im <= RESIZE(input_imag(0)(row)) - RESIZE(input_real(1)(row));
            sum2_stage1_2v4_im <= RESIZE(input_real(3)(row)) - RESIZE(input_imag(2)(row));
            sum2_stage1_3v4_im <= RESIZE(input_imag(4)(row)) - RESIZE(input_real(5)(row));
            sum2_stage1_4v4_im <= RESIZE(input_real(7)(row)) - RESIZE(input_imag(6)(row));
            
            -- 4. Zeile aus W
            -- Real
            sum3_stage1_1v6_re <= RESIZE(input_real(0)(row)) - RESIZE(constMult(0));
            sum3_stage1_2v6_re <= RESIZE(constMult(2)) - RESIZE(constMult(1));
            sum3_stage1_3v6_re <= RESIZE(constMult(4)) - RESIZE(input_imag(2)(row));
            sum3_stage1_4v6_re <= RESIZE(constMult(5)) - RESIZE(constMult(3));
            sum3_stage1_5v6_re <= RESIZE(input_imag(6)(row)) - RESIZE(input_real(4)(row));
            sum3_stage1_6v6_re <= RESIZE(constMult(7))  - RESIZE(constMult(6));
            -- Imag
            sum3_stage1_1v6_im <= RESIZE(input_imag(0)(row)) - RESIZE(constMult(1));
            sum3_stage1_2v6_im <= RESIZE(constMult(0))  - RESIZE(input_imag(4)(row));
            sum3_stage1_3v6_im <= RESIZE(input_real(2)(row))  - RESIZE(constMult(4));
            sum3_stage1_4v6_im <= RESIZE(constMult(2))  - RESIZE(input_real(6)(row));
            sum3_stage1_5v6_im <= RESIZE(constMult(3))  - RESIZE(constMult(6));
            sum3_stage1_6v6_im <= RESIZE(constMult(5)) - RESIZE(constMult(7));
            
            -- 5. Zeile
            -- Real
            sum4_stage1_1v4_re <= RESIZE(input_real(0)(row)) - RESIZE(input_real(1)(row));
            sum4_stage1_2v4_re <= RESIZE(input_real(2)(row)) - RESIZE(input_real(3)(row));
            sum4_stage1_3v4_re <= RESIZE(input_real(4)(row)) - RESIZE(input_real(5)(row));
            sum4_stage1_4v4_re <= RESIZE(input_real(6)(row)) - RESIZE(input_real(7)(row));
            -- Imag
            sum4_stage1_1v4_im <= RESIZE(input_imag(0)(row)) - RESIZE(input_imag(1)(row));
            sum4_stage1_2v4_im <= RESIZE(input_imag(2)(row)) - RESIZE(input_imag(3)(row));
            sum4_stage1_3v4_im <= RESIZE(input_imag(4)(row)) - RESIZE(input_imag(5)(row));
            sum4_stage1_4v4_im <= RESIZE(input_imag(6)(row)) - RESIZE(input_imag(7)(row));
            
            -- 6. Zeile
            -- Real
            sum5_stage1_1v6_re <= RESIZE(input_real(0)(row)) - RESIZE(constMult(0));
            sum5_stage1_2v6_re <= RESIZE(constMult(1))  - RESIZE(input_imag(2)(row));
            sum5_stage1_3v6_re <= RESIZE(constMult(2))  - RESIZE(input_real(4)(row));
            sum5_stage1_4v6_re <= RESIZE(constMult(3))  - RESIZE(constMult(5));
            sum5_stage1_5v6_re <= RESIZE(constMult(4))  - RESIZE(constMult(6));
            sum5_stage1_6v6_re <= RESIZE(input_imag(6)(row)) - RESIZE(constMult(7));
            -- Imag
            sum5_stage1_1v6_im <= RESIZE(input_imag(0)(row)) - RESIZE(constMult(0));
            sum5_stage1_2v6_im <= RESIZE(input_real(2)(row)) - RESIZE(constMult(1));
            sum5_stage1_3v6_im <= RESIZE(constMult(3))  - RESIZE(constMult(2));
            sum5_stage1_4v6_im <= RESIZE(constMult(4))  - RESIZE(input_imag(4)(row));
            sum5_stage1_5v6_im <= RESIZE(constMult(5))  - RESIZE(input_real(6)(row));
            sum5_stage1_6v6_im <= RESIZE(constMult(6))  - RESIZE(constMult(7));
            
            -- 7. Zeile
            -- Real
            sum6_stage1_1v4_re <= RESIZE(input_real(0)(row)) - RESIZE(input_imag(1)(row));
            sum6_stage1_2v4_re <= RESIZE(input_imag(3)(row)) - RESIZE(input_real(2)(row));
            sum6_stage1_3v4_re <= RESIZE(input_real(4)(row)) - RESIZE(input_imag(5)(row));
            sum6_stage1_4v4_re <= RESIZE(input_imag(7)(row)) - RESIZE(input_real(6)(row));
            -- Imag
            sum6_stage1_1v4_im <= RESIZE(input_imag(0)(row)) - RESIZE(input_imag(2)(row));
            sum6_stage1_2v4_im <= RESIZE(input_real(1)(row)) - RESIZE(input_real(3)(row));
            sum6_stage1_3v4_im <= RESIZE(input_imag(4)(row)) - RESIZE(input_real(6)(row));
            sum6_stage1_4v4_im <= RESIZE(input_real(5)(row)) - RESIZE(input_imag(7)(row));
            
            -- 8. Zeile
            -- Real
            sum7_stage1_1v6_re <= RESIZE(input_real(0)(row)) - RESIZE(constMult(2));
            sum7_stage1_2v6_re <= RESIZE(constMult(0))  - RESIZE(input_real(4)(row));
            sum7_stage1_3v6_re <= RESIZE(constMult(1))  - RESIZE(constMult(4));
            sum7_stage1_4v6_re <= RESIZE(input_imag(2)(row)) - RESIZE(constMult(5));
            sum7_stage1_5v6_re <= RESIZE(constMult(3))  - RESIZE(input_imag(6)(row));
            sum7_stage1_6v6_re <= RESIZE(constMult(6))  - RESIZE(constMult(7));
            -- Imag
            sum7_stage1_1v6_im <= RESIZE(input_imag(0)(row)) - RESIZE(constMult(0));
            sum7_stage1_2v6_im <= RESIZE(constMult(1))  - RESIZE(input_real(2)(row));
            sum7_stage1_3v6_im <= RESIZE(constMult(4))  - RESIZE(constMult(2));
            sum7_stage1_4v6_im <= RESIZE(input_real(6)(row)) - RESIZE(constMult(3));
            sum7_stage1_5v6_im <= RESIZE(constMult(6))  - RESIZE(input_imag(4)(row));
            sum7_stage1_6v6_im <= RESIZE(constMult(7))  - RESIZE(constMult(5));
            
            nextMultState <= additions_stage2;

          when additions_stage2 =>
            -- 1. Zeile aus W aufsummieren
            -- Real
            sum0_stage2_1v2_re <= RESIZE(sum0_stage1_1v4_re) + RESIZE(sum0_stage1_2v4_re);
            sum0_stage2_2v2_re <= RESIZE(sum0_stage1_3v4_re) + RESIZE(sum0_stage1_4v4_re);
            -- Imag
            sum0_stage2_1v2_im <= RESIZE(sum0_stage1_1v4_im) + RESIZE(sum0_stage1_2v4_im);
            sum0_stage2_2v2_im <= RESIZE(sum0_stage1_3v4_im) + RESIZE(sum0_stage1_4v4_im);
            
            -- 2. Zeile aus W
            -- Real
            sum1_stage2_1v3_re <= RESIZE(sum1_stage1_1v6_re) + RESIZE(sum1_stage1_2v6_re);
            sum1_stage2_2v3_re <= RESIZE(sum1_stage1_3v6_re) + RESIZE(sum1_stage1_4v6_re);
            sum1_stage2_3v3_re <= RESIZE(sum1_stage1_5v6_re) + RESIZE(sum1_stage1_6v6_re);
            -- Imag
            sum1_stage2_1v3_im <= RESIZE(sum1_stage1_1v6_im) + RESIZE(sum1_stage1_2v6_im);
            sum1_stage2_2v3_im <= RESIZE(sum1_stage1_3v6_im) + RESIZE(sum1_stage1_4v6_im);
            sum1_stage2_3v3_im <= RESIZE(sum1_stage1_5v6_im) + RESIZE(sum1_stage1_6v6_im);
            
            -- 3. Zeile aus W
            -- Real
            sum2_stage2_1v2_re <= RESIZE(sum2_stage1_1v4_re) + RESIZE(sum2_stage1_2v4_re);
            sum2_stage2_2v2_re <= RESIZE(sum2_stage1_3v4_re) + RESIZE(sum2_stage1_4v4_re);
            -- Imag
            sum2_stage2_1v2_im <= RESIZE(sum2_stage1_1v4_im) + RESIZE(sum2_stage1_2v4_im);
            sum2_stage2_2v2_im <= RESIZE(sum2_stage1_3v4_im) + RESIZE(sum2_stage1_4v4_im);
            
            -- 4. Zeile aus W
            -- Real
            sum3_stage2_1v3_re <= RESIZE(sum3_stage1_1v6_re) + RESIZE(sum3_stage1_2v6_re);
            sum3_stage2_2v3_re <= RESIZE(sum3_stage1_3v6_re) + RESIZE(sum3_stage1_4v6_re);
            sum3_stage2_3v3_re <= RESIZE(sum3_stage1_5v6_re) + RESIZE(sum3_stage1_6v6_re);
            -- Imag
            sum3_stage2_1v3_im <= RESIZE(sum3_stage1_1v6_im) + RESIZE(sum3_stage1_2v6_im);
            sum3_stage2_2v3_im <= RESIZE(sum3_stage1_3v6_im) + RESIZE(sum3_stage1_4v6_im);
            sum3_stage2_3v3_im <= RESIZE(sum3_stage1_5v6_im) + RESIZE(sum3_stage1_6v6_im);
            
            
            -- 5. Zeile
            -- Real
            sum4_stage2_1v2_re <= RESIZE(sum4_stage1_1v4_re) + RESIZE(sum4_stage1_2v4_re);
            sum4_stage2_2v2_re <= RESIZE(sum4_stage1_3v4_re) + RESIZE(sum4_stage1_4v4_re);
            -- Imag
            sum4_stage2_1v2_im <= RESIZE(sum4_stage1_1v4_im) + RESIZE(sum4_stage1_2v4_im);
            sum4_stage2_2v2_im <= RESIZE(sum4_stage1_3v4_im) + RESIZE(sum6_stage1_1v4_im);
            
            -- 6. Zeile
            -- Real
            sum5_stage2_1v3_re <= RESIZE(sum5_stage1_1v6_re) + RESIZE(sum5_stage1_2v6_re);
            sum5_stage2_2v3_re <= RESIZE(sum5_stage1_3v6_re) + RESIZE(sum5_stage1_4v6_re);
            sum5_stage2_3v3_re <= RESIZE(sum5_stage1_5v6_re) + RESIZE(sum5_stage1_6v6_re);
            -- Imag
            sum5_stage2_1v3_im <= RESIZE(sum5_stage1_1v6_im) + RESIZE(sum5_stage1_2v6_im);
            sum5_stage2_2v3_im <= RESIZE(sum5_stage1_3v6_im) + RESIZE(sum5_stage1_4v6_im);
            sum5_stage2_3v3_im <= RESIZE(sum5_stage1_5v6_im) + RESIZE(sum5_stage1_6v6_im);
            
            -- 7. Zeile
            -- Real
            sum6_stage2_1v2_re <= RESIZE(sum6_stage1_1v4_re) + RESIZE(sum6_stage1_2v4_re);
            sum6_stage2_2v2_re <= RESIZE(sum6_stage1_3v4_re) + RESIZE(sum6_stage1_4v4_re);
            -- Imag
            sum6_stage2_1v2_im <= RESIZE(sum6_stage1_1v4_im) + RESIZE(sum6_stage1_2v4_im);
            sum6_stage2_2v2_im <= RESIZE(sum6_stage1_3v4_im) + RESIZE(sum6_stage1_4v4_im);
            
            -- 8. Zeile
            -- Real
            sum7_stage2_1v3_re <= RESIZE(sum7_stage1_1v6_re) + RESIZE(sum7_stage1_2v6_re);
            sum7_stage2_2v3_re <= RESIZE(sum7_stage1_3v6_re) + RESIZE(sum7_stage1_4v6_re);
            sum7_stage2_3v3_re <= RESIZE(sum7_stage1_5v6_re) + RESIZE(sum7_stage1_6v6_re);
            -- Imag
            sum7_stage2_1v3_im <= RESIZE(sum7_stage1_1v6_im) + RESIZE(sum7_stage1_3v6_im);
            sum7_stage2_2v3_im <= RESIZE(sum7_stage1_2v6_im) + RESIZE(sum7_stage1_5v6_im);
            sum7_stage2_3v3_im <= RESIZE(sum7_stage1_4v6_im) + RESIZE(sum7_stage1_6v6_im);
            
            nextMultState <= additions_stage3;

          when additions_stage3 =>
            -- 1. Zeile aus W
            -- Real
            sum0_stage3_1v1_re <= RESIZE(sum0_stage2_1v2_re) + RESIZE(sum0_stage2_2v2_re);
            -- Imag
            sum0_stage3_1v1_im <= RESIZE(sum0_stage2_1v2_im) + RESIZE(sum0_stage2_2v2_im);
            
            -- 2. Zeile aus W
            -- Real
            sum1_stage3_1v1_re <= RESIZE(sum1_stage2_1v3_re) + RESIZE(sum1_stage2_2v3_re);
            -- Imag
            sum1_stage3_1v1_im <= RESIZE(sum1_stage2_1v3_im) + RESIZE(sum1_stage2_2v3_im);
            
            -- 3. Zeile aus W
            -- Real
            sum2_stage3_1v1_re <= RESIZE(sum2_stage2_1v2_re) + RESIZE(sum2_stage2_2v2_re);
            -- Imag
            sum2_stage3_1v1_im <= RESIZE(sum2_stage2_1v2_im) + RESIZE(sum2_stage2_2v2_im);
            
            -- 4. Zeile aus W
            -- Real
            sum3_stage3_1v1_re <= RESIZE(sum3_stage2_1v3_re) + RESIZE(sum3_stage2_2v3_re);
            -- Imag
            sum3_stage3_1v1_im <= RESIZE(sum3_stage2_1v3_im) + RESIZE(sum3_stage2_2v3_im);
            
            -- 5. Zeile
            -- Real
            sum4_stage3_1v1_re <= RESIZE(sum4_stage2_1v2_re) + RESIZE(sum4_stage2_2v2_re);
            -- Imag
            sum4_stage3_1v1_im <= RESIZE(sum4_stage2_1v2_im) + RESIZE(sum4_stage2_2v2_im);
            
            -- 6. Zeile
            -- Real
            sum5_stage3_1v1_re <= RESIZE(sum5_stage2_1v3_re) + RESIZE(sum5_stage2_2v3_re);
            -- Imag
            sum5_stage3_1v1_im <= RESIZE(sum5_stage2_1v3_im) + RESIZE(sum5_stage2_2v3_im);
            
            -- 7. Zeile
            -- Real
            sum6_stage3_1v1_re <= RESIZE(sum6_stage2_1v2_re) + RESIZE(sum6_stage2_2v2_re);
            -- Imag
            sum6_stage3_1v1_im <= RESIZE(sum6_stage2_1v2_im) + RESIZE(sum6_stage2_2v2_im);
            
            -- 8. Zeile
            -- Real
            sum7_stage3_1v1_re <= RESIZE(sum7_stage2_1v3_re) + RESIZE(sum7_stage2_2v3_re);
            -- Imag
            sum7_stage3_1v1_im <= RESIZE(sum7_stage2_1v3_im) + RESIZE(sum7_stage2_2v3_im);

            nextMultState <= additions_stage4;

          when additions_stage4 =>
            -- Hier sind noch sum1, 3, 5, 7 dabei. Also die Konstantenmultiplikationen.
          
            -- 2. Zeile
            -- Real
            sum1_stage4_1v1_re <= RESIZE(sum1_stage3_1v1_re) + RESIZE(sum1_stage2_3v3_re);
            -- Imag
            sum1_stage4_1v1_im <= RESIZE(sum1_stage3_1v1_im) + RESIZE(sum1_stage2_3v3_im);
            
            -- 4. Zeile
            -- Real
            sum3_stage4_1v1_re <= RESIZE(sum3_stage3_1v1_re) + RESIZE(sum3_stage2_3v3_re);
            -- Imag
            sum3_stage4_1v1_im <= RESIZE(sum3_stage3_1v1_im) + RESIZE(sum3_stage2_3v3_im);
            
            -- 6. Zeile
            -- Real
            sum5_stage4_1v1_re <= RESIZE(sum5_stage3_1v1_re) + RESIZE(sum5_stage2_3v3_re);
            -- Imag
            sum5_stage4_1v1_im <= RESIZE(sum5_stage3_1v1_im) + RESIZE(sum5_stage2_3v3_im);
            
            -- 8. Zeile
            -- Real
            sum7_stage4_1v1_re <= RESIZE(sum7_stage3_1v1_re) + RESIZE(sum7_stage2_3v3_re);
            -- Imag
            sum7_stage4_1v1_im <= RESIZE(sum7_stage3_1v1_im) + RESIZE(sum7_stage2_3v3_im);
            
            
            nextMultState <= const_mult;
            
          when others => nextMultState <= const_mult;
        end case;
        
    end process;
    
    
    set_results : process(clk)
      begin
        if clk='1' and clk'event then
        
          for i in 0 to 7 loop
            for j in 0 to 7 loop
              result_real_int(i)(j) <= result_imag_int(i)(j);
              result_imag_int(i)(j) <= result_imag_int(i)(i);
            end loop;
          end loop;
          
          
          constMult1_1_re_out <= constMult(0);
          constMult1_3_re_out <= constMult(2);
          constMult1_5_re_out <= constMult(4);
          constMult1_7_re_out <= constMult(6);
          
          constMult1_1_im_out <= constMult(1);
          constMult1_3_im_out <= constMult(3);
          constMult1_5_im_out <= constMult(5);
          constMult1_7_im_out <= constMult(7);
          
          sum1_stage1_1v6_re_out <= sum1_stage1_1v6_re;
          sum1_stage1_2v6_re_out <= sum1_stage1_2v6_re;
          sum1_stage1_3v6_re_out <= sum1_stage1_3v6_re;
          sum1_stage1_4v6_re_out <= sum1_stage1_4v6_re;
          sum1_stage1_5v6_re_out <= sum1_stage1_5v6_re;
          sum1_stage1_6v6_re_out <= sum1_stage1_6v6_re;
          
        
          
          if multState = additions_stage4 then
            result_real(0)(0) <= sum0_stage3_1v1_re(bit_width_extern-1 downto 0);
            result_real_int(0)(0) <= sum0_stage3_1v1_re(bit_width_extern-1 downto 0);
            result_real(0)(1) <= sum1_stage4_1v1_re(bit_width_extern-1 downto 0);
            result_real_int(0)(1) <= sum1_stage4_1v1_re(bit_width_extern-1 downto 0);
            result_real(0)(2) <= sum2_stage3_1v1_re(bit_width_extern-1 downto 0);
            result_real_int(0)(2) <= sum2_stage3_1v1_re(bit_width_extern-1 downto 0);
            result_real(0)(3) <= sum3_stage4_1v1_re(bit_width_extern-1 downto 0);
            result_real_int(0)(3) <= sum3_stage4_1v1_re(bit_width_extern-1 downto 0);
            result_real(0)(4) <= sum4_stage3_1v1_re(bit_width_extern-1 downto 0);
            result_real_int(0)(4) <= sum4_stage3_1v1_re(bit_width_extern-1 downto 0);
            result_real(0)(5) <= sum5_stage4_1v1_re(bit_width_extern-1 downto 0);
            result_real_int(0)(5) <= sum5_stage4_1v1_re(bit_width_extern-1 downto 0);
            result_real(0)(6) <= sum6_stage3_1v1_re(bit_width_extern-1 downto 0);
            result_real_int(0)(6) <= sum6_stage3_1v1_re(bit_width_extern-1 downto 0);
            result_real(0)(7) <= sum7_stage4_1v1_re(bit_width_extern-1 downto 0);
            result_real_int(0)(7) <= sum7_stage4_1v1_re(bit_width_extern-1 downto 0);
        
        
            result_imag(0)(0) <= sum0_stage3_1v1_im(bit_width_extern-1 downto 0);
            result_imag_int(0)(0) <= sum0_stage3_1v1_im(bit_width_extern-1 downto 0);
            result_imag(0)(1) <= sum1_stage4_1v1_im(bit_width_extern-1 downto 0);
            result_imag_int(0)(1) <= sum1_stage4_1v1_im(bit_width_extern-1 downto 0);
            result_imag(0)(2) <= sum2_stage3_1v1_im(bit_width_extern-1 downto 0);
            result_imag_int(0)(2) <= sum2_stage3_1v1_im(bit_width_extern-1 downto 0);
            result_imag(0)(3) <= sum3_stage4_1v1_im(bit_width_extern-1 downto 0);
            result_imag_int(0)(3) <= sum3_stage4_1v1_im(bit_width_extern-1 downto 0);
            result_imag(0)(4) <= sum4_stage3_1v1_im(bit_width_extern-1 downto 0);
            result_imag_int(0)(4) <= sum4_stage3_1v1_im(bit_width_extern-1 downto 0);
            result_imag(0)(5) <= sum5_stage4_1v1_im(bit_width_extern-1 downto 0);
            result_imag_int(0)(5) <= sum5_stage4_1v1_im(bit_width_extern-1 downto 0);
            result_imag(0)(6) <= sum6_stage3_1v1_im(bit_width_extern-1 downto 0);
            result_imag_int(0)(6) <= sum6_stage3_1v1_im(bit_width_extern-1 downto 0);
            result_imag(0)(7) <= sum7_stage4_1v1_im(bit_width_extern-1 downto 0);
            result_imag_int(0)(7) <= sum7_stage4_1v1_im(bit_width_extern-1 downto 0);
          end if;
        end if;
        end process;
        
        

    
end arch;
            
            
