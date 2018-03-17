
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
     result_ready  : out bit;
     W_row_out     : out unsigned(2 downto 0)
    );
end dft8optimiert;

architecture arch of dft8optimiert is

------------------------------ 1. Zeile-----------------------------------
-- Stufe 1
-- Real
signal sum0_stage1_1v4_re             : t_1d_array8_13bit;
signal sum0_stage1_2v4_re             : t_1d_array8_13bit;
signal sum0_stage1_3v4_re             : t_1d_array8_13bit;
signal sum0_stage1_4v4_re             : t_1d_array8_13bit;
-- Imag
signal sum0_stage1_1v4_im             : t_1d_array8_13bit;
signal sum0_stage1_2v4_im             : t_1d_array8_13bit;
signal sum0_stage1_3v4_im             : t_1d_array8_13bit;
signal sum0_stage1_4v4_im             : t_1d_array8_13bit;

-- Stufe 2
--Real
signal sum0_stage2_1v2_re         : t_1d_array8_14bit;
signal sum0_stage2_2v2_re         : t_1d_array8_14bit;
--Imag
signal sum0_stage2_1v2_im         : t_1d_array8_14bit;
signal sum0_stage2_2v2_im         : t_1d_array8_14bit;

-- Stufe 3
--Real
signal sum0_stage3_1v1_re : t_1d_array8_15bit;
--Imag
signal sum0_stage3_1v1_im : t_1d_array8_15bit;


------------------------------ 2. Zeile-----------------------------------
-- Stufe 2
-- Real
signal sum1_stage1_1v6_re          : t_1d_array8_13bit;
signal sum1_stage1_2v6_re          : t_1d_array8_13bit;
signal sum1_stage1_3v6_re          : t_1d_array8_13bit;
signal sum1_stage1_4v6_re          : t_1d_array8_13bit;
signal sum1_stage1_5v6_re          : t_1d_array8_13bit;
signal sum1_stage1_6v6_re          : t_1d_array8_13bit;

--Imag
signal sum1_stage1_1v6_im          : t_1d_array8_13bit;
signal sum1_stage1_2v6_im          : t_1d_array8_13bit;
signal sum1_stage1_3v6_im          : t_1d_array8_13bit;
signal sum1_stage1_4v6_im          : t_1d_array8_13bit;
signal sum1_stage1_5v6_im          : t_1d_array8_13bit;
signal sum1_stage1_6v6_im          : t_1d_array8_13bit;


-- Stufe 3
-- Real
signal sum1_stage2_1v3_re      : t_1d_array8_14bit;
signal sum1_stage2_2v3_re      : t_1d_array8_14bit;
signal sum1_stage2_3v3_re      : t_1d_array8_14bit;
--Imag
signal sum1_stage2_1v3_im      : t_1d_array8_14bit;
signal sum1_stage2_2v3_im      : t_1d_array8_14bit;
signal sum1_stage2_3v3_im      : t_1d_array8_14bit;

-- Stufe 4
-- Real
signal sum1_stage3_1v1_re   : t_1d_array8_15bit;
-- Imag
signal sum1_stage3_1v1_im   : t_1d_array8_15bit;

--Stufe 5
-- Real
signal sum1_stage4_1v1_re     : t_1d_array8_15bit;
-- Imag
signal sum1_stage4_1v1_im     : t_1d_array8_15bit;


------------------------------ 3. Zeile-----------------------------------

-- Stufe 2
-- Real
signal sum2_stage1_1v4_re             : t_1d_array8_13bit;
signal sum2_stage1_2v4_re             : t_1d_array8_13bit;
signal sum2_stage1_3v4_re             : t_1d_array8_13bit;
signal sum2_stage1_4v4_re             : t_1d_array8_13bit;
-- Imag
signal sum2_stage1_1v4_im             : t_1d_array8_13bit;
signal sum2_stage1_2v4_im             : t_1d_array8_13bit;
signal sum2_stage1_3v4_im             : t_1d_array8_13bit;
signal sum2_stage1_4v4_im             : t_1d_array8_13bit;

-- Stufe 2
-- Real
signal sum2_stage2_1v2_re         : t_1d_array8_14bit;
signal sum2_stage2_2v2_re         : t_1d_array8_14bit;
-- Imag
signal sum2_stage2_1v2_im         : t_1d_array8_14bit;
signal sum2_stage2_2v2_im         : t_1d_array8_14bit;

-- Stufe 3
-- Real
signal sum2_stage3_1v1_re : t_1d_array8_15bit;
-- Imag
signal sum2_stage3_1v1_im : t_1d_array8_15bit;

------------------------------ 4. Zeile-----------------------------------

-- Stufe 2
-- Real
signal sum3_stage1_1v6_re          : t_1d_array8_13bit;
signal sum3_stage1_2v6_re          : t_1d_array8_13bit;
signal sum3_stage1_3v6_re          : t_1d_array8_13bit;
signal sum3_stage1_4v6_re          : t_1d_array8_13bit;
signal sum3_stage1_5v6_re          : t_1d_array8_13bit;
signal sum3_stage1_6v6_re          : t_1d_array8_13bit;
--Imag
signal sum3_stage1_1v6_im          : t_1d_array8_13bit;
signal sum3_stage1_2v6_im          : t_1d_array8_13bit;
signal sum3_stage1_3v6_im          : t_1d_array8_13bit;
signal sum3_stage1_4v6_im          : t_1d_array8_13bit;
signal sum3_stage1_5v6_im          : t_1d_array8_13bit;
signal sum3_stage1_6v6_im          : t_1d_array8_13bit;

-- Stufe 3
-- Real
signal sum3_stage2_1v3_re     : t_1d_array8_14bit;
signal sum3_stage2_2v3_re     : t_1d_array8_14bit;
signal sum3_stage2_3v3_re     : t_1d_array8_14bit;
--Imag
signal sum3_stage2_1v3_im     : t_1d_array8_14bit;
signal sum3_stage2_2v3_im     : t_1d_array8_14bit;
signal sum3_stage2_3v3_im     : t_1d_array8_14bit;

