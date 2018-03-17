
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use ieee.std_logic_arith.all;
use ieee.numeric_std.all;
library work;
use work.all;
use datatypes.all;
use constants.all;
--use functions.all;


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

signal element     : unsigned(5 downto 0) := "000000";
signal dft_1d_2d   : bit;
signal dft_1d_real : t_2d_array;
signal dft_1d_imag : t_2d_array;


begin


  FSM_TAKT: process(clk)
  begin
    if clk='1' and clk'event then
     -- W_row_out <= W_row;
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
    variable W_row        : unsigned(2 downto 0);
    variable I_col        : unsigned(2 downto 0);
    
    -- 1. Zeile, Stufe 3
    --Real
    variable sum0_stage3_1v1_re : t_1d_array8_15bit;
    --Imag
    variable sum0_stage3_1v1_im : t_1d_array8_15bit;
    
    -- 3. Zeile, Stufe 3
    -- Real
    variable sum2_stage3_1v1_re : t_1d_array8_15bit;
    -- Imag
    variable sum2_stage3_1v1_im : t_1d_array8_15bit;
    
    -- 5. Zeile, Stufe 3
    -- Real
    variable sum4_stage3_1v1_re : t_1d_array8_15bit;
    -- Imag
    variable sum4_stage3_1v1_im : t_1d_array8_15bit;
    
    -- 7. Zeile, Stufe 3
    -- Real
    variable sum6_stage3_1v1_re : t_1d_array8_15bit;
    -- Imag
    variable sum6_stage3_1v1_im : t_1d_array8_15bit;

  
  begin
    if dft_1d_2d = '0' then
      W_row := element(5 downto 3);  -- Twiddlefaktor-Matrix
      I_col := element(2 downto 0);  -- Input-Matrix
      dft_1d_real := input_real;
      dft_1d_imag := input_imag;
    else
      W_row := element(2 downto 0);  -- Twiddlefaktor-Matrix
      I_col := element(5 downto 3);  -- Input-Matrix
    end if;
    
    case multState is

      when additions_stage1 =>
        -- 1. Zeile aus W -> nur Additionen
            -- Real
        case W_row is
          when "000" =>
            sum0_stage1_1v4_re(to_integer(I_col)) <= resize(input_real(0)(to_integer(I_col)), bit_width_adder) + resize(input_real(1)(to_integer(I_col)), bit_width_adder);
            sum0_stage1_2v4_re(to_integer(I_col)) <= resize(input_real(2)(to_integer(I_col)), bit_width_adder) + resize(input_real(3)(to_integer(I_col)), bit_width_adder);
            sum0_stage1_3v4_re(to_integer(I_col)) <= resize(input_real(4)(to_integer(I_col)), bit_width_adder) + resize(input_real(5)(to_integer(I_col)), bit_width_adder);
            sum0_stage1_4v4_re(to_integer(I_col)) <= resize(input_real(6)(to_integer(I_col)), bit_width_adder) + resize(input_real(7)(to_integer(I_col)), bit_width_adder);
            -- Imag
            sum0_stage1_1v4_im(to_integer(I_col)) <= resize(input_imag(0)(to_integer(I_col)), bit_width_adder) + resize(input_imag(1)(to_integer(I_col)), bit_width_adder);
            sum0_stage1_2v4_im(to_integer(I_col)) <= resize(input_imag(2)(to_integer(I_col)), bit_width_adder) + resize(input_imag(3)(to_integer(I_col)), bit_width_adder);
            sum0_stage1_3v4_im(to_integer(I_col)) <= resize(input_imag(4)(to_integer(I_col)), bit_width_adder) + resize(input_imag(5)(to_integer(I_col)), bit_width_adder);
            sum0_stage1_4v4_im(to_integer(I_col)) <= resize(input_imag(6)(to_integer(I_col)), bit_width_adder) + resize(input_imag(7)(to_integer(I_col)), bit_width_adder);
            
            -- 2. Zeile aus W
            -- Real
          when "001" =>
            sum1_stage1_1v6_re(to_integer(I_col)) <= resize(input_real(0)(to_integer(I_col)), bit_width_adder) - resize(input_imag(2)(to_integer(I_col)), bit_width_adder);
            sum1_stage1_2v6_re(to_integer(I_col)) <= resize(input_imag(6)(to_integer(I_col)), bit_width_adder) - resize(input_real(4)(to_integer(I_col)), bit_width_adder);
            -- MultPart
            sum1_stage1_3v6_re(to_integer(I_col)) <= resize(input_real(1)(to_integer(I_col)), bit_width_adder) - resize(input_imag(1)(to_integer(I_col)), bit_width_adder);
            sum1_stage1_4v6_re(to_integer(I_col)) <= resize(input_imag(5)(to_integer(I_col)), bit_width_adder) - resize(input_real(3)(to_integer(I_col)), bit_width_adder);
            sum1_stage1_5v6_re(to_integer(I_col)) <= resize(input_real(7)(to_integer(I_col)), bit_width_adder) - resize(input_imag(3)(to_integer(I_col)), bit_width_adder);
            sum1_stage1_6v6_re(to_integer(I_col)) <= resize(input_imag(7)(to_integer(I_col)), bit_width_adder) - resize(input_real(5)(to_integer(I_col)), bit_width_adder);
            
            
            -- Imag
            sum1_stage1_1v6_im(to_integer(I_col)) <= resize(input_imag(0)(to_integer(I_col)), bit_width_adder) - resize(input_imag(4)(to_integer(I_col)), bit_width_adder);
            sum1_stage1_2v6_im(to_integer(I_col)) <= resize(input_real(2)(to_integer(I_col)), bit_width_adder) - resize(input_real(6)(to_integer(I_col)), bit_width_adder);
            -- MultPart
            sum1_stage1_3v6_im(to_integer(I_col)) <= resize(input_real(1)(to_integer(I_col)), bit_width_adder) - resize(input_imag(3)(to_integer(I_col)), bit_width_adder);
            sum1_stage1_4v6_im(to_integer(I_col)) <= resize(input_imag(1)(to_integer(I_col)), bit_width_adder) - resize(input_real(5)(to_integer(I_col)), bit_width_adder);
            sum1_stage1_5v6_im(to_integer(I_col)) <= resize(input_real(3)(to_integer(I_col)), bit_width_adder) - resize(input_imag(5)(to_integer(I_col)), bit_width_adder);
            sum1_stage1_6v6_im(to_integer(I_col)) <= resize(input_imag(7)(to_integer(I_col)), bit_width_adder) - resize(input_real(7)(to_integer(I_col)), bit_width_adder);
            
            -- 3. Zeile aus W
            -- Real
          when "010" =>
            sum2_stage1_1v4_re(to_integer(I_col)) <= resize(input_real(0)(to_integer(I_col)), bit_width_adder) - resize(input_imag(1)(to_integer(I_col)), bit_width_adder);
            sum2_stage1_2v4_re(to_integer(I_col)) <= resize(input_imag(3)(to_integer(I_col)), bit_width_adder) - resize(input_real(2)(to_integer(I_col)), bit_width_adder);
            sum2_stage1_3v4_re(to_integer(I_col)) <= resize(input_real(4)(to_integer(I_col)), bit_width_adder) - resize(input_imag(5)(to_integer(I_col)), bit_width_adder);
            sum2_stage1_4v4_re(to_integer(I_col)) <= resize(input_imag(7)(to_integer(I_col)), bit_width_adder) - resize(input_real(6)(to_integer(I_col)), bit_width_adder);
            --Imag
            sum2_stage1_1v4_im(to_integer(I_col)) <= resize(input_imag(0)(to_integer(I_col)), bit_width_adder) - resize(input_imag(2)(to_integer(I_col)), bit_width_adder);
            sum2_stage1_2v4_im(to_integer(I_col)) <= resize(input_real(1)(to_integer(I_col)), bit_width_adder) - resize(input_real(3)(to_integer(I_col)), bit_width_adder);
            sum2_stage1_3v4_im(to_integer(I_col)) <= resize(input_imag(4)(to_integer(I_col)), bit_width_adder) - resize(input_imag(6)(to_integer(I_col)), bit_width_adder);
            sum2_stage1_4v4_im(to_integer(I_col)) <= resize(input_real(5)(to_integer(I_col)), bit_width_adder) - resize(input_real(7)(to_integer(I_col)), bit_width_adder);
            
            -- 4. Zeile aus W
            -- Real
          when "011" =>
            sum3_stage1_1v6_re(to_integer(I_col)) <= resize(input_real(0)(to_integer(I_col)), bit_width_adder) - resize(input_real(4)(to_integer(I_col)), bit_width_adder);
            sum3_stage1_2v6_re(to_integer(I_col)) <= resize(input_imag(2)(to_integer(I_col)), bit_width_adder) - resize(input_imag(6)(to_integer(I_col)), bit_width_adder);
            --MultPart
            sum3_stage1_3v6_re(to_integer(I_col)) <= resize(input_real(3)(to_integer(I_col)), bit_width_adder) - resize(input_real(1)(to_integer(I_col)), bit_width_adder);
            sum3_stage1_4v6_re(to_integer(I_col)) <= resize(input_real(5)(to_integer(I_col)), bit_width_adder) - resize(input_imag(1)(to_integer(I_col)), bit_width_adder);
            sum3_stage1_5v6_re(to_integer(I_col)) <= resize(input_imag(5)(to_integer(I_col)), bit_width_adder) - resize(input_imag(3)(to_integer(I_col)), bit_width_adder);
            sum3_stage1_6v6_re(to_integer(I_col)) <= resize(input_imag(7)(to_integer(I_col)), bit_width_adder) - resize(input_real(7)(to_integer(I_col)), bit_width_adder);
            
            -- Imag
            sum3_stage1_1v6_im(to_integer(I_col)) <= resize(input_imag(0)(to_integer(I_col)), bit_width_adder) - resize(input_real(2)(to_integer(I_col)), bit_width_adder);
            sum3_stage1_2v6_im(to_integer(I_col)) <= resize(input_real(6)(to_integer(I_col)), bit_width_adder) - resize(input_imag(4)(to_integer(I_col)), bit_width_adder);
            --MultPart
            sum3_stage1_3v6_im(to_integer(I_col)) <= resize(input_real(1)(to_integer(I_col)), bit_width_adder) - resize(input_imag(1)(to_integer(I_col)), bit_width_adder);
            sum3_stage1_4v6_im(to_integer(I_col)) <= resize(input_imag(3)(to_integer(I_col)), bit_width_adder) - resize(input_real(5)(to_integer(I_col)), bit_width_adder);
            sum3_stage1_5v6_im(to_integer(I_col)) <= resize(input_real(3)(to_integer(I_col)), bit_width_adder) - resize(input_real(7)(to_integer(I_col)), bit_width_adder);
            sum3_stage1_6v6_im(to_integer(I_col)) <= resize(input_imag(5)(to_integer(I_col)), bit_width_adder) - resize(input_imag(7)(to_integer(I_col)), bit_width_adder);
           
            -- 5. Zeile
            -- Real
          when "100" =>
            sum4_stage1_1v4_re(to_integer(I_col)) <= resize(input_real(0)(to_integer(I_col)), bit_width_adder) - resize(input_real(1)(to_integer(I_col)), bit_width_adder);
            sum4_stage1_2v4_re(to_integer(I_col)) <= resize(input_real(2)(to_integer(I_col)), bit_width_adder) - resize(input_real(3)(to_integer(I_col)), bit_width_adder);
            sum4_stage1_3v4_re(to_integer(I_col)) <= resize(input_real(4)(to_integer(I_col)), bit_width_adder) - resize(input_real(5)(to_integer(I_col)), bit_width_adder);
            sum4_stage1_4v4_re(to_integer(I_col)) <= resize(input_real(6)(to_integer(I_col)), bit_width_adder) - resize(input_real(7)(to_integer(I_col)), bit_width_adder);
            -- Imag
            sum4_stage1_1v4_im(to_integer(I_col)) <= resize(input_imag(0)(to_integer(I_col)), bit_width_adder) - resize(input_imag(1)(to_integer(I_col)), bit_width_adder);
            sum4_stage1_2v4_im(to_integer(I_col)) <= resize(input_imag(2)(to_integer(I_col)), bit_width_adder) - resize(input_imag(3)(to_integer(I_col)), bit_width_adder);
            sum4_stage1_3v4_im(to_integer(I_col)) <= resize(input_imag(4)(to_integer(I_col)), bit_width_adder) - resize(input_imag(5)(to_integer(I_col)), bit_width_adder);
            sum4_stage1_4v4_im(to_integer(I_col)) <= resize(input_imag(6)(to_integer(I_col)), bit_width_adder) - resize(input_imag(7)(to_integer(I_col)), bit_width_adder);
            
            -- 6. Zeile
            -- Real
          when "101" =>
            sum5_stage1_1v6_re(to_integer(I_col)) <= resize(input_real(0)(to_integer(I_col)), bit_width_adder) - resize(input_imag(2)(to_integer(I_col)), bit_width_adder);
            sum5_stage1_2v6_re(to_integer(I_col)) <= resize(input_imag(6)(to_integer(I_col)), bit_width_adder) - resize(input_real(4)(to_integer(I_col)), bit_width_adder);
            --MultPart
            sum5_stage1_3v6_re(to_integer(I_col)) <= resize(input_imag(1)(to_integer(I_col)), bit_width_adder) - resize(input_real(1)(to_integer(I_col)), bit_width_adder);
            sum5_stage1_4v6_re(to_integer(I_col)) <= resize(input_real(3)(to_integer(I_col)), bit_width_adder) - resize(input_imag(5)(to_integer(I_col)), bit_width_adder);
            sum5_stage1_5v6_re(to_integer(I_col)) <= resize(input_imag(3)(to_integer(I_col)), bit_width_adder) - resize(input_real(7)(to_integer(I_col)), bit_width_adder);
            sum5_stage1_6v6_re(to_integer(I_col)) <= resize(input_real(5)(to_integer(I_col)), bit_width_adder) - resize(input_imag(7)(to_integer(I_col)), bit_width_adder);
            
            -- Imag
            sum5_stage1_1v6_im(to_integer(I_col)) <= resize(input_imag(0)(to_integer(I_col)), bit_width_adder) - resize(input_imag(4)(to_integer(I_col)), bit_width_adder);
            sum5_stage1_2v6_im(to_integer(I_col)) <= resize(input_real(2)(to_integer(I_col)), bit_width_adder) - resize(input_real(6)(to_integer(I_col)), bit_width_adder);
            --MultPart
            sum5_stage1_3v6_im(to_integer(I_col)) <= resize(input_imag(3)(to_integer(I_col)), bit_width_adder) - resize(input_real(1)(to_integer(I_col)), bit_width_adder);
            sum5_stage1_4v6_im(to_integer(I_col)) <= resize(input_real(5)(to_integer(I_col)), bit_width_adder) - resize(input_imag(1)(to_integer(I_col)), bit_width_adder);
            sum5_stage1_5v6_im(to_integer(I_col)) <= resize(input_imag(5)(to_integer(I_col)), bit_width_adder) - resize(input_real(3)(to_integer(I_col)), bit_width_adder);
            sum5_stage1_6v6_im(to_integer(I_col)) <= resize(input_real(7)(to_integer(I_col)), bit_width_adder) - resize(input_imag(7)(to_integer(I_col)), bit_width_adder);
            
            -- 7. Zeile
            -- Real
          when "110" =>
            sum6_stage1_1v4_re(to_integer(I_col)) <= resize(input_real(0)(to_integer(I_col)), bit_width_adder) - resize(input_real(2)(to_integer(I_col)), bit_width_adder);
            sum6_stage1_2v4_re(to_integer(I_col)) <= resize(input_imag(1)(to_integer(I_col)), bit_width_adder) - resize(input_imag(3)(to_integer(I_col)), bit_width_adder);
            sum6_stage1_3v4_re(to_integer(I_col)) <= resize(input_real(4)(to_integer(I_col)), bit_width_adder) - resize(input_real(6)(to_integer(I_col)), bit_width_adder);
            sum6_stage1_4v4_re(to_integer(I_col)) <= resize(input_imag(5)(to_integer(I_col)), bit_width_adder) - resize(input_imag(7)(to_integer(I_col)), bit_width_adder);
            -- Imag
            sum6_stage1_1v4_im(to_integer(I_col)) <= resize(input_imag(0)(to_integer(I_col)), bit_width_adder) - resize(input_real(1)(to_integer(I_col)), bit_width_adder);
            sum6_stage1_2v4_im(to_integer(I_col)) <= resize(input_real(3)(to_integer(I_col)), bit_width_adder) - resize(input_imag(2)(to_integer(I_col)), bit_width_adder);
            sum6_stage1_3v4_im(to_integer(I_col)) <= resize(input_imag(4)(to_integer(I_col)), bit_width_adder) - resize(input_real(5)(to_integer(I_col)), bit_width_adder);
            sum6_stage1_4v4_im(to_integer(I_col)) <= resize(input_real(7)(to_integer(I_col)), bit_width_adder) - resize(input_imag(6)(to_integer(I_col)), bit_width_adder);
            
            -- 8. Zeile
            -- Real
          when "111" =>
            sum7_stage1_1v6_re(to_integer(I_col)) <= resize(input_real(0)(to_integer(I_col)), bit_width_adder) - resize(input_real(4)(to_integer(I_col)), bit_width_adder);
            sum7_stage1_2v6_re(to_integer(I_col)) <= resize(input_imag(2)(to_integer(I_col)), bit_width_adder) - resize(input_imag(6)(to_integer(I_col)), bit_width_adder);
            --MultPart
            sum7_stage1_3v6_re(to_integer(I_col)) <= resize(input_real(1)(to_integer(I_col)), bit_width_adder) - resize(input_real(3)(to_integer(I_col)), bit_width_adder);
            sum7_stage1_4v6_re(to_integer(I_col)) <= resize(input_imag(1)(to_integer(I_col)), bit_width_adder) - resize(input_real(5)(to_integer(I_col)), bit_width_adder);
            sum7_stage1_5v6_re(to_integer(I_col)) <= resize(input_imag(3)(to_integer(I_col)), bit_width_adder) - resize(input_imag(5)(to_integer(I_col)), bit_width_adder);
            sum7_stage1_6v6_re(to_integer(I_col)) <= resize(input_real(7)(to_integer(I_col)), bit_width_adder) - resize(input_imag(7)(to_integer(I_col)), bit_width_adder);
            
            -- Imag
            sum7_stage1_1v6_im(to_integer(I_col)) <= resize(input_imag(0)(to_integer(I_col)), bit_width_adder) - resize(input_real(2)(to_integer(I_col)), bit_width_adder);
            sum7_stage1_2v6_im(to_integer(I_col)) <= resize(input_real(6)(to_integer(I_col)), bit_width_adder) - resize(input_imag(4)(to_integer(I_col)), bit_width_adder);
            --MultPart
            sum7_stage1_3v6_im(to_integer(I_col)) <= resize(input_imag(1)(to_integer(I_col)), bit_width_adder) - resize(input_real(1)(to_integer(I_col)), bit_width_adder);
            sum7_stage1_4v6_im(to_integer(I_col)) <= resize(input_real(5)(to_integer(I_col)), bit_width_adder) - resize(input_real(3)(to_integer(I_col)), bit_width_adder);
            
            sum7_stage1_5v6_im(to_integer(I_col)) <= resize(input_real(7)(to_integer(I_col)), bit_width_adder) - resize(input_imag(3)(to_integer(I_col)), bit_width_adder);
            sum7_stage1_6v6_im(to_integer(I_col)) <= resize(input_imag(7)(to_integer(I_col)), bit_width_adder) - resize(input_imag(5)(to_integer(I_col)), bit_width_adder);
          when others => element <= element;
        end case;  
        
        nextMultState <= additions_stage2;  
    
      when additions_stage2 =>
          
        case W_row is
          when "000" =>
            -- 1. Zeile aus W aufsummieren
            -- Real
            sum0_stage2_1v2_re(to_integer(I_col)) <= resize(sum0_stage1_1v4_re(to_integer(I_col)), bit_width_adder+1) + resize(sum0_stage1_2v4_re(to_integer(I_col)), bit_width_adder+1);
            sum0_stage2_2v2_re(to_integer(I_col)) <= resize(sum0_stage1_3v4_re(to_integer(I_col)), bit_width_adder+1) + resize(sum0_stage1_4v4_re(to_integer(I_col)), bit_width_adder+1);
            -- Imag
            sum0_stage2_1v2_im(to_integer(I_col)) <= resize(sum0_stage1_1v4_im(to_integer(I_col)), bit_width_adder+1) + resize(sum0_stage1_2v4_im(to_integer(I_col)), bit_width_adder+1);
            sum0_stage2_2v2_im(to_integer(I_col)) <= resize(sum0_stage1_3v4_im(to_integer(I_col)), bit_width_adder+1) + resize(sum0_stage1_4v4_im(to_integer(I_col)), bit_width_adder+1);
            
          when "001" =>
            -- 2. Zeile aus W
            -- Real
            sum1_stage2_1v3_re(to_integer(I_col)) <= resize(sum1_stage1_1v6_re(to_integer(I_col)), bit_width_adder+1) + resize(sum1_stage1_2v6_re(to_integer(I_col)), bit_width_adder+1);
            --MultPart
            sum1_stage2_2v3_re(to_integer(I_col)) <= resize(sum1_stage1_3v6_re(to_integer(I_col)), bit_width_adder+1) + resize(sum1_stage1_4v6_re(to_integer(I_col)), bit_width_adder+1);
            sum1_stage2_3v3_re(to_integer(I_col)) <= resize(sum1_stage1_5v6_re(to_integer(I_col)), bit_width_adder+1) + resize(sum1_stage1_6v6_re(to_integer(I_col)), bit_width_adder+1);
            -- Imag
            sum1_stage2_1v3_im(to_integer(I_col)) <= resize(sum1_stage1_1v6_im(to_integer(I_col)), bit_width_adder+1) + resize(sum1_stage1_2v6_im(to_integer(I_col)), bit_width_adder+1);
            --MultPart
            sum1_stage2_2v3_im(to_integer(I_col)) <= resize(sum1_stage1_3v6_im(to_integer(I_col)), bit_width_adder+1) + resize(sum1_stage1_4v6_im(to_integer(I_col)), bit_width_adder+1);
            sum1_stage2_3v3_im(to_integer(I_col)) <= resize(sum1_stage1_5v6_im(to_integer(I_col)), bit_width_adder+1) + resize(sum1_stage1_6v6_im(to_integer(I_col)), bit_width_adder+1);
            
            -- 3. Zeile aus W
            -- Real
          when "010" =>
            sum2_stage2_1v2_re(to_integer(I_col)) <= resize(sum2_stage1_1v4_re(to_integer(I_col)), bit_width_adder+1) + resize(sum2_stage1_2v4_re(to_integer(I_col)), bit_width_adder+1);
            sum2_stage2_2v2_re(to_integer(I_col)) <= resize(sum2_stage1_3v4_re(to_integer(I_col)), bit_width_adder+1) + resize(sum2_stage1_4v4_re(to_integer(I_col)), bit_width_adder+1);
            -- Imag
            sum2_stage2_1v2_im(to_integer(I_col)) <= resize(sum2_stage1_1v4_im(to_integer(I_col)), bit_width_adder+1) + resize(sum2_stage1_2v4_im(to_integer(I_col)), bit_width_adder+1);
            sum2_stage2_2v2_im(to_integer(I_col)) <= resize(sum2_stage1_3v4_im(to_integer(I_col)), bit_width_adder+1) + resize(sum2_stage1_4v4_im(to_integer(I_col)), bit_width_adder+1);
            
            -- 4. Zeile aus W
            -- Real
          when "011" =>
            sum3_stage2_1v3_re(to_integer(I_col)) <= resize(sum3_stage1_1v6_re(to_integer(I_col)), bit_width_adder+1) + resize(sum3_stage1_2v6_re(to_integer(I_col)), bit_width_adder+1);
            --MultPart
            sum3_stage2_2v3_re(to_integer(I_col)) <= resize(sum3_stage1_3v6_re(to_integer(I_col)), bit_width_adder+1) + resize(sum3_stage1_4v6_re(to_integer(I_col)), bit_width_adder+1);
            sum3_stage2_3v3_re(to_integer(I_col)) <= resize(sum3_stage1_5v6_re(to_integer(I_col)), bit_width_adder+1) + resize(sum3_stage1_6v6_re(to_integer(I_col)), bit_width_adder+1);
            
            -- Imag
            sum3_stage2_1v3_im(to_integer(I_col)) <= resize(sum3_stage1_1v6_im(to_integer(I_col)), bit_width_adder+1) + resize(sum3_stage1_2v6_im(to_integer(I_col)), bit_width_adder+1);
            --MultPart
            sum3_stage2_2v3_im(to_integer(I_col)) <= resize(sum3_stage1_3v6_im(to_integer(I_col)), bit_width_adder+1) + resize(sum3_stage1_4v6_im(to_integer(I_col)), bit_width_adder+1);
            sum3_stage2_3v3_im(to_integer(I_col)) <= resize(sum3_stage1_5v6_im(to_integer(I_col)), bit_width_adder+1) + resize(sum3_stage1_6v6_im(to_integer(I_col)), bit_width_adder+1);
                        
            -- 5. Zeile
            -- Real
          when "100" =>
            sum4_stage2_1v2_re(to_integer(I_col)) <= resize(sum4_stage1_1v4_re(to_integer(I_col)), bit_width_adder+1) + resize(sum4_stage1_2v4_re(to_integer(I_col)), bit_width_adder+1);
            sum4_stage2_2v2_re(to_integer(I_col)) <= resize(sum4_stage1_3v4_re(to_integer(I_col)), bit_width_adder+1) + resize(sum4_stage1_4v4_re(to_integer(I_col)), bit_width_adder+1);
            -- Imag
            sum4_stage2_1v2_im(to_integer(I_col)) <= resize(sum4_stage1_1v4_im(to_integer(I_col)), bit_width_adder+1) + resize(sum4_stage1_2v4_im(to_integer(I_col)), bit_width_adder+1);
            sum4_stage2_2v2_im(to_integer(I_col)) <= resize(sum4_stage1_3v4_im(to_integer(I_col)), bit_width_adder+1) + resize(sum4_stage1_4v4_im(to_integer(I_col)), bit_width_adder+1);
            
            -- 6. Zeile
            -- Real
          when "101" =>
            sum5_stage2_1v3_re(to_integer(I_col)) <= resize(sum5_stage1_1v6_re(to_integer(I_col)), bit_width_adder+1) + resize(sum5_stage1_2v6_re(to_integer(I_col)), bit_width_adder+1);
            --MultPart
            sum5_stage2_2v3_re(to_integer(I_col)) <= resize(sum5_stage1_3v6_re(to_integer(I_col)), bit_width_adder+1) + resize(sum5_stage1_4v6_re(to_integer(I_col)), bit_width_adder+1);
            sum5_stage2_3v3_re(to_integer(I_col)) <= resize(sum5_stage1_5v6_re(to_integer(I_col)), bit_width_adder+1) + resize(sum5_stage1_6v6_re(to_integer(I_col)), bit_width_adder+1);
            -- Imag
            sum5_stage2_1v3_im(to_integer(I_col)) <= resize(sum5_stage1_1v6_im(to_integer(I_col)), bit_width_adder+1) + resize(sum5_stage1_2v6_im(to_integer(I_col)), bit_width_adder+1);
            --MultPart
            sum5_stage2_2v3_im(to_integer(I_col)) <= resize(sum5_stage1_3v6_im(to_integer(I_col)), bit_width_adder+1) + resize(sum5_stage1_4v6_im(to_integer(I_col)), bit_width_adder+1);
            sum5_stage2_3v3_im(to_integer(I_col)) <= resize(sum5_stage1_5v6_im(to_integer(I_col)), bit_width_adder+1) + resize(sum5_stage1_6v6_im(to_integer(I_col)), bit_width_adder+1);
            
            -- 7. Zeile
            -- Real
          when "110" =>
            sum6_stage2_1v2_re(to_integer(I_col)) <= resize(sum6_stage1_1v4_re(to_integer(I_col)), bit_width_adder+1) + resize(sum6_stage1_2v4_re(to_integer(I_col)), bit_width_adder+1);
            sum6_stage2_2v2_re(to_integer(I_col)) <= resize(sum6_stage1_3v4_re(to_integer(I_col)), bit_width_adder+1) + resize(sum6_stage1_4v4_re(to_integer(I_col)), bit_width_adder+1);
            -- Imag
            sum6_stage2_1v2_im(to_integer(I_col)) <= resize(sum6_stage1_1v4_im(to_integer(I_col)), bit_width_adder+1) + resize(sum6_stage1_2v4_im(to_integer(I_col)), bit_width_adder+1);
            sum6_stage2_2v2_im(to_integer(I_col)) <= resize(sum6_stage1_3v4_im(to_integer(I_col)), bit_width_adder+1) + resize(sum6_stage1_4v4_im(to_integer(I_col)), bit_width_adder+1);
            
            -- 8. Zeile
            -- Real
          when "111" =>
            sum7_stage2_1v3_re(to_integer(I_col)) <= resize(sum7_stage1_1v6_re(to_integer(I_col)), bit_width_adder+1) + resize(sum7_stage1_2v6_re(to_integer(I_col)), bit_width_adder+1);
            --MultPart
            sum7_stage2_2v3_re(to_integer(I_col)) <= resize(sum7_stage1_3v6_re(to_integer(I_col)), bit_width_adder+1) + resize(sum7_stage1_4v6_re(to_integer(I_col)), bit_width_adder+1);
            sum7_stage2_3v3_re(to_integer(I_col)) <= resize(sum7_stage1_5v6_re(to_integer(I_col)), bit_width_adder+1) + resize(sum7_stage1_6v6_re(to_integer(I_col)), bit_width_adder+1);
            -- Imag
            sum7_stage2_1v3_im(to_integer(I_col)) <= resize(sum7_stage1_1v6_im(to_integer(I_col)), bit_width_adder+1) + resize(sum7_stage1_2v6_im(to_integer(I_col)), bit_width_adder+1);
            --MultPart
            --2_6 und 3_6 vertauscht
            sum7_stage2_2v3_im(to_integer(I_col)) <= resize(sum7_stage1_3v6_im(to_integer(I_col)), bit_width_adder+1) + resize(sum7_stage1_5v6_im(to_integer(I_col)), bit_width_adder+1);
            sum7_stage2_3v3_im(to_integer(I_col)) <= resize(sum7_stage1_4v6_im(to_integer(I_col)), bit_width_adder+1) + resize(sum7_stage1_6v6_im(to_integer(I_col)), bit_width_adder+1);
            
          when others => element <= element;
        end case;

        nextMultState <= additions_stage3;
        
        
      when additions_stage3 =>
        case W_row is
          -- 1. Zeile aus W
          when "000" =>
              -- Real
              sum0_stage3_1v1_re(to_integer(I_col)) := resize(sum0_stage2_1v2_re(to_integer(I_col)), bit_width_adder+2) + resize(sum0_stage2_2v2_re(to_integer(I_col)), bit_width_adder+2);
              dft_1d_real(0)(I_col) <= sum0_stage3_1v1_re(to_integer(I_col))(bit_width_extern-1 downto 0);
              -- Imag
              sum0_stage3_1v1_im(to_integer(I_col)) := resize(sum0_stage2_1v2_im(to_integer(I_col)), bit_width_adder+2) + resize(sum0_stage2_2v2_im(to_integer(I_col)), bit_width_adder+2);
              dft_1d_imag(0)(I_col) <= sum0_stage3_1v1_im(to_integer(I_col))(bit_width_extern-1 downto 0);
              -- 2. Zeile aus W
          when "001" =>
              -- Real
              sum1_stage3_1v1_re(to_integer(I_col)) <= resize(sum1_stage2_2v3_re(to_integer(I_col)), bit_width_adder+2) + resize(sum1_stage2_3v3_re(to_integer(I_col)), bit_width_adder+2);    
              -- Imag
              sum1_stage3_1v1_im(to_integer(I_col)) <= resize(sum1_stage2_2v3_im(to_integer(I_col)), bit_width_adder+2) + resize(sum1_stage2_3v3_im(to_integer(I_col)), bit_width_adder+2);
                
          -- 3. Zeile aus W
          when "010" =>
              -- Real
              sum2_stage3_1v1_re(to_integer(I_col)) := resize(sum2_stage2_1v2_re(to_integer(I_col)), bit_width_adder+2) + resize(sum2_stage2_2v2_re(to_integer(I_col)), bit_width_adder+2);
              dft_1d_real(2)(I_col) <= sum2_stage3_1v1_re(to_integer(I_col))(bit_width_extern-1 downto 0);
              -- Imag
              sum2_stage3_1v1_im(to_integer(I_col)) := resize(sum2_stage2_1v2_im(to_integer(I_col)), bit_width_adder+2) + resize(sum2_stage2_2v2_im(to_integer(I_col)), bit_width_adder+2);
              dft_1d_imag(2)(I_col) <= sum2_stage3_1v1_im(to_integer(I_col))(bit_width_extern-1 downto 0);
              
          -- 4. Zeile aus W
          when "011" =>
              -- Real
              sum3_stage3_1v1_re(to_integer(I_col)) <= resize(sum3_stage2_2v3_re(to_integer(I_col)), bit_width_adder+2) + resize(sum3_stage2_3v3_re(to_integer(I_col)), bit_width_adder+2);
              -- Imag
              sum3_stage3_1v1_im(to_integer(I_col)) <= resize(sum3_stage2_2v3_im(to_integer(I_col)), bit_width_adder+2) + resize(sum3_stage2_3v3_im(to_integer(I_col)), bit_width_adder+2);
                
          -- 5. Zeile
          when "100" =>
              -- Real
              sum4_stage3_1v1_re(to_integer(I_col)) := resize(sum4_stage2_1v2_re(to_integer(I_col)), bit_width_adder+2) + resize(sum4_stage2_2v2_re(to_integer(I_col)), bit_width_adder+2);
              dft_1d_real(4)(I_col) <= sum4_stage3_1v1_re(to_integer(I_col))(bit_width_extern-1 downto 0);
              -- Imag
              sum4_stage3_1v1_im(to_integer(I_col)) := resize(sum4_stage2_1v2_im(to_integer(I_col)), bit_width_adder+2) + resize(sum4_stage2_2v2_im(to_integer(I_col)), bit_width_adder+2);
              dft_1d_imag(4)(I_col) <= sum4_stage3_1v1_im(to_integer(I_col))(bit_width_extern-1 downto 0);
              
          -- 6. Zeile
          when "101" =>
              -- Real
              sum5_stage3_1v1_re(to_integer(I_col)) <= resize(sum5_stage2_2v3_re(to_integer(I_col)), bit_width_adder+2) + resize(sum5_stage2_3v3_re(to_integer(I_col)), bit_width_adder+2);
              -- Imag
              sum5_stage3_1v1_im(to_integer(I_col)) <= resize(sum5_stage2_2v3_im(to_integer(I_col)), bit_width_adder+2) + resize(sum5_stage2_3v3_im(to_integer(I_col)), bit_width_adder+2);
                
          -- 7. Zeile
          when "110" =>
              -- Real
              sum6_stage3_1v1_re(to_integer(I_col)) := resize(sum6_stage2_1v2_re(to_integer(I_col)), bit_width_adder+2) + resize(sum6_stage2_2v2_re(to_integer(I_col)), bit_width_adder+2);
              dft_1d_real(6)(I_col) <= sum6_stage3_1v1_re(to_integer(I_col))(bit_width_extern-1 downto 0);
              -- Imag
              sum6_stage3_1v1_im(to_integer(I_col)) := resize(sum6_stage2_1v2_im(to_integer(I_col)), bit_width_adder+2) + resize(sum6_stage2_2v2_im(to_integer(I_col)), bit_width_adder+2);
              dft_1d_imag(6)(I_col) <= sum6_stage3_1v1_im(to_integer(I_col))(bit_width_extern-1 downto 0);
              
          -- 8. Zeile
          when "111" =>
              -- Real
              sum7_stage3_1v1_re(to_integer(I_col)) <= resize(sum7_stage2_2v3_re(to_integer(I_col)), bit_width_adder+2) + resize(sum7_stage2_3v3_re(to_integer(I_col)), bit_width_adder+2);
              -- Imag
              sum7_stage3_1v1_im(to_integer(I_col)) <= resize(sum7_stage2_2v3_im(to_integer(I_col)), bit_width_adder+2) + resize(sum7_stage2_3v3_im(to_integer(I_col)), bit_width_adder+2);

          when others => element <= element;
        end case;
        
        nextMultState <= const_mult;
          
            
      when const_mult =>
        case W_row is
          when "001" =>
              mult_re_temp(0)(to_integer(I_col)) := sum1_stage3_1v1_re(to_integer(I_col)) * my_constant_pos;  
              mult_im_temp(0)(to_integer(I_col)) := sum1_stage3_1v1_im(to_integer(I_col)) * my_constant_pos;
                
              mult_re(0)(to_integer(I_col)) <= mult_re_temp(0)(to_integer(I_col))(bit_width_adder downto 0);
              mult_im(0)(to_integer(I_col)) <= mult_im_temp(0)(to_integer(I_col))(bit_width_adder downto 0);
                         
          when "011" =>
              mult_re_temp(1)(to_integer(I_col)) := sum3_stage3_1v1_re(to_integer(I_col)) * my_constant_pos;
              mult_im_temp(1)(to_integer(I_col)) := sum3_stage3_1v1_im(to_integer(I_col)) * my_constant_pos;
              
              mult_re(1)(to_integer(I_col)) <= mult_re_temp(1)(to_integer(I_col))(bit_width_adder downto 0);
              mult_im(1)(to_integer(I_col)) <= mult_im_temp(1)(to_integer(I_col))(bit_width_adder downto 0);
 
          when "101" =>
              mult_re_temp(2)(to_integer(I_col)) := sum5_stage3_1v1_re(to_integer(I_col)) * my_constant_pos;
              mult_im_temp(2)(to_integer(I_col)) := sum5_stage3_1v1_im(to_integer(I_col)) * my_constant_pos;
                
              mult_re(2)(to_integer(I_col)) <= mult_re_temp(2)(to_integer(I_col))(bit_width_adder downto 0);
              mult_im(2)(to_integer(I_col)) <= mult_im_temp(2)(to_integer(I_col))(bit_width_adder downto 0);
                
          when "111" =>
              mult_re_temp(3)(to_integer(I_col)) := sum7_stage3_1v1_re(to_integer(I_col)) * my_constant_pos;
              mult_im_temp(3)(to_integer(I_col)) := sum7_stage3_1v1_im(to_integer(I_col)) * my_constant_pos;
            
              mult_re(3)(to_integer(I_col)) <= mult_re_temp(3)(to_integer(I_col))(bit_width_adder downto 0);
              mult_im(3)(to_integer(I_col)) <= mult_im_temp(3)(to_integer(I_col))(bit_width_adder downto 0);
                        
          when others => element <= element;
        end case;
        
        nextMultState <= additions_stage4;

      when additions_stage4 =>
            
        case W_row is
          -- 2. Zeile
          when "001" =>
            -- Real  
            sum1_stage4_1v1_re(to_integer(I_col)) <= resize(mult_re(0)(to_integer(I_col)), bit_width_adder+2) + resize(sum1_stage2_1v3_re(to_integer(I_col)), bit_width_adder+2);
            sum1_stage4_1v1_re(col)(bit_width_extern-1 downto 0);
            -- Imag
            sum1_stage4_1v1_im(to_integer(I_col)) <= resize(mult_im(0)(to_integer(I_col)), bit_width_adder+2) + resize(sum1_stage2_1v3_im(to_integer(I_col)), bit_width_adder+2);
            
          -- 4. Zeile
          when "011" =>
            -- Real
            sum3_stage4_1v1_re(to_integer(I_col)) <= resize(mult_re(1)(to_integer(I_col)), bit_width_adder+2) + resize(sum3_stage2_1v3_re(to_integer(I_col)), bit_width_adder+2);
            -- Imag
            sum3_stage4_1v1_im(to_integer(I_col)) <= resize(mult_im(1)(to_integer(I_col)), bit_width_adder+2) + resize(sum3_stage2_1v3_im(to_integer(I_col)), bit_width_adder+2);
                        
          -- 6. Zeile
          when "101" =>
            -- Real
            sum5_stage4_1v1_re(to_integer(I_col)) <= resize(mult_re(2)(to_integer(I_col)), bit_width_adder+2) + resize(sum5_stage2_1v3_re(to_integer(I_col)), bit_width_adder+2);
            -- Imag
            sum5_stage4_1v1_im(to_integer(I_col)) <= resize(mult_im(2)(to_integer(I_col)), bit_width_adder+2) + resize(sum5_stage2_1v3_im(to_integer(I_col)), bit_width_adder+2);
                
          -- 8. Zeile
          when "111" =>
            -- Real
            sum7_stage4_1v1_re(to_integer(I_col)) <= resize(mult_re(3)(to_integer(I_col)), bit_width_adder+2) + resize(sum7_stage2_1v3_re(to_integer(I_col)), bit_width_adder+2);
            -- Imag
            sum7_stage4_1v1_im(to_integer(I_col)) <= resize(mult_im(3)(to_integer(I_col)), bit_width_adder+2) + resize(sum7_stage2_1v3_im(to_integer(I_col)), bit_width_adder+2);
                            
          when others => element <= element;
        end case;
          
        nextMultState <= set_ready_bit;

            
      when set_ready_bit =>
        if element = 63 then
          result_ready <= '1';
          dft_1d_2d <= not dft_1d_2d;
        else 
          result_ready <= '0';
          dft_1d_2d <= dft_1d_2d;
        end if;
            
        nextMultState <= additions_stage1;
        element <= element+1;
            
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
            result_real(0)(col)      <= dft_1d_real(0)(col);
            result_real_int(0)(col)  <= dft_1d_real(0)(col);
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
            
            