-- Stufe 4
-- Real
signal sum3_stage3_1v1_re         : t_1d_array8_15bit;
-- Imag
signal sum3_stage3_1v1_im         : t_1d_array8_15bit;

--Stufe 5
-- Imag
signal sum3_stage4_1v1_re : t_1d_array8_15bit;
-- Imag
signal sum3_stage4_1v1_im : t_1d_array8_15bit;

------------------------------ 5. Zeile-----------------------------------
-- Stufe 1
-- Real
signal sum4_stage1_1v4_re       : t_1d_array8_13bit;
signal sum4_stage1_2v4_re       : t_1d_array8_13bit;
signal sum4_stage1_3v4_re       : t_1d_array8_13bit;
signal sum4_stage1_4v4_re       : t_1d_array8_13bit;
-- Imag
signal sum4_stage1_1v4_im       : t_1d_array8_13bit;
signal sum4_stage1_2v4_im       : t_1d_array8_13bit;
signal sum4_stage1_3v4_im       : t_1d_array8_13bit;
signal sum4_stage1_4v4_im       : t_1d_array8_13bit;

-- Stufe 2
-- Real
signal sum4_stage2_1v2_re     : t_1d_array8_14bit;
signal sum4_stage2_2v2_re     : t_1d_array8_14bit;
-- Imag
signal sum4_stage2_1v2_im     : t_1d_array8_14bit;
signal sum4_stage2_2v2_im     : t_1d_array8_14bit;

-- Stufe 3
-- Real
signal sum4_stage3_1v1_re : t_1d_array8_15bit;
-- Imag
signal sum4_stage3_1v1_im : t_1d_array8_15bit;


------------------------------ 6. Zeile-----------------------------------
-- Stufe 2
-- Real
signal sum5_stage1_1v6_re       : t_1d_array8_13bit;
signal sum5_stage1_2v6_re       : t_1d_array8_13bit;
signal sum5_stage1_3v6_re       : t_1d_array8_13bit;
signal sum5_stage1_4v6_re       : t_1d_array8_13bit;
signal sum5_stage1_5v6_re       : t_1d_array8_13bit;
signal sum5_stage1_6v6_re       : t_1d_array8_13bit;
--Imag
signal sum5_stage1_1v6_im       : t_1d_array8_13bit;
signal sum5_stage1_2v6_im       : t_1d_array8_13bit;
signal sum5_stage1_3v6_im       : t_1d_array8_13bit;
signal sum5_stage1_4v6_im       : t_1d_array8_13bit;
signal sum5_stage1_5v6_im       : t_1d_array8_13bit;
signal sum5_stage1_6v6_im       : t_1d_array8_13bit;

-- Stufe 3
-- Real
signal sum5_stage2_1v3_re     : t_1d_array8_14bit;
signal sum5_stage2_2v3_re     : t_1d_array8_14bit;
signal sum5_stage2_3v3_re     : t_1d_array8_14bit;
--Imag
signal sum5_stage2_1v3_im     : t_1d_array8_14bit;
signal sum5_stage2_2v3_im     : t_1d_array8_14bit;
signal sum5_stage2_3v3_im     : t_1d_array8_14bit;

-- Stufe 4
-- Real
signal sum5_stage3_1v1_re   : t_1d_array8_15bit;
-- Imag
signal sum5_stage3_1v1_im   : t_1d_array8_15bit;

--Stufe 5
-- Real
signal sum5_stage4_1v1_re     : t_1d_array8_15bit;
-- Imag
signal sum5_stage4_1v1_im     : t_1d_array8_15bit;

------------------------------ 7. Zeile-----------------------------------

-- Stufe 2
-- Real
signal sum6_stage1_1v4_re       : t_1d_array8_13bit;
signal sum6_stage1_2v4_re       : t_1d_array8_13bit;
signal sum6_stage1_3v4_re       : t_1d_array8_13bit;
signal sum6_stage1_4v4_re       : t_1d_array8_13bit;
-- Imag
signal sum6_stage1_1v4_im       : t_1d_array8_13bit;
signal sum6_stage1_2v4_im       : t_1d_array8_13bit;
signal sum6_stage1_3v4_im       : t_1d_array8_13bit;
signal sum6_stage1_4v4_im       : t_1d_array8_13bit;

-- Stufe 2
-- Real
signal sum6_stage2_1v2_re     : t_1d_array8_14bit;
signal sum6_stage2_2v2_re     : t_1d_array8_14bit;
-- Imag
signal sum6_stage2_1v2_im     : t_1d_array8_14bit;
signal sum6_stage2_2v2_im     : t_1d_array8_14bit;

-- Stufe 3
-- Real
signal sum6_stage3_1v1_re     : t_1d_array8_15bit;
-- Imag
signal sum6_stage3_1v1_im     : t_1d_array8_15bit;

------------------------------ 8. Zeile-----------------------------------

-- Stufe 2
-- Real
signal sum7_stage1_1v6_re       : t_1d_array8_13bit;
signal sum7_stage1_2v6_re       : t_1d_array8_13bit;
signal sum7_stage1_3v6_re       : t_1d_array8_13bit;
signal sum7_stage1_4v6_re       : t_1d_array8_13bit;
signal sum7_stage1_5v6_re       : t_1d_array8_13bit;
signal sum7_stage1_6v6_re       : t_1d_array8_13bit;
--Imag
signal sum7_stage1_1v6_im       : t_1d_array8_13bit;
signal sum7_stage1_2v6_im       : t_1d_array8_13bit;
signal sum7_stage1_3v6_im       : t_1d_array8_13bit;
signal sum7_stage1_4v6_im       : t_1d_array8_13bit;
signal sum7_stage1_5v6_im       : t_1d_array8_13bit;
signal sum7_stage1_6v6_im       : t_1d_array8_13bit;

-- Stufe 3
-- Real
signal sum7_stage2_1v3_re     : t_1d_array8_14bit;
signal sum7_stage2_2v3_re     : t_1d_array8_14bit;
signal sum7_stage2_3v3_re     : t_1d_array8_14bit;
--Imag
signal sum7_stage2_1v3_im     : t_1d_array8_14bit;
signal sum7_stage2_2v3_im     : t_1d_array8_14bit;
signal sum7_stage2_3v3_im     : t_1d_array8_14bit;

-- Stufe 4
-- Real
signal sum7_stage3_1v1_re   : t_1d_array8_15bit;
-- Imag
signal sum7_stage3_1v1_im   : t_1d_array8_15bit;

--Stufe 5
-- Real
signal sum7_stage4_1v1_re     : t_1d_array8_15bit;
-- Imag
signal sum7_stage4_1v1_im     : t_1d_array8_15bit;

-- Ausgabe-Prozess

signal result_real_int : t_2d_array;
signal result_imag_int : t_2d_array;



--signal my_constant_pos : signed(bit_width_extern-1 downto 0) := "000000000011";
signal my_constant_pos : signed(bit_width_adder+1 downto 0) := "000000000000011";
--signal my_constant_pos : signed(bit_width_adder+1 downto 0) := "001011010100000";

    
signal multState, nextMultState : t_dft8_states;

signal mult_re : t_2d_array4x8_14bit;
signal mult_im : t_2d_array4x8_14bit;

signal W_row : unsigned(2 downto 0) := "000";


begin


  FSM_TAKT: process(clk)
  begin
    if clk='1' and clk'event then
      W_row_out <= W_row;
      if nReset='0' then
        multState <= idle;
        multState_out <= idle;
      elsif loaded = '0' then
        multState <= idle;
        multState_out <= idle;
      elsif loaded='1' and multState = idle then
        multState <= additions_stage1;
        multState_out <= additions_stage1;
      else
        multState <= nextMultState;
        multState_out <= nextMultState;
      end if;
    else
      multState <= multState;
    end if;
    
  end process;

  
  FSM_KOMB: process(multState)
    
    variable mult_re_temp : t_2d_array4x8_30bit;
    variable mult_im_temp : t_2d_array4x8_30bit;
    
    
  
  begin
    case multState is

      when additions_stage1 =>
        -- 1. Zeile aus W -> nur Additionen
            -- Real
        case W_row is
          when "000" =>
            for col in 0 to 7 loop
            sum0_stage1_1v4_re(col) <= RESIZE(input_real(0)(col)) + RESIZE(input_real(1)(col));
            sum0_stage1_2v4_re(col) <= RESIZE(input_real(2)(col)) + RESIZE(input_real(3)(col));
            sum0_stage1_3v4_re(col) <= RESIZE(input_real(4)(col)) + RESIZE(input_real(5)(col));
            sum0_stage1_4v4_re(col) <= RESIZE(input_real(6)(col)) + RESIZE(input_real(7)(col));
            -- Imag
            sum0_stage1_1v4_im(col) <= RESIZE(input_imag(0)(col)) + RESIZE(input_imag(1)(col));
            sum0_stage1_2v4_im(col) <= RESIZE(input_imag(2)(col)) + RESIZE(input_imag(3)(col));
            sum0_stage1_3v4_im(col) <= RESIZE(input_imag(4)(col)) + RESIZE(input_imag(5)(col));
            sum0_stage1_4v4_im(col) <= RESIZE(input_imag(6)(col)) + RESIZE(input_imag(7)(col));
            end loop;
            
            -- 2. Zeile aus W
            -- Real
          when "001" =>
            for col in 0 to 7 loop
            sum1_stage1_1v6_re(col) <= RESIZE(input_real(0)(col)) - RESIZE(input_imag(2)(col));
            sum1_stage1_2v6_re(col) <= RESIZE(input_imag(6)(col)) - RESIZE(input_real(4)(col));
            -- MultPart
            sum1_stage1_3v6_re(col) <= RESIZE(input_real(1)(col)) - RESIZE(input_imag(1)(col));
            sum1_stage1_4v6_re(col) <= RESIZE(input_imag(5)(col)) - RESIZE(input_real(3)(col));
            sum1_stage1_5v6_re(col) <= RESIZE(input_real(7)(col)) - RESIZE(input_imag(3)(col));
            sum1_stage1_6v6_re(col) <= RESIZE(input_imag(7)(col)) - RESIZE(input_real(5)(col));
            
            
            -- Imag
            sum1_stage1_1v6_im(col) <= RESIZE(input_imag(0)(col)) - RESIZE(input_imag(4)(col));
            sum1_stage1_2v6_im(col) <= RESIZE(input_real(2)(col)) - RESIZE(input_real(6)(col));
            -- MultPart
            sum1_stage1_3v6_im(col) <= RESIZE(input_real(1)(col)) - RESIZE(input_imag(3)(col));
            sum1_stage1_4v6_im(col) <= RESIZE(input_imag(1)(col)) - RESIZE(input_real(5)(col));
            sum1_stage1_5v6_im(col) <= RESIZE(input_real(3)(col)) - RESIZE(input_imag(5)(col));
            sum1_stage1_6v6_im(col) <= RESIZE(input_imag(7)(col)) - RESIZE(input_real(7)(col));
            end loop;
            
            -- 3. Zeile aus W
            -- Real
          when "010" =>
            for col in 0 to 7 loop
            sum2_stage1_1v4_re(col) <= RESIZE(input_real(0)(col)) - RESIZE(input_imag(1)(col));
            sum2_stage1_2v4_re(col) <= RESIZE(input_imag(3)(col)) - RESIZE(input_real(2)(col));
            sum2_stage1_3v4_re(col) <= RESIZE(input_real(4)(col)) - RESIZE(input_imag(5)(col));
            sum2_stage1_4v4_re(col) <= RESIZE(input_imag(7)(col)) - RESIZE(input_real(6)(col));
            --Imag
            sum2_stage1_1v4_im(col) <= RESIZE(input_imag(0)(col)) - RESIZE(input_imag(2)(col));
            sum2_stage1_2v4_im(col) <= RESIZE(input_real(1)(col)) - RESIZE(input_real(3)(col));
            sum2_stage1_3v4_im(col) <= RESIZE(input_imag(4)(col)) - RESIZE(input_imag(6)(col));
            sum2_stage1_4v4_im(col) <= RESIZE(input_real(5)(col)) - RESIZE(input_real(7)(col));
            end loop;
            
            -- 4. Zeile aus W
            -- Real
          when "011" =>
            for col in 0 to 7 loop
            sum3_stage1_1v6_re(col) <= RESIZE(input_real(0)(col)) - RESIZE(input_real(4)(col));
            sum3_stage1_2v6_re(col) <= RESIZE(input_imag(2)(col)) - RESIZE(input_imag(6)(col));
            --MultPart
            sum3_stage1_3v6_re(col) <= RESIZE(input_real(3)(col)) - RESIZE(input_real(1)(col));
            sum3_stage1_4v6_re(col) <= RESIZE(input_real(5)(col)) - RESIZE(input_imag(1)(col));
            sum3_stage1_5v6_re(col) <= RESIZE(input_imag(5)(col)) - RESIZE(input_imag(3)(col));
            sum3_stage1_6v6_re(col) <= RESIZE(input_imag(7)(col)) - RESIZE(input_real(7)(col));
            
            -- Imag
            sum3_stage1_1v6_im(col) <= RESIZE(input_imag(0)(col)) - RESIZE(input_real(2)(col));
            sum3_stage1_2v6_im(col) <= RESIZE(input_real(6)(col)) - RESIZE(input_imag(4)(col));
            --MultPart
            sum3_stage1_3v6_im(col) <= RESIZE(input_real(1)(col)) - RESIZE(input_imag(1)(col));
            sum3_stage1_4v6_im(col) <= RESIZE(input_imag(3)(col)) - RESIZE(input_real(5)(col));
            sum3_stage1_5v6_im(col) <= RESIZE(input_real(3)(col)) - RESIZE(input_real(7)(col));
            sum3_stage1_6v6_im(col) <= RESIZE(input_imag(5)(col)) - RESIZE(input_imag(7)(col));
            end loop;
           
            -- 5. Zeile
            -- Real
          when "100" =>
            for col in 0 to 7 loop
            sum4_stage1_1v4_re(col) <= RESIZE(input_real(0)(col)) - RESIZE(input_real(1)(col));
            sum4_stage1_2v4_re(col) <= RESIZE(input_real(2)(col)) - RESIZE(input_real(3)(col));
            sum4_stage1_3v4_re(col) <= RESIZE(input_real(4)(col)) - RESIZE(input_real(5)(col));
            sum4_stage1_4v4_re(col) <= RESIZE(input_real(6)(col)) - RESIZE(input_real(7)(col));
            -- Imag
            sum4_stage1_1v4_im(col) <= RESIZE(input_imag(0)(col)) - RESIZE(input_imag(1)(col));
            sum4_stage1_2v4_im(col) <= RESIZE(input_imag(2)(col)) - RESIZE(input_imag(3)(col));
            sum4_stage1_3v4_im(col) <= RESIZE(input_imag(4)(col)) - RESIZE(input_imag(5)(col));
            sum4_stage1_4v4_im(col) <= RESIZE(input_imag(6)(col)) - RESIZE(input_imag(7)(col));
            end loop;
            
            -- 6. Zeile
            -- Real
          when "101" =>
            for col in 0 to 7 loop
            sum5_stage1_1v6_re(col) <= RESIZE(input_real(0)(col)) - RESIZE(input_imag(2)(col));
            sum5_stage1_2v6_re(col) <= RESIZE(input_imag(6)(col)) - RESIZE(input_real(4)(col));
            --MultPart
            sum5_stage1_3v6_re(col) <= RESIZE(input_imag(1)(col)) - RESIZE(input_real(1)(col));
            sum5_stage1_4v6_re(col) <= RESIZE(input_real(3)(col)) - RESIZE(input_imag(5)(col));
            sum5_stage1_5v6_re(col) <= RESIZE(input_imag(3)(col)) - RESIZE(input_real(7)(col));
            sum5_stage1_6v6_re(col) <= RESIZE(input_real(5)(col)) - RESIZE(input_imag(7)(col));
            
            -- Imag
            sum5_stage1_1v6_im(col) <= RESIZE(input_imag(0)(col)) - RESIZE(input_imag(4)(col));
            sum5_stage1_2v6_im(col) <= RESIZE(input_real(2)(col)) - RESIZE(input_real(6)(col));
            --MultPart
            sum5_stage1_3v6_im(col) <= RESIZE(input_imag(3)(col)) - RESIZE(input_real(1)(col));
            sum5_stage1_4v6_im(col) <= RESIZE(input_real(5)(col)) - RESIZE(input_imag(1)(col));
            sum5_stage1_5v6_im(col) <= RESIZE(input_imag(5)(col)) - RESIZE(input_real(3)(col));
            sum5_stage1_6v6_im(col) <= RESIZE(input_real(7)(col)) - RESIZE(input_imag(7)(col));
            end loop;
            
            -- 7. Zeile
            -- Real
          when "110" =>
            for col in 0 to 7 loop
            sum6_stage1_1v4_re(col) <= RESIZE(input_real(0)(col)) - RESIZE(input_real(2)(col));
            sum6_stage1_2v4_re(col) <= RESIZE(input_imag(1)(col)) - RESIZE(input_imag(3)(col));
            sum6_stage1_3v4_re(col) <= RESIZE(input_real(4)(col)) - RESIZE(input_real(6)(col));
            sum6_stage1_4v4_re(col) <= RESIZE(input_imag(5)(col)) - RESIZE(input_imag(7)(col));
            -- Imag
            sum6_stage1_1v4_im(col) <= RESIZE(input_imag(0)(col)) - RESIZE(input_real(1)(col));
            sum6_stage1_2v4_im(col) <= RESIZE(input_real(3)(col)) - RESIZE(input_imag(2)(col));
            sum6_stage1_3v4_im(col) <= RESIZE(input_imag(4)(col)) - RESIZE(input_real(5)(col));
            sum6_stage1_4v4_im(col) <= RESIZE(input_real(7)(col)) - RESIZE(input_imag(6)(col));
            end loop;
            
            -- 8. Zeile
            -- Real
          when "111" =>
            for col in 0 to 7 loop
            sum7_stage1_1v6_re(col) <= RESIZE(input_real(0)(col)) - RESIZE(input_real(4)(col));
            sum7_stage1_2v6_re(col) <= RESIZE(input_imag(2)(col)) - RESIZE(input_imag(6)(col));
            --MultPart
            sum7_stage1_3v6_re(col) <= RESIZE(input_real(1)(col)) - RESIZE(input_real(3)(col));
            sum7_stage1_4v6_re(col) <= RESIZE(input_imag(1)(col)) - RESIZE(input_real(5)(col));
            sum7_stage1_5v6_re(col) <= RESIZE(input_imag(3)(col)) - RESIZE(input_imag(5)(col));
            sum7_stage1_6v6_re(col) <= RESIZE(input_real(7)(col)) - RESIZE(input_imag(7)(col));
            
            -- Imag
            sum7_stage1_1v6_im(col) <= RESIZE(input_imag(0)(col)) - RESIZE(input_real(2)(col));
            sum7_stage1_2v6_im(col) <= RESIZE(input_real(6)(col)) - RESIZE(input_imag(4)(col));
            --MultPart
            sum7_stage1_3v6_im(col) <= RESIZE(input_imag(1)(col)) - RESIZE(input_real(1)(col));
            sum7_stage1_4v6_im(col) <= RESIZE(input_real(5)(col)) - RESIZE(input_real(3)(col));
            
            sum7_stage1_5v6_im(col) <= RESIZE(input_real(7)(col)) - RESIZE(input_imag(3)(col));
            sum7_stage1_6v6_im(col) <= RESIZE(input_imag(7)(col)) - RESIZE(input_imag(5)(col));
            end loop;
          when others => W_row <= W_row;
        end case;  
        
        nextMultState <= additions_stage2;  
    
      when additions_stage2 =>
          
        case W_row is
          when "000" =>
            for col in 0 to 7 loop
            -- 1. Zeile aus W aufsummieren
            -- Real
            sum0_stage2_1v2_re(col) <= RESIZE(sum0_stage1_1v4_re(col)) + RESIZE(sum0_stage1_2v4_re(col));
            sum0_stage2_2v2_re(col) <= RESIZE(sum0_stage1_3v4_re(col)) + RESIZE(sum0_stage1_4v4_re(col));
            -- Imag
            sum0_stage2_1v2_im(col) <= RESIZE(sum0_stage1_1v4_im(col)) + RESIZE(sum0_stage1_2v4_im(col));
            sum0_stage2_2v2_im(col) <= RESIZE(sum0_stage1_3v4_im(col)) + RESIZE(sum0_stage1_4v4_im(col));
            end loop;
            
          when "001" =>
            for col in 0 to 7 loop
            -- 2. Zeile aus W
            -- Real
            sum1_stage2_1v3_re(col) <= RESIZE(sum1_stage1_1v6_re(col)) + RESIZE(sum1_stage1_2v6_re(col));
            --MultPart
            sum1_stage2_2v3_re(col) <= RESIZE(sum1_stage1_3v6_re(col)) + RESIZE(sum1_stage1_4v6_re(col));
            sum1_stage2_3v3_re(col) <= RESIZE(sum1_stage1_5v6_re(col)) + RESIZE(sum1_stage1_6v6_re(col));
            -- Imag
            sum1_stage2_1v3_im(col) <= RESIZE(sum1_stage1_1v6_im(col)) + RESIZE(sum1_stage1_2v6_im(col));
            --MultPart
            sum1_stage2_2v3_im(col) <= RESIZE(sum1_stage1_3v6_im(col)) + RESIZE(sum1_stage1_4v6_im(col));
            sum1_stage2_3v3_im(col) <= RESIZE(sum1_stage1_5v6_im(col)) + RESIZE(sum1_stage1_6v6_im(col));
            end loop;
            
            -- 3. Zeile aus W
            -- Real
          when "010" =>
            for col in 0 to 7 loop
            sum2_stage2_1v2_re(col) <= RESIZE(sum2_stage1_1v4_re(col)) + RESIZE(sum2_stage1_2v4_re(col));
            sum2_stage2_2v2_re(col) <= RESIZE(sum2_stage1_3v4_re(col)) + RESIZE(sum2_stage1_4v4_re(col));
            -- Imag
            sum2_stage2_1v2_im(col) <= RESIZE(sum2_stage1_1v4_im(col)) + RESIZE(sum2_stage1_2v4_im(col));
            sum2_stage2_2v2_im(col) <= RESIZE(sum2_stage1_3v4_im(col)) + RESIZE(sum2_stage1_4v4_im(col));
            end loop;
            
            -- 4. Zeile aus W
            -- Real
          when "011" =>
            for col in 0 to 7 loop
            sum3_stage2_1v3_re(col) <= RESIZE(sum3_stage1_1v6_re(col)) + RESIZE(sum3_stage1_2v6_re(col));
            --MultPart
            sum3_stage2_2v3_re(col) <= RESIZE(sum3_stage1_3v6_re(col)) + RESIZE(sum3_stage1_4v6_re(col));
            sum3_stage2_3v3_re(col) <= RESIZE(sum3_stage1_5v6_re(col)) + RESIZE(sum3_stage1_6v6_re(col));
            
            -- Imag
            sum3_stage2_1v3_im(col) <= RESIZE(sum3_stage1_1v6_im(col)) + RESIZE(sum3_stage1_2v6_im(col));
            --MultPart
            sum3_stage2_2v3_im(col) <= RESIZE(sum3_stage1_3v6_im(col)) + RESIZE(sum3_stage1_4v6_im(col));
            sum3_stage2_3v3_im(col) <= RESIZE(sum3_stage1_5v6_im(col)) + RESIZE(sum3_stage1_6v6_im(col));
            end loop;
                        
            -- 5. Zeile
            -- Real
          when "100" =>
            for col in 0 to 7 loop
            sum4_stage2_1v2_re(col) <= RESIZE(sum4_stage1_1v4_re(col)) + RESIZE(sum4_stage1_2v4_re(col));
            sum4_stage2_2v2_re(col) <= RESIZE(sum4_stage1_3v4_re(col)) + RESIZE(sum4_stage1_4v4_re(col));
            -- Imag
            sum4_stage2_1v2_im(col) <= RESIZE(sum4_stage1_1v4_im(col)) + RESIZE(sum4_stage1_2v4_im(col));
            sum4_stage2_2v2_im(col) <= RESIZE(sum4_stage1_3v4_im(col)) + RESIZE(sum4_stage1_4v4_im(col));
            end loop;
            
            -- 6. Zeile
            -- Real
          when "101" =>
            for col in 0 to 7 loop
            sum5_stage2_1v3_re(col) <= RESIZE(sum5_stage1_1v6_re(col)) + RESIZE(sum5_stage1_2v6_re(col));
            --MultPart
            sum5_stage2_2v3_re(col) <= RESIZE(sum5_stage1_3v6_re(col)) + RESIZE(sum5_stage1_4v6_re(col));
            sum5_stage2_3v3_re(col) <= RESIZE(sum5_stage1_5v6_re(col)) + RESIZE(sum5_stage1_6v6_re(col));
            -- Imag
            sum5_stage2_1v3_im(col) <= RESIZE(sum5_stage1_1v6_im(col)) + RESIZE(sum5_stage1_2v6_im(col));
            --MultPart
            sum5_stage2_2v3_im(col) <= RESIZE(sum5_stage1_3v6_im(col)) + RESIZE(sum5_stage1_4v6_im(col));
            sum5_stage2_3v3_im(col) <= RESIZE(sum5_stage1_5v6_im(col)) + RESIZE(sum5_stage1_6v6_im(col));
            end loop;
            
            -- 7. Zeile
            -- Real
          when "110" =>
            for col in 0 to 7 loop
            sum6_stage2_1v2_re(col) <= RESIZE(sum6_stage1_1v4_re(col)) + RESIZE(sum6_stage1_2v4_re(col));
            sum6_stage2_2v2_re(col) <= RESIZE(sum6_stage1_3v4_re(col)) + RESIZE(sum6_stage1_4v4_re(col));
            -- Imag
            sum6_stage2_1v2_im(col) <= RESIZE(sum6_stage1_1v4_im(col)) + RESIZE(sum6_stage1_2v4_im(col));
            sum6_stage2_2v2_im(col) <= RESIZE(sum6_stage1_3v4_im(col)) + RESIZE(sum6_stage1_4v4_im(col));
            end loop;
            
            -- 8. Zeile
            -- Real
          when "111" =>
            for col in 0 to 7 loop
            sum7_stage2_1v3_re(col) <= RESIZE(sum7_stage1_1v6_re(col)) + RESIZE(sum7_stage1_2v6_re(col));
            --MultPart
            sum7_stage2_2v3_re(col) <= RESIZE(sum7_stage1_3v6_re(col)) + RESIZE(sum7_stage1_4v6_re(col));
            sum7_stage2_3v3_re(col) <= RESIZE(sum7_stage1_5v6_re(col)) + RESIZE(sum7_stage1_6v6_re(col));
            -- Imag
            sum7_stage2_1v3_im(col) <= RESIZE(sum7_stage1_1v6_im(col)) + RESIZE(sum7_stage1_2v6_im(col));
            --MultPart
            --2_6 und 3_6 vertauscht
            sum7_stage2_2v3_im(col) <= RESIZE(sum7_stage1_3v6_im(col)) + RESIZE(sum7_stage1_5v6_im(col));
            sum7_stage2_3v3_im(col) <= RESIZE(sum7_stage1_4v6_im(col)) + RESIZE(sum7_stage1_6v6_im(col));
            end loop;
            
          when others => W_row <= W_row;
        end case;

        nextMultState <= additions_stage3;
        
        
      when additions_stage3 =>
        case W_row is
          -- 1. Zeile aus W
          when "000" =>
            for col in 0 to 7 loop
              -- Real
              sum0_stage3_1v1_re(col) <= RESIZE(sum0_stage2_1v2_re(col)) + RESIZE(sum0_stage2_2v2_re(col));
              -- Imag
              sum0_stage3_1v1_im(col) <= RESIZE(sum0_stage2_1v2_im(col)) + RESIZE(sum0_stage2_2v2_im(col));
            end loop;
                
                -- 2. Zeile aus W
          when "001" =>
            for col in 0 to 7 loop
              -- Real
              sum1_stage3_1v1_re(col) <= RESIZE(sum1_stage2_2v3_re(col)) + RESIZE(sum1_stage2_3v3_re(col));    
              -- Imag
              sum1_stage3_1v1_im(col) <= RESIZE(sum1_stage2_2v3_im(col)) + RESIZE(sum1_stage2_3v3_im(col));
            end loop;
                
          -- 3. Zeile aus W
          when "010" =>
            for col in 0 to 7 loop
              -- Real
              sum2_stage3_1v1_re(col) <= RESIZE(sum2_stage2_1v2_re(col)) + RESIZE(sum2_stage2_2v2_re(col));
              -- Imag
              sum2_stage3_1v1_im(col) <= RESIZE(sum2_stage2_1v2_im(col)) + RESIZE(sum2_stage2_2v2_im(col));
            end loop;
                
          -- 4. Zeile aus W
          when "011" =>
            for col in 0 to 7 loop
              -- Real
              sum3_stage3_1v1_re(col) <= RESIZE(sum3_stage2_2v3_re(col)) + RESIZE(sum3_stage2_3v3_re(col));
              -- Imag
              sum3_stage3_1v1_im(col) <= RESIZE(sum3_stage2_2v3_im(col)) + RESIZE(sum3_stage2_3v3_im(col));
            end loop;
                
          -- 5. Zeile
          when "100" =>
            for col in 0 to 7 loop
              -- Real
              sum4_stage3_1v1_re(col) <= RESIZE(sum4_stage2_1v2_re(col)) + RESIZE(sum4_stage2_2v2_re(col));
              -- Imag
              sum4_stage3_1v1_im(col) <= RESIZE(sum4_stage2_1v2_im(col)) + RESIZE(sum4_stage2_2v2_im(col));
            end loop;
                
          -- 6. Zeile
          when "101" =>
            for col in 0 to 7 loop
              -- Real
              sum5_stage3_1v1_re(col) <= RESIZE(sum5_stage2_2v3_re(col)) + RESIZE(sum5_stage2_3v3_re(col));
              -- Imag
              sum5_stage3_1v1_im(col) <= RESIZE(sum5_stage2_2v3_im(col)) + RESIZE(sum5_stage2_3v3_im(col));
            end loop;
                
          -- 7. Zeile
          when "110" =>
            for col in 0 to 7 loop
              -- Real
              sum6_stage3_1v1_re(col) <= RESIZE(sum6_stage2_1v2_re(col)) + RESIZE(sum6_stage2_2v2_re(col));
              -- Imag
              sum6_stage3_1v1_im(col) <= RESIZE(sum6_stage2_1v2_im(col)) + RESIZE(sum6_stage2_2v2_im(col));
            end loop;
                
          -- 8. Zeile
          when "111" =>
            for col in 0 to 7 loop
              -- Real
              sum7_stage3_1v1_re(col) <= RESIZE(sum7_stage2_2v3_re(col)) + RESIZE(sum7_stage2_3v3_re(col));
              -- Imag
              sum7_stage3_1v1_im(col) <= RESIZE(sum7_stage2_2v3_im(col)) + RESIZE(sum7_stage2_3v3_im(col));
            end loop;

          when others => W_row <= W_row;
        end case;
        
        nextMultState <= const_mult;
          
            
      when const_mult =>
        case W_row is
          when "001" =>
            for col in 0 to 7 loop
              mult_re_temp(0)(col) := sum1_stage3_1v1_re(col) * my_constant_pos;  
              mult_im_temp(0)(col) := sum1_stage3_1v1_im(col) * my_constant_pos;
            end loop;
                
            for col in 0 to 7 loop             
              mult_re(0)(col) <= mult_re_temp(0)(col)(bit_width_adder downto 0);
              mult_im(0)(col) <= mult_im_temp(0)(col)(bit_width_adder downto 0);
            end loop;
                         
          when "011" =>
            for col in 0 to 7 loop
              mult_re_temp(1)(col) := sum3_stage3_1v1_re(col) * my_constant_pos;
              mult_im_temp(1)(col) := sum3_stage3_1v1_im(col) * my_constant_pos;
            end loop;
              
            for col in 0 to 7 loop             
              mult_re(1)(col) <= mult_re_temp(1)(col)(bit_width_adder downto 0);
              mult_im(1)(col) <= mult_im_temp(1)(col)(bit_width_adder downto 0);
            end loop;
 
          when "101" =>
            for col in 0 to 7 loop
              mult_re_temp(2)(col) := sum5_stage3_1v1_re(col) * my_constant_pos;
              mult_im_temp(2)(col) := sum5_stage3_1v1_im(col) * my_constant_pos;
            end loop;
                
            for col in 0 to 7 loop             
              mult_re(2)(col) <= mult_re_temp(2)(col)(bit_width_adder downto 0);
              mult_im(2)(col) <= mult_im_temp(2)(col)(bit_width_adder downto 0);
            end loop;
                
          when "111" =>
            for col in 0 to 7 loop
              mult_re_temp(3)(col) := sum7_stage3_1v1_re(col) * my_constant_pos;
              mult_im_temp(3)(col) := sum7_stage3_1v1_im(col) * my_constant_pos;
            end loop;
            
            for col in 0 to 7 loop             
              mult_re(3)(col) <= mult_re_temp(3)(col)(bit_width_adder downto 0);
              mult_im(3)(col) <= mult_im_temp(3)(col)(bit_width_adder downto 0);
            end loop;
                        
          when others => W_row <= W_row;
        end case;
        
        nextMultState <= additions_stage4;

      when additions_stage4 =>
            
        case W_row is
          -- 2. Zeile
          when "001" =>
            for col in 0 to 7 loop
              -- Real  
              sum1_stage4_1v1_re(col) <= RESIZE(mult_re(0)(col)) + RESIZE(sum1_stage2_1v3_re(col));
              -- Imag
              sum1_stage4_1v1_im(col) <= RESIZE(mult_im(0)(col)) + RESIZE(sum1_stage2_1v3_im(col));
            end loop;
            
            -- 4. Zeile
            when "011" =>
              for col in 0 to 7 loop
                  -- Real
                  sum3_stage4_1v1_re(col) <= RESIZE(mult_re(1)(col)) + RESIZE(sum3_stage2_1v3_re(col));
                  -- Imag
                  sum3_stage4_1v1_im(col) <= RESIZE(mult_im(1)(col)) + RESIZE(sum3_stage2_1v3_im(col));
                end loop;
                        
            -- 6. Zeile
            when "101" =>
              for col in 0 to 7 loop
                -- Real
                sum5_stage4_1v1_re(col) <= RESIZE(mult_re(2)(col)) + RESIZE(sum5_stage2_1v3_re(col));
                -- Imag
                sum5_stage4_1v1_im(col) <= RESIZE(mult_im(2)(col)) + RESIZE(sum5_stage2_1v3_im(col));
              end loop;
                
            -- 8. Zeile
            when "111" =>
              for col in 0 to 7 loop
                -- Real
                sum7_stage4_1v1_re(col) <= RESIZE(mult_re(3)(col)) + RESIZE(sum7_stage2_1v3_re(col));
                -- Imag
                sum7_stage4_1v1_im(col) <= RESIZE(mult_im(3)(col)) + RESIZE(sum7_stage2_1v3_im(col));
              end loop;
                            
            when others => W_row <= W_row;
          end case;
          
          nextMultState <= pause;
            
            
          when pause =>
            nextMultState <= set_ready_bit;
            
          when set_ready_bit =>
            if W_row = 7 then
              result_ready <= '1';
            else 
              result_ready <= '0';
            end if;
            
            nextMultState <= additions_stage1;
            W_row <= W_row+1;
            
          when others => nextMultState <= additions_stage1;
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
    
          
          if multState = additions_stage4 then
            for col in 0 to 7 loop
            result_real(0)(col)      <= sum0_stage3_1v1_re(col)(bit_width_extern-1 downto 0);
            result_real_int(0)(col)  <= sum0_stage3_1v1_re(col)(bit_width_extern-1 downto 0);
            result_real(1)(col)      <= sum1_stage4_1v1_re(col)(bit_width_extern-1 downto 0);
            result_real_int(1)(col)  <= sum1_stage4_1v1_re(col)(bit_width_extern-1 downto 0);
            result_real(2)(col)      <= sum2_stage3_1v1_re(col)(bit_width_extern-1 downto 0);
            result_real_int(2)(col)  <= sum2_stage3_1v1_re(col)(bit_width_extern-1 downto 0);
            result_real(3)(col)      <= sum3_stage4_1v1_re(col)(bit_width_extern-1 downto 0);
            result_real_int(3)(col)  <= sum3_stage4_1v1_re(col)(bit_width_extern-1 downto 0);
            result_real(4)(col)      <= sum4_stage3_1v1_re(col)(bit_width_extern-1 downto 0);
            result_real_int(4)(col)  <= sum4_stage3_1v1_re(col)(bit_width_extern-1 downto 0);
            result_real(5)(col)      <= sum5_stage4_1v1_re(col)(bit_width_extern-1 downto 0);
            result_real_int(5)(col)  <= sum5_stage4_1v1_re(col)(bit_width_extern-1 downto 0);
            result_real(6)(col)      <= sum6_stage3_1v1_re(col)(bit_width_extern-1 downto 0);
            result_real_int(6)(col)  <= sum6_stage3_1v1_re(col)(bit_width_extern-1 downto 0);
            result_real(7)(col)      <= sum7_stage4_1v1_re(col)(bit_width_extern-1 downto 0);
            result_real_int(7)(col)  <= sum7_stage4_1v1_re(col)(bit_width_extern-1 downto 0);
        
        
            result_imag(0)(col)      <= sum0_stage3_1v1_im(col)(bit_width_extern-1 downto 0);
            result_imag_int(0)(col)  <= sum0_stage3_1v1_im(col)(bit_width_extern-1 downto 0);
            result_imag(1)(col)      <= sum1_stage4_1v1_im(col)(bit_width_extern-1 downto 0);
            result_imag_int(1)(col)  <= sum1_stage4_1v1_im(col)(bit_width_extern-1 downto 0);
            result_imag(2)(col)      <= sum2_stage3_1v1_im(col)(bit_width_extern-1 downto 0);
            result_imag_int(2)(col)  <= sum2_stage3_1v1_im(col)(bit_width_extern-1 downto 0);
            result_imag(3)(col)      <= sum3_stage4_1v1_im(col)(bit_width_extern-1 downto 0);
            result_imag_int(3)(col)  <= sum3_stage4_1v1_im(col)(bit_width_extern-1 downto 0);
            result_imag(4)(col)      <= sum4_stage3_1v1_im(col)(bit_width_extern-1 downto 0);
            result_imag_int(4)(col)  <= sum4_stage3_1v1_im(col)(bit_width_extern-1 downto 0);
            result_imag(5)(col)      <= sum5_stage4_1v1_im(col)(bit_width_extern-1 downto 0);
            result_imag_int(5)(col)  <= sum5_stage4_1v1_im(col)(bit_width_extern-1 downto 0);
            result_imag(6)(col)      <= sum6_stage3_1v1_im(col)(bit_width_extern-1 downto 0);
            result_imag_int(6)(col)  <= sum6_stage3_1v1_im(col)(bit_width_extern-1 downto 0);
            result_imag(7)(col)      <= sum7_stage4_1v1_im(col)(bit_width_extern-1 downto 0);
            result_imag_int(7)(col)  <= sum7_stage4_1v1_im(col)(bit_width_extern-1 downto 0);
            end loop;
          end if;
        end if;
        end process;
    
end arch;
            
            
