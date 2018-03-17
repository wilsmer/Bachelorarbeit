
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
     W_row_out     : out unsigned(2 downto 0);
     element_out   : out unsigned(5 downto 0);
     ctr_2d_out    : out unsigned(2 downto 0);
     dft_1d_2d_out : out bit
    );
end dft8optimiert;


architecture arch of dft8optimiert is

------------------------------ 1. Zeile-----------------------------------
-- Stufe 1
-- Real
signal sum0_stage1_1v4_re             : signed(bit_width_adder-1 downto 0);
signal sum0_stage1_2v4_re             : signed(bit_width_adder-1 downto 0);
signal sum0_stage1_3v4_re             : signed(bit_width_adder-1 downto 0);
signal sum0_stage1_4v4_re             : signed(bit_width_adder-1 downto 0);
-- Imag
signal sum0_stage1_1v4_im             : signed(bit_width_adder-1 downto 0);
signal sum0_stage1_2v4_im             : signed(bit_width_adder-1 downto 0);
signal sum0_stage1_3v4_im             : signed(bit_width_adder-1 downto 0);
signal sum0_stage1_4v4_im             : signed(bit_width_adder-1 downto 0);

-- Stufe 2
--Real
signal sum0_stage2_1v2_re         : signed(bit_width_adder downto 0);
signal sum0_stage2_2v2_re         : signed(bit_width_adder downto 0);
--Imag
signal sum0_stage2_1v2_im         : signed(bit_width_adder downto 0);
signal sum0_stage2_2v2_im         : signed(bit_width_adder downto 0);

------------------------------ 2. Zeile-----------------------------------
-- Stufe 2
-- Real
signal sum1_stage1_1v6_re          : signed(bit_width_adder-1 downto 0);
signal sum1_stage1_2v6_re          : signed(bit_width_adder-1 downto 0);
signal sum1_stage1_3v6_re          : signed(bit_width_adder-1 downto 0);
signal sum1_stage1_4v6_re          : signed(bit_width_adder-1 downto 0);
signal sum1_stage1_5v6_re          : signed(bit_width_adder-1 downto 0);
signal sum1_stage1_6v6_re          : signed(bit_width_adder-1 downto 0);

--Imag
signal sum1_stage1_1v6_im          : signed(bit_width_adder-1 downto 0);
signal sum1_stage1_2v6_im          : signed(bit_width_adder-1 downto 0);
signal sum1_stage1_3v6_im          : signed(bit_width_adder-1 downto 0);
signal sum1_stage1_4v6_im          : signed(bit_width_adder-1 downto 0);
signal sum1_stage1_5v6_im          : signed(bit_width_adder-1 downto 0);
signal sum1_stage1_6v6_im          : signed(bit_width_adder-1 downto 0);

-- Stufe 3
-- Real
signal sum1_stage2_1v3_re      : signed(bit_width_adder downto 0);
signal sum1_stage2_2v3_re      : signed(bit_width_adder downto 0);
signal sum1_stage2_3v3_re      : signed(bit_width_adder downto 0);
--Imag
signal sum1_stage2_1v3_im      : signed(bit_width_adder downto 0);
signal sum1_stage2_2v3_im      : signed(bit_width_adder downto 0);
signal sum1_stage2_3v3_im      : signed(bit_width_adder downto 0);

-- Stufe 4
-- Real
signal sum1_stage3_1v1_re   : signed(bit_width_adder+1 downto 0);
-- Imag
signal sum1_stage3_1v1_im   : signed(bit_width_adder+1 downto 0);

------------------------------ 3. Zeile-----------------------------------

-- Stufe 2
-- Real
signal sum2_stage1_1v4_re             : signed(bit_width_adder-1 downto 0);
signal sum2_stage1_2v4_re             : signed(bit_width_adder-1 downto 0);
signal sum2_stage1_3v4_re             : signed(bit_width_adder-1 downto 0);
signal sum2_stage1_4v4_re             : signed(bit_width_adder-1 downto 0);
-- Imag
signal sum2_stage1_1v4_im             : signed(bit_width_adder-1 downto 0);
signal sum2_stage1_2v4_im             : signed(bit_width_adder-1 downto 0);
signal sum2_stage1_3v4_im             : signed(bit_width_adder-1 downto 0);
signal sum2_stage1_4v4_im             : signed(bit_width_adder-1 downto 0);

-- Stufe 2
-- Real
signal sum2_stage2_1v2_re         : signed(bit_width_adder downto 0);
signal sum2_stage2_2v2_re         : signed(bit_width_adder downto 0);
-- Imag
signal sum2_stage2_1v2_im         : signed(bit_width_adder downto 0);
signal sum2_stage2_2v2_im         : signed(bit_width_adder downto 0);

------------------------------ 4. Zeile-----------------------------------

-- Stufe 2
-- Real
signal sum3_stage1_1v6_re          : signed(bit_width_adder-1 downto 0);
signal sum3_stage1_2v6_re          : signed(bit_width_adder-1 downto 0);
signal sum3_stage1_3v6_re          : signed(bit_width_adder-1 downto 0);
signal sum3_stage1_4v6_re          : signed(bit_width_adder-1 downto 0);
signal sum3_stage1_5v6_re          : signed(bit_width_adder-1 downto 0);
signal sum3_stage1_6v6_re          : signed(bit_width_adder-1 downto 0);
--Imag
signal sum3_stage1_1v6_im          : signed(bit_width_adder-1 downto 0);
signal sum3_stage1_2v6_im          : signed(bit_width_adder-1 downto 0);
signal sum3_stage1_3v6_im          : signed(bit_width_adder-1 downto 0);
signal sum3_stage1_4v6_im          : signed(bit_width_adder-1 downto 0);
signal sum3_stage1_5v6_im          : signed(bit_width_adder-1 downto 0);
signal sum3_stage1_6v6_im          : signed(bit_width_adder-1 downto 0);

-- Stufe 3
-- Real
signal sum3_stage2_1v3_re     : signed(bit_width_adder downto 0);
signal sum3_stage2_2v3_re     : signed(bit_width_adder downto 0);
signal sum3_stage2_3v3_re     : signed(bit_width_adder downto 0);
--Imag
signal sum3_stage2_1v3_im     : signed(bit_width_adder downto 0);
signal sum3_stage2_2v3_im     : signed(bit_width_adder downto 0);
signal sum3_stage2_3v3_im     : signed(bit_width_adder downto 0);

-- Stufe 4
-- Real
signal sum3_stage3_1v1_re         : signed(bit_width_adder+1 downto 0);
-- Imag
signal sum3_stage3_1v1_im         : signed(bit_width_adder+1 downto 0);

------------------------------ 5. Zeile-----------------------------------
-- Stufe 1
-- Real
signal sum4_stage1_1v4_re       : signed(bit_width_adder-1 downto 0);
signal sum4_stage1_2v4_re       : signed(bit_width_adder-1 downto 0);
signal sum4_stage1_3v4_re       : signed(bit_width_adder-1 downto 0);
signal sum4_stage1_4v4_re       : signed(bit_width_adder-1 downto 0);
-- Imag
signal sum4_stage1_1v4_im       : signed(bit_width_adder-1 downto 0);
signal sum4_stage1_2v4_im       : signed(bit_width_adder-1 downto 0);
signal sum4_stage1_3v4_im       : signed(bit_width_adder-1 downto 0);
signal sum4_stage1_4v4_im       : signed(bit_width_adder-1 downto 0);

-- Stufe 2
-- Real
signal sum4_stage2_1v2_re     : signed(bit_width_adder downto 0);
signal sum4_stage2_2v2_re     : signed(bit_width_adder downto 0);
-- Imag
signal sum4_stage2_1v2_im     : signed(bit_width_adder downto 0);
signal sum4_stage2_2v2_im     : signed(bit_width_adder downto 0);

------------------------------ 6. Zeile-----------------------------------
-- Stufe 2
-- Real
signal sum5_stage1_1v6_re       : signed(bit_width_adder-1 downto 0);
signal sum5_stage1_2v6_re       : signed(bit_width_adder-1 downto 0);
signal sum5_stage1_3v6_re       : signed(bit_width_adder-1 downto 0);
signal sum5_stage1_4v6_re       : signed(bit_width_adder-1 downto 0);
signal sum5_stage1_5v6_re       : signed(bit_width_adder-1 downto 0);
signal sum5_stage1_6v6_re       : signed(bit_width_adder-1 downto 0);
--Imag
signal sum5_stage1_1v6_im       : signed(bit_width_adder-1 downto 0);
signal sum5_stage1_2v6_im       : signed(bit_width_adder-1 downto 0);
signal sum5_stage1_3v6_im       : signed(bit_width_adder-1 downto 0);
signal sum5_stage1_4v6_im       : signed(bit_width_adder-1 downto 0);
signal sum5_stage1_5v6_im       : signed(bit_width_adder-1 downto 0);
signal sum5_stage1_6v6_im       : signed(bit_width_adder-1 downto 0);

-- Stufe 3
-- Real
signal sum5_stage2_1v3_re     : signed(bit_width_adder downto 0);
signal sum5_stage2_2v3_re     : signed(bit_width_adder downto 0);
signal sum5_stage2_3v3_re     : signed(bit_width_adder downto 0);
--Imag
signal sum5_stage2_1v3_im     : signed(bit_width_adder downto 0);
signal sum5_stage2_2v3_im     : signed(bit_width_adder downto 0);
signal sum5_stage2_3v3_im     : signed(bit_width_adder downto 0);

-- Stufe 4
-- Real
signal sum5_stage3_1v1_re   : signed(bit_width_adder+1 downto 0);
-- Imag
signal sum5_stage3_1v1_im   : signed(bit_width_adder+1 downto 0);

------------------------------ 7. Zeile-----------------------------------
-- Stufe 2
-- Real
signal sum6_stage1_1v4_re       : signed(bit_width_adder-1 downto 0);
signal sum6_stage1_2v4_re       : signed(bit_width_adder-1 downto 0);
signal sum6_stage1_3v4_re       : signed(bit_width_adder-1 downto 0);
signal sum6_stage1_4v4_re       : signed(bit_width_adder-1 downto 0);
-- Imag
signal sum6_stage1_1v4_im       : signed(bit_width_adder-1 downto 0);
signal sum6_stage1_2v4_im       : signed(bit_width_adder-1 downto 0);
signal sum6_stage1_3v4_im       : signed(bit_width_adder-1 downto 0);
signal sum6_stage1_4v4_im       : signed(bit_width_adder-1 downto 0);

-- Stufe 2
-- Real
signal sum6_stage2_1v2_re     : signed(bit_width_adder downto 0);
signal sum6_stage2_2v2_re     : signed(bit_width_adder downto 0);
-- Imag
signal sum6_stage2_1v2_im     : signed(bit_width_adder downto 0);
signal sum6_stage2_2v2_im     : signed(bit_width_adder downto 0);

------------------------------ 8. Zeile-----------------------------------
-- Stufe 2
-- Real
signal sum7_stage1_1v6_re       : signed(bit_width_adder-1 downto 0);
signal sum7_stage1_2v6_re       : signed(bit_width_adder-1 downto 0);
signal sum7_stage1_3v6_re       : signed(bit_width_adder-1 downto 0);
signal sum7_stage1_4v6_re       : signed(bit_width_adder-1 downto 0);
signal sum7_stage1_5v6_re       : signed(bit_width_adder-1 downto 0);
signal sum7_stage1_6v6_re       : signed(bit_width_adder-1 downto 0);
--Imag
signal sum7_stage1_1v6_im       : signed(bit_width_adder-1 downto 0);
signal sum7_stage1_2v6_im       : signed(bit_width_adder-1 downto 0);
signal sum7_stage1_3v6_im       : signed(bit_width_adder-1 downto 0);
signal sum7_stage1_4v6_im       : signed(bit_width_adder-1 downto 0);
signal sum7_stage1_5v6_im       : signed(bit_width_adder-1 downto 0);
signal sum7_stage1_6v6_im       : signed(bit_width_adder-1 downto 0);

-- Stufe 3
-- Real
signal sum7_stage2_1v3_re     : signed(bit_width_adder downto 0);
signal sum7_stage2_2v3_re     : signed(bit_width_adder downto 0);
signal sum7_stage2_3v3_re     : signed(bit_width_adder downto 0);
--Imag
signal sum7_stage2_1v3_im     : signed(bit_width_adder downto 0);
signal sum7_stage2_2v3_im     : signed(bit_width_adder downto 0);
signal sum7_stage2_3v3_im     : signed(bit_width_adder downto 0);

-- Stufe 4
-- Real
signal sum7_stage3_1v1_re   : signed(bit_width_adder+1 downto 0);
-- Imag
signal sum7_stage3_1v1_im   : signed(bit_width_adder+1 downto 0);


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
    variable W_row        : integer;
    variable I_col        : integer;
    variable ctr_2d       : unsigned(2 downto 0) := "000";
    
    -- 1. Zeile, Stufe 3
    --Real
    variable sum0_stage3_1v1_re : signed(bit_width_adder+1 downto 0);
    --Imag
    variable sum0_stage3_1v1_im : signed(bit_width_adder+1 downto 0);
    
    -- 2. Zeile, Stufe 5
    -- Real
    variable sum1_stage4_1v1_re : signed(bit_width_adder+1 downto 0);
    -- Imag
    variable sum1_stage4_1v1_im : signed(bit_width_adder+1 downto 0);
    
    -- 3. Zeile, Stufe 3
    -- Real
    variable sum2_stage3_1v1_re : signed(bit_width_adder+1 downto 0);
    -- Imag
    variable sum2_stage3_1v1_im : signed(bit_width_adder+1 downto 0);
    
    -- 4. Zeile, Stufe 5
    -- Real
    variable sum3_stage4_1v1_re : signed(bit_width_adder+1 downto 0);
    -- Imag
    variable sum3_stage4_1v1_im : signed(bit_width_adder+1 downto 0);
    
    -- 5. Zeile, Stufe 3
    -- Real
    variable sum4_stage3_1v1_re : signed(bit_width_adder+1 downto 0);
    -- Imag
    variable sum4_stage3_1v1_im : signed(bit_width_adder+1 downto 0);
    
    -- 6. Zeile, Stufe 5
    -- Real
    variable sum5_stage4_1v1_re : signed(bit_width_adder+1 downto 0);
    -- Imag
    variable sum5_stage4_1v1_im : signed(bit_width_adder+1 downto 0);
    
    -- 7. Zeile, Stufe 3
    -- Real
    variable sum6_stage3_1v1_re : signed(bit_width_adder+1 downto 0);
    -- Imag
    variable sum6_stage3_1v1_im : signed(bit_width_adder+1 downto 0);
    
    --Stufe 5
    -- Real
    variable sum7_stage4_1v1_re     : signed(bit_width_adder+1 downto 0);
    -- Imag
    variable sum7_stage4_1v1_im     : signed(bit_width_adder+1 downto 0);
    
    

  
  begin
    W_row := to_integer(element(5 downto 3));  -- Twiddlefaktor-Matrix
    I_col := to_integer(element(2 downto 0));  -- Input-Matrix
    
    element_out <= element;
    
    case multState is

      when additions_stage1 =>
        case W_row is
          -- 1. Zeile aus W -> nur Additionen
          when 0 =>
            if dft_1d_2d = '0' then
              -- Real
              sum0_stage1_1v4_re <= resize(input_real(0)(I_col), bit_width_adder) + resize(input_real(1)(I_col), bit_width_adder);
              sum0_stage1_2v4_re <= resize(input_real(2)(I_col), bit_width_adder) + resize(input_real(3)(I_col), bit_width_adder);
              sum0_stage1_3v4_re <= resize(input_real(4)(I_col), bit_width_adder) + resize(input_real(5)(I_col), bit_width_adder);
              sum0_stage1_4v4_re <= resize(input_real(6)(I_col), bit_width_adder) + resize(input_real(7)(I_col), bit_width_adder);
              -- Imag
              sum0_stage1_1v4_im <= resize(input_imag(0)(I_col), bit_width_adder) + resize(input_imag(1)(I_col), bit_width_adder);
              sum0_stage1_2v4_im <= resize(input_imag(2)(I_col), bit_width_adder) + resize(input_imag(3)(I_col), bit_width_adder);
              sum0_stage1_3v4_im <= resize(input_imag(4)(I_col), bit_width_adder) + resize(input_imag(5)(I_col), bit_width_adder);
              sum0_stage1_4v4_im <= resize(input_imag(6)(I_col), bit_width_adder) + resize(input_imag(7)(I_col), bit_width_adder);
            else
              -- Real
              sum0_stage1_1v4_re <= resize(dft_1d_real(0)(I_col), bit_width_adder) + resize(dft_1d_real(1)(I_col), bit_width_adder);
              sum0_stage1_2v4_re <= resize(dft_1d_real(2)(I_col), bit_width_adder) + resize(dft_1d_real(3)(I_col), bit_width_adder);
              sum0_stage1_3v4_re <= resize(dft_1d_real(4)(I_col), bit_width_adder) + resize(dft_1d_real(5)(I_col), bit_width_adder);
              sum0_stage1_4v4_re <= resize(dft_1d_real(6)(I_col), bit_width_adder) + resize(dft_1d_real(7)(I_col), bit_width_adder);
              -- Imag
              sum0_stage1_1v4_im <= resize(dft_1d_imag(0)(I_col), bit_width_adder) + resize(dft_1d_imag(1)(I_col), bit_width_adder);
              sum0_stage1_2v4_im <= resize(dft_1d_imag(2)(I_col), bit_width_adder) + resize(dft_1d_imag(3)(I_col), bit_width_adder);
              sum0_stage1_3v4_im <= resize(dft_1d_imag(4)(I_col), bit_width_adder) + resize(dft_1d_imag(5)(I_col), bit_width_adder);
              sum0_stage1_4v4_im <= resize(dft_1d_imag(6)(I_col), bit_width_adder) + resize(dft_1d_imag(7)(I_col), bit_width_adder);
            end if;
            
          -- 2. Zeile aus W
          when 1 =>
            if dft_1d_2d = '0' then
              -- Real
              sum1_stage1_1v6_re <= resize(input_real(0)(I_col), bit_width_adder) - resize(input_imag(2)(I_col), bit_width_adder);
              sum1_stage1_2v6_re <= resize(input_imag(6)(I_col), bit_width_adder) - resize(input_real(4)(I_col), bit_width_adder);
              -- MultPart
              sum1_stage1_3v6_re <= resize(input_real(1)(I_col), bit_width_adder) - resize(input_imag(1)(I_col), bit_width_adder);
              sum1_stage1_4v6_re <= resize(input_imag(5)(I_col), bit_width_adder) - resize(input_real(3)(I_col), bit_width_adder);
              sum1_stage1_5v6_re <= resize(input_real(7)(I_col), bit_width_adder) - resize(input_imag(3)(I_col), bit_width_adder);
              sum1_stage1_6v6_re <= resize(input_imag(7)(I_col), bit_width_adder) - resize(input_real(5)(I_col), bit_width_adder);
              -- Imag
              sum1_stage1_1v6_im <= resize(input_imag(0)(I_col), bit_width_adder) - resize(input_imag(4)(I_col), bit_width_adder);
              sum1_stage1_2v6_im <= resize(input_real(2)(I_col), bit_width_adder) - resize(input_real(6)(I_col), bit_width_adder);
              -- MultPart
              sum1_stage1_3v6_im <= resize(input_real(1)(I_col), bit_width_adder) - resize(input_imag(3)(I_col), bit_width_adder);
              sum1_stage1_4v6_im <= resize(input_imag(1)(I_col), bit_width_adder) - resize(input_real(5)(I_col), bit_width_adder);
              sum1_stage1_5v6_im <= resize(input_real(3)(I_col), bit_width_adder) - resize(input_imag(5)(I_col), bit_width_adder);
              sum1_stage1_6v6_im <= resize(input_imag(7)(I_col), bit_width_adder) - resize(input_real(7)(I_col), bit_width_adder);
            else
              -- Real
              sum1_stage1_1v6_re <= resize(dft_1d_real(0)(I_col), bit_width_adder) - resize(dft_1d_imag(2)(I_col), bit_width_adder);
              sum1_stage1_2v6_re <= resize(dft_1d_imag(6)(I_col), bit_width_adder) - resize(dft_1d_real(4)(I_col), bit_width_adder);
              -- MultPart
              sum1_stage1_3v6_re <= resize(dft_1d_real(1)(I_col), bit_width_adder) - resize(dft_1d_imag(1)(I_col), bit_width_adder);
              sum1_stage1_4v6_re <= resize(dft_1d_imag(5)(I_col), bit_width_adder) - resize(dft_1d_real(3)(I_col), bit_width_adder);
              sum1_stage1_5v6_re <= resize(dft_1d_real(7)(I_col), bit_width_adder) - resize(dft_1d_imag(3)(I_col), bit_width_adder);
              sum1_stage1_6v6_re <= resize(dft_1d_imag(7)(I_col), bit_width_adder) - resize(dft_1d_real(5)(I_col), bit_width_adder);
              -- Imag
              sum1_stage1_1v6_im <= resize(dft_1d_imag(0)(I_col), bit_width_adder) - resize(dft_1d_imag(4)(I_col), bit_width_adder);
              sum1_stage1_2v6_im <= resize(dft_1d_real(2)(I_col), bit_width_adder) - resize(dft_1d_real(6)(I_col), bit_width_adder);
              -- MultPart
              sum1_stage1_3v6_im <= resize(dft_1d_real(1)(I_col), bit_width_adder) - resize(dft_1d_imag(3)(I_col), bit_width_adder);
              sum1_stage1_4v6_im <= resize(dft_1d_imag(1)(I_col), bit_width_adder) - resize(dft_1d_real(5)(I_col), bit_width_adder);
              sum1_stage1_5v6_im <= resize(dft_1d_real(3)(I_col), bit_width_adder) - resize(dft_1d_imag(5)(I_col), bit_width_adder);
              sum1_stage1_6v6_im <= resize(dft_1d_imag(7)(I_col), bit_width_adder) - resize(dft_1d_real(7)(I_col), bit_width_adder);
            end if;
            
            
            
          -- 3. Zeile aus W
          when 2 =>
            if dft_1d_2d = '0' then
              -- Real
              sum2_stage1_1v4_re <= resize(input_real(0)(I_col), bit_width_adder) - resize(input_imag(1)(I_col), bit_width_adder);
              sum2_stage1_2v4_re <= resize(input_imag(3)(I_col), bit_width_adder) - resize(input_real(2)(I_col), bit_width_adder);
              sum2_stage1_3v4_re <= resize(input_real(4)(I_col), bit_width_adder) - resize(input_imag(5)(I_col), bit_width_adder);
              sum2_stage1_4v4_re <= resize(input_imag(7)(I_col), bit_width_adder) - resize(input_real(6)(I_col), bit_width_adder);
              --Imag
              sum2_stage1_1v4_im <= resize(input_imag(0)(I_col), bit_width_adder) - resize(input_imag(2)(I_col), bit_width_adder);
              sum2_stage1_2v4_im <= resize(input_real(1)(I_col), bit_width_adder) - resize(input_real(3)(I_col), bit_width_adder);
              sum2_stage1_3v4_im <= resize(input_imag(4)(I_col), bit_width_adder) - resize(input_imag(6)(I_col), bit_width_adder);
              sum2_stage1_4v4_im <= resize(input_real(5)(I_col), bit_width_adder) - resize(input_real(7)(I_col), bit_width_adder);
            else
              -- Real
              sum2_stage1_1v4_re <= resize(dft_1d_real(0)(I_col), bit_width_adder) - resize(dft_1d_imag(1)(I_col), bit_width_adder);
              sum2_stage1_2v4_re <= resize(dft_1d_imag(3)(I_col), bit_width_adder) - resize(dft_1d_real(2)(I_col), bit_width_adder);
              sum2_stage1_3v4_re <= resize(dft_1d_real(4)(I_col), bit_width_adder) - resize(dft_1d_imag(5)(I_col), bit_width_adder);
              sum2_stage1_4v4_re <= resize(dft_1d_imag(7)(I_col), bit_width_adder) - resize(dft_1d_real(6)(I_col), bit_width_adder);
              --Imag
              sum2_stage1_1v4_im <= resize(dft_1d_imag(0)(I_col), bit_width_adder) - resize(dft_1d_imag(2)(I_col), bit_width_adder);
              sum2_stage1_2v4_im <= resize(dft_1d_real(1)(I_col), bit_width_adder) - resize(dft_1d_real(3)(I_col), bit_width_adder);
              sum2_stage1_3v4_im <= resize(dft_1d_imag(4)(I_col), bit_width_adder) - resize(dft_1d_imag(6)(I_col), bit_width_adder);
              sum2_stage1_4v4_im <= resize(dft_1d_real(5)(I_col), bit_width_adder) - resize(dft_1d_real(7)(I_col), bit_width_adder);
            end if;
            
            -- 4. Zeile aus W
            
          when 3 =>
            if dft_1d_2d = '0' then
              -- Real
              sum3_stage1_1v6_re <= resize(input_real(0)(I_col), bit_width_adder) - resize(input_real(4)(I_col), bit_width_adder);
              sum3_stage1_2v6_re <= resize(input_imag(2)(I_col), bit_width_adder) - resize(input_imag(6)(I_col), bit_width_adder);
              --MultPart
              sum3_stage1_3v6_re <= resize(input_real(3)(I_col), bit_width_adder) - resize(input_real(1)(I_col), bit_width_adder);
              sum3_stage1_4v6_re <= resize(input_real(5)(I_col), bit_width_adder) - resize(input_imag(1)(I_col), bit_width_adder);
              sum3_stage1_5v6_re <= resize(input_imag(5)(I_col), bit_width_adder) - resize(input_imag(3)(I_col), bit_width_adder);
              sum3_stage1_6v6_re <= resize(input_imag(7)(I_col), bit_width_adder) - resize(input_real(7)(I_col), bit_width_adder);
              -- Imag
              sum3_stage1_1v6_im <= resize(input_imag(0)(I_col), bit_width_adder) - resize(input_real(2)(I_col), bit_width_adder);
              sum3_stage1_2v6_im <= resize(input_real(6)(I_col), bit_width_adder) - resize(input_imag(4)(I_col), bit_width_adder);
              --MultPart
              sum3_stage1_3v6_im <= resize(input_real(1)(I_col), bit_width_adder) - resize(input_imag(1)(I_col), bit_width_adder);
              sum3_stage1_4v6_im <= resize(input_imag(3)(I_col), bit_width_adder) - resize(input_real(5)(I_col), bit_width_adder);
              sum3_stage1_5v6_im <= resize(input_real(3)(I_col), bit_width_adder) - resize(input_real(7)(I_col), bit_width_adder);
              sum3_stage1_6v6_im <= resize(input_imag(5)(I_col), bit_width_adder) - resize(input_imag(7)(I_col), bit_width_adder);
            else
              sum3_stage1_1v6_re <= resize(dft_1d_real(0)(I_col), bit_width_adder) - resize(dft_1d_real(4)(I_col), bit_width_adder);
              sum3_stage1_2v6_re <= resize(dft_1d_imag(2)(I_col), bit_width_adder) - resize(dft_1d_imag(6)(I_col), bit_width_adder);
              --MultPart
              sum3_stage1_3v6_re <= resize(dft_1d_real(3)(I_col), bit_width_adder) - resize(dft_1d_real(1)(I_col), bit_width_adder);
              sum3_stage1_4v6_re <= resize(dft_1d_real(5)(I_col), bit_width_adder) - resize(dft_1d_imag(1)(I_col), bit_width_adder);
              sum3_stage1_5v6_re <= resize(dft_1d_imag(5)(I_col), bit_width_adder) - resize(dft_1d_imag(3)(I_col), bit_width_adder);
              sum3_stage1_6v6_re <= resize(dft_1d_imag(7)(I_col), bit_width_adder) - resize(dft_1d_real(7)(I_col), bit_width_adder);
              -- Imag
              sum3_stage1_1v6_im <= resize(dft_1d_imag(0)(I_col), bit_width_adder) - resize(dft_1d_real(2)(I_col), bit_width_adder);
              sum3_stage1_2v6_im <= resize(dft_1d_real(6)(I_col), bit_width_adder) - resize(dft_1d_imag(4)(I_col), bit_width_adder);
              --MultPart
              sum3_stage1_3v6_im <= resize(dft_1d_real(1)(I_col), bit_width_adder) - resize(dft_1d_imag(1)(I_col), bit_width_adder);
              sum3_stage1_4v6_im <= resize(dft_1d_imag(3)(I_col), bit_width_adder) - resize(dft_1d_real(5)(I_col), bit_width_adder);
              sum3_stage1_5v6_im <= resize(dft_1d_real(3)(I_col), bit_width_adder) - resize(dft_1d_real(7)(I_col), bit_width_adder);
              sum3_stage1_6v6_im <= resize(dft_1d_imag(5)(I_col), bit_width_adder) - resize(dft_1d_imag(7)(I_col), bit_width_adder);
            end if;
            
          -- 5. Zeile  
          when 4 =>
            if dft_1d_2d = '0' then
              -- Real
              sum4_stage1_1v4_re <= resize(input_real(0)(I_col), bit_width_adder) - resize(input_real(1)(I_col), bit_width_adder);
              sum4_stage1_2v4_re <= resize(input_real(2)(I_col), bit_width_adder) - resize(input_real(3)(I_col), bit_width_adder);
              sum4_stage1_3v4_re <= resize(input_real(4)(I_col), bit_width_adder) - resize(input_real(5)(I_col), bit_width_adder);
              sum4_stage1_4v4_re <= resize(input_real(6)(I_col), bit_width_adder) - resize(input_real(7)(I_col), bit_width_adder);
              -- Imag
              sum4_stage1_1v4_im <= resize(input_imag(0)(I_col), bit_width_adder) - resize(input_imag(1)(I_col), bit_width_adder);
              sum4_stage1_2v4_im <= resize(input_imag(2)(I_col), bit_width_adder) - resize(input_imag(3)(I_col), bit_width_adder);
              sum4_stage1_3v4_im <= resize(input_imag(4)(I_col), bit_width_adder) - resize(input_imag(5)(I_col), bit_width_adder);
              sum4_stage1_4v4_im <= resize(input_imag(6)(I_col), bit_width_adder) - resize(input_imag(7)(I_col), bit_width_adder);
            else
              sum4_stage1_1v4_re <= resize(dft_1d_real(0)(I_col), bit_width_adder) - resize(dft_1d_real(1)(I_col), bit_width_adder);
              sum4_stage1_2v4_re <= resize(dft_1d_real(2)(I_col), bit_width_adder) - resize(dft_1d_real(3)(I_col), bit_width_adder);
              sum4_stage1_3v4_re <= resize(dft_1d_real(4)(I_col), bit_width_adder) - resize(dft_1d_real(5)(I_col), bit_width_adder);
              sum4_stage1_4v4_re <= resize(dft_1d_real(6)(I_col), bit_width_adder) - resize(dft_1d_real(7)(I_col), bit_width_adder);
              -- Imag
              sum4_stage1_1v4_im <= resize(dft_1d_imag(0)(I_col), bit_width_adder) - resize(dft_1d_imag(1)(I_col), bit_width_adder);
              sum4_stage1_2v4_im <= resize(dft_1d_imag(2)(I_col), bit_width_adder) - resize(dft_1d_imag(3)(I_col), bit_width_adder);
              sum4_stage1_3v4_im <= resize(dft_1d_imag(4)(I_col), bit_width_adder) - resize(dft_1d_imag(5)(I_col), bit_width_adder);
              sum4_stage1_4v4_im <= resize(dft_1d_imag(6)(I_col), bit_width_adder) - resize(dft_1d_imag(7)(I_col), bit_width_adder);
            end if;
            
          -- 6. Zeile  
          when 5 =>
            if dft_1d_2d = '0' then
              -- Real
              sum5_stage1_1v6_re <= resize(input_real(0)(I_col), bit_width_adder) - resize(input_imag(2)(I_col), bit_width_adder);
              sum5_stage1_2v6_re <= resize(input_imag(6)(I_col), bit_width_adder) - resize(input_real(4)(I_col), bit_width_adder);
              --MultPart
              sum5_stage1_3v6_re <= resize(input_imag(1)(I_col), bit_width_adder) - resize(input_real(1)(I_col), bit_width_adder);
              sum5_stage1_4v6_re <= resize(input_real(3)(I_col), bit_width_adder) - resize(input_imag(5)(I_col), bit_width_adder);
              sum5_stage1_5v6_re <= resize(input_imag(3)(I_col), bit_width_adder) - resize(input_real(7)(I_col), bit_width_adder);
              sum5_stage1_6v6_re <= resize(input_real(5)(I_col), bit_width_adder) - resize(input_imag(7)(I_col), bit_width_adder);
              -- Imag
              sum5_stage1_1v6_im <= resize(input_imag(0)(I_col), bit_width_adder) - resize(input_imag(4)(I_col), bit_width_adder);
              sum5_stage1_2v6_im <= resize(input_real(2)(I_col), bit_width_adder) - resize(input_real(6)(I_col), bit_width_adder);
              --MultPart
              sum5_stage1_3v6_im <= resize(input_imag(3)(I_col), bit_width_adder) - resize(input_real(1)(I_col), bit_width_adder);
              sum5_stage1_4v6_im <= resize(input_real(5)(I_col), bit_width_adder) - resize(input_imag(1)(I_col), bit_width_adder);
              sum5_stage1_5v6_im <= resize(input_imag(5)(I_col), bit_width_adder) - resize(input_real(3)(I_col), bit_width_adder);
              sum5_stage1_6v6_im <= resize(input_real(7)(I_col), bit_width_adder) - resize(input_imag(7)(I_col), bit_width_adder);
            else
              -- Real
              sum5_stage1_1v6_re <= resize(dft_1d_real(0)(I_col), bit_width_adder) - resize(dft_1d_imag(2)(I_col), bit_width_adder);
              sum5_stage1_2v6_re <= resize(dft_1d_imag(6)(I_col), bit_width_adder) - resize(dft_1d_real(4)(I_col), bit_width_adder);
              --MultPart
              sum5_stage1_3v6_re <= resize(dft_1d_imag(1)(I_col), bit_width_adder) - resize(dft_1d_real(1)(I_col), bit_width_adder);
              sum5_stage1_4v6_re <= resize(dft_1d_real(3)(I_col), bit_width_adder) - resize(dft_1d_imag(5)(I_col), bit_width_adder);
              sum5_stage1_5v6_re <= resize(dft_1d_imag(3)(I_col), bit_width_adder) - resize(dft_1d_real(7)(I_col), bit_width_adder);
              sum5_stage1_6v6_re <= resize(dft_1d_real(5)(I_col), bit_width_adder) - resize(dft_1d_imag(7)(I_col), bit_width_adder);
              -- Imag
              sum5_stage1_1v6_im <= resize(dft_1d_imag(0)(I_col), bit_width_adder) - resize(dft_1d_imag(4)(I_col), bit_width_adder);
              sum5_stage1_2v6_im <= resize(dft_1d_real(2)(I_col), bit_width_adder) - resize(dft_1d_real(6)(I_col), bit_width_adder);
              --MultPart
              sum5_stage1_3v6_im <= resize(dft_1d_imag(3)(I_col), bit_width_adder) - resize(dft_1d_real(1)(I_col), bit_width_adder);
              sum5_stage1_4v6_im <= resize(dft_1d_real(5)(I_col), bit_width_adder) - resize(dft_1d_imag(1)(I_col), bit_width_adder);
              sum5_stage1_5v6_im <= resize(dft_1d_imag(5)(I_col), bit_width_adder) - resize(dft_1d_real(3)(I_col), bit_width_adder);
              sum5_stage1_6v6_im <= resize(dft_1d_real(7)(I_col), bit_width_adder) - resize(dft_1d_imag(7)(I_col), bit_width_adder);            
            end if;
            
          -- 7. Zeile
          when 6 =>
            if dft_1d_2d = '0' then
              -- Real
              sum6_stage1_1v4_re <= resize(input_real(0)(I_col), bit_width_adder) - resize(input_real(2)(I_col), bit_width_adder);
              sum6_stage1_2v4_re <= resize(input_imag(1)(I_col), bit_width_adder) - resize(input_imag(3)(I_col), bit_width_adder);
              sum6_stage1_3v4_re <= resize(input_real(4)(I_col), bit_width_adder) - resize(input_real(6)(I_col), bit_width_adder);
              sum6_stage1_4v4_re <= resize(input_imag(5)(I_col), bit_width_adder) - resize(input_imag(7)(I_col), bit_width_adder);
              -- Imag
              sum6_stage1_1v4_im <= resize(input_imag(0)(I_col), bit_width_adder) - resize(input_real(1)(I_col), bit_width_adder);
              sum6_stage1_2v4_im <= resize(input_real(3)(I_col), bit_width_adder) - resize(input_imag(2)(I_col), bit_width_adder);
              sum6_stage1_3v4_im <= resize(input_imag(4)(I_col), bit_width_adder) - resize(input_real(5)(I_col), bit_width_adder);
              sum6_stage1_4v4_im <= resize(input_real(7)(I_col), bit_width_adder) - resize(input_imag(6)(I_col), bit_width_adder);
            else
              -- Real
              sum6_stage1_1v4_re <= resize(dft_1d_real(0)(I_col), bit_width_adder) - resize(dft_1d_real(2)(I_col), bit_width_adder);
              sum6_stage1_2v4_re <= resize(dft_1d_imag(1)(I_col), bit_width_adder) - resize(dft_1d_imag(3)(I_col), bit_width_adder);
              sum6_stage1_3v4_re <= resize(dft_1d_real(4)(I_col), bit_width_adder) - resize(dft_1d_real(6)(I_col), bit_width_adder);
              sum6_stage1_4v4_re <= resize(dft_1d_imag(5)(I_col), bit_width_adder) - resize(dft_1d_imag(7)(I_col), bit_width_adder);
              -- Imag
              sum6_stage1_1v4_im <= resize(dft_1d_imag(0)(I_col), bit_width_adder) - resize(dft_1d_real(1)(I_col), bit_width_adder);
              sum6_stage1_2v4_im <= resize(dft_1d_real(3)(I_col), bit_width_adder) - resize(dft_1d_imag(2)(I_col), bit_width_adder);
              sum6_stage1_3v4_im <= resize(dft_1d_imag(4)(I_col), bit_width_adder) - resize(dft_1d_real(5)(I_col), bit_width_adder);
              sum6_stage1_4v4_im <= resize(dft_1d_real(7)(I_col), bit_width_adder) - resize(dft_1d_imag(6)(I_col), bit_width_adder);
            end if;
            
          -- 8. Zeile  
          when 7 =>
            if dft_1d_2d = '0' then
              -- Real
              sum7_stage1_1v6_re <= resize(input_real(0)(I_col), bit_width_adder) - resize(input_real(4)(I_col), bit_width_adder);
              sum7_stage1_2v6_re <= resize(input_imag(2)(I_col), bit_width_adder) - resize(input_imag(6)(I_col), bit_width_adder);
              --MultPart
              sum7_stage1_3v6_re <= resize(input_real(1)(I_col), bit_width_adder) - resize(input_real(3)(I_col), bit_width_adder);
              sum7_stage1_4v6_re <= resize(input_imag(1)(I_col), bit_width_adder) - resize(input_real(5)(I_col), bit_width_adder);
              sum7_stage1_5v6_re <= resize(input_imag(3)(I_col), bit_width_adder) - resize(input_imag(5)(I_col), bit_width_adder);
              sum7_stage1_6v6_re <= resize(input_real(7)(I_col), bit_width_adder) - resize(input_imag(7)(I_col), bit_width_adder);
              -- Imag
              sum7_stage1_1v6_im <= resize(input_imag(0)(I_col), bit_width_adder) - resize(input_real(2)(I_col), bit_width_adder);
              sum7_stage1_2v6_im <= resize(input_real(6)(I_col), bit_width_adder) - resize(input_imag(4)(I_col), bit_width_adder);
              --MultPart
              sum7_stage1_3v6_im <= resize(input_imag(1)(I_col), bit_width_adder) - resize(input_real(1)(I_col), bit_width_adder);
              sum7_stage1_4v6_im <= resize(input_real(5)(I_col), bit_width_adder) - resize(input_real(3)(I_col), bit_width_adder);
              sum7_stage1_5v6_im <= resize(input_real(7)(I_col), bit_width_adder) - resize(input_imag(3)(I_col), bit_width_adder);
              sum7_stage1_6v6_im <= resize(input_imag(7)(I_col), bit_width_adder) - resize(input_imag(5)(I_col), bit_width_adder);
            else
              sum7_stage1_1v6_re <= resize(dft_1d_real(0)(I_col), bit_width_adder) - resize(dft_1d_real(4)(I_col), bit_width_adder);
              sum7_stage1_2v6_re <= resize(dft_1d_imag(2)(I_col), bit_width_adder) - resize(dft_1d_imag(6)(I_col), bit_width_adder);
              --MultPart
              sum7_stage1_3v6_re <= resize(dft_1d_real(1)(I_col), bit_width_adder) - resize(dft_1d_real(3)(I_col), bit_width_adder);
              sum7_stage1_4v6_re <= resize(dft_1d_imag(1)(I_col), bit_width_adder) - resize(dft_1d_real(5)(I_col), bit_width_adder);
              sum7_stage1_5v6_re <= resize(dft_1d_imag(3)(I_col), bit_width_adder) - resize(dft_1d_imag(5)(I_col), bit_width_adder);
              sum7_stage1_6v6_re <= resize(dft_1d_real(7)(I_col), bit_width_adder) - resize(dft_1d_imag(7)(I_col), bit_width_adder);
              -- Imag
              sum7_stage1_1v6_im <= resize(dft_1d_imag(0)(I_col), bit_width_adder) - resize(dft_1d_real(2)(I_col), bit_width_adder);
              sum7_stage1_2v6_im <= resize(dft_1d_real(6)(I_col), bit_width_adder) - resize(dft_1d_imag(4)(I_col), bit_width_adder);
              --MultPart
              sum7_stage1_3v6_im <= resize(dft_1d_imag(1)(I_col), bit_width_adder) - resize(dft_1d_real(1)(I_col), bit_width_adder);
              sum7_stage1_4v6_im <= resize(dft_1d_real(5)(I_col), bit_width_adder) - resize(dft_1d_real(3)(I_col), bit_width_adder);
              sum7_stage1_5v6_im <= resize(dft_1d_real(7)(I_col), bit_width_adder) - resize(dft_1d_imag(3)(I_col), bit_width_adder);
              sum7_stage1_6v6_im <= resize(dft_1d_imag(7)(I_col), bit_width_adder) - resize(dft_1d_imag(5)(I_col), bit_width_adder);
            end if;
          when others => element <= element;
        end case;  
        
        nextMultState <= additions_stage2;  
        
    
      when additions_stage2 =>
          
        case W_row is
          when 0 =>
            -- 1. Zeile aus W aufsummieren
            -- Real
            sum0_stage2_1v2_re <= resize(sum0_stage1_1v4_re, bit_width_adder+1) + resize(sum0_stage1_2v4_re, bit_width_adder+1);
            sum0_stage2_2v2_re <= resize(sum0_stage1_3v4_re, bit_width_adder+1) + resize(sum0_stage1_4v4_re, bit_width_adder+1);
            -- Imag
            sum0_stage2_1v2_im <= resize(sum0_stage1_1v4_im, bit_width_adder+1) + resize(sum0_stage1_2v4_im, bit_width_adder+1);
            sum0_stage2_2v2_im <= resize(sum0_stage1_3v4_im, bit_width_adder+1) + resize(sum0_stage1_4v4_im, bit_width_adder+1);
            
          when 1 =>
            -- 2. Zeile aus W
            -- Real
            sum1_stage2_1v3_re <= resize(sum1_stage1_1v6_re, bit_width_adder+1) + resize(sum1_stage1_2v6_re, bit_width_adder+1);
            --MultPart
            sum1_stage2_2v3_re <= resize(sum1_stage1_3v6_re, bit_width_adder+1) + resize(sum1_stage1_4v6_re, bit_width_adder+1);
            sum1_stage2_3v3_re <= resize(sum1_stage1_5v6_re, bit_width_adder+1) + resize(sum1_stage1_6v6_re, bit_width_adder+1);
            -- Imag
            sum1_stage2_1v3_im <= resize(sum1_stage1_1v6_im, bit_width_adder+1) + resize(sum1_stage1_2v6_im, bit_width_adder+1);
            --MultPart
            sum1_stage2_2v3_im <= resize(sum1_stage1_3v6_im, bit_width_adder+1) + resize(sum1_stage1_4v6_im, bit_width_adder+1);
            sum1_stage2_3v3_im <= resize(sum1_stage1_5v6_im, bit_width_adder+1) + resize(sum1_stage1_6v6_im, bit_width_adder+1);
            
            -- 3. Zeile aus W
            -- Real
          when 2 =>
            sum2_stage2_1v2_re <= resize(sum2_stage1_1v4_re, bit_width_adder+1) + resize(sum2_stage1_2v4_re, bit_width_adder+1);
            sum2_stage2_2v2_re <= resize(sum2_stage1_3v4_re, bit_width_adder+1) + resize(sum2_stage1_4v4_re, bit_width_adder+1);
            -- Imag
            sum2_stage2_1v2_im <= resize(sum2_stage1_1v4_im, bit_width_adder+1) + resize(sum2_stage1_2v4_im, bit_width_adder+1);
            sum2_stage2_2v2_im <= resize(sum2_stage1_3v4_im, bit_width_adder+1) + resize(sum2_stage1_4v4_im, bit_width_adder+1);
            
            -- 4. Zeile aus W
            -- Real
          when 3 =>
            sum3_stage2_1v3_re <= resize(sum3_stage1_1v6_re, bit_width_adder+1) + resize(sum3_stage1_2v6_re, bit_width_adder+1);
            --MultPart
            sum3_stage2_2v3_re <= resize(sum3_stage1_3v6_re, bit_width_adder+1) + resize(sum3_stage1_4v6_re, bit_width_adder+1);
            sum3_stage2_3v3_re <= resize(sum3_stage1_5v6_re, bit_width_adder+1) + resize(sum3_stage1_6v6_re, bit_width_adder+1);
            
            -- Imag
            sum3_stage2_1v3_im <= resize(sum3_stage1_1v6_im, bit_width_adder+1) + resize(sum3_stage1_2v6_im, bit_width_adder+1);
            --MultPart
            sum3_stage2_2v3_im <= resize(sum3_stage1_3v6_im, bit_width_adder+1) + resize(sum3_stage1_4v6_im, bit_width_adder+1);
            sum3_stage2_3v3_im <= resize(sum3_stage1_5v6_im, bit_width_adder+1) + resize(sum3_stage1_6v6_im, bit_width_adder+1);
                        
            -- 5. Zeile
            -- Real
          when 4 =>
            sum4_stage2_1v2_re <= resize(sum4_stage1_1v4_re, bit_width_adder+1) + resize(sum4_stage1_2v4_re, bit_width_adder+1);
            sum4_stage2_2v2_re <= resize(sum4_stage1_3v4_re, bit_width_adder+1) + resize(sum4_stage1_4v4_re, bit_width_adder+1);
            -- Imag
            sum4_stage2_1v2_im <= resize(sum4_stage1_1v4_im, bit_width_adder+1) + resize(sum4_stage1_2v4_im, bit_width_adder+1);
            sum4_stage2_2v2_im <= resize(sum4_stage1_3v4_im, bit_width_adder+1) + resize(sum4_stage1_4v4_im, bit_width_adder+1);
            
            -- 6. Zeile
            -- Real
          when 5 =>
            sum5_stage2_1v3_re <= resize(sum5_stage1_1v6_re, bit_width_adder+1) + resize(sum5_stage1_2v6_re, bit_width_adder+1);
            --MultPart
            sum5_stage2_2v3_re <= resize(sum5_stage1_3v6_re, bit_width_adder+1) + resize(sum5_stage1_4v6_re, bit_width_adder+1);
            sum5_stage2_3v3_re <= resize(sum5_stage1_5v6_re, bit_width_adder+1) + resize(sum5_stage1_6v6_re, bit_width_adder+1);
            -- Imag
            sum5_stage2_1v3_im <= resize(sum5_stage1_1v6_im, bit_width_adder+1) + resize(sum5_stage1_2v6_im, bit_width_adder+1);
            --MultPart
            sum5_stage2_2v3_im <= resize(sum5_stage1_3v6_im, bit_width_adder+1) + resize(sum5_stage1_4v6_im, bit_width_adder+1);
            sum5_stage2_3v3_im <= resize(sum5_stage1_5v6_im, bit_width_adder+1) + resize(sum5_stage1_6v6_im, bit_width_adder+1);
            
            -- 7. Zeile
            -- Real
          when 6 =>
            sum6_stage2_1v2_re <= resize(sum6_stage1_1v4_re, bit_width_adder+1) + resize(sum6_stage1_2v4_re, bit_width_adder+1);
            sum6_stage2_2v2_re <= resize(sum6_stage1_3v4_re, bit_width_adder+1) + resize(sum6_stage1_4v4_re, bit_width_adder+1);
            -- Imag
            sum6_stage2_1v2_im <= resize(sum6_stage1_1v4_im, bit_width_adder+1) + resize(sum6_stage1_2v4_im, bit_width_adder+1);
            sum6_stage2_2v2_im <= resize(sum6_stage1_3v4_im, bit_width_adder+1) + resize(sum6_stage1_4v4_im, bit_width_adder+1);
            
            -- 8. Zeile
            -- Real
          when 7 =>
            sum7_stage2_1v3_re <= resize(sum7_stage1_1v6_re, bit_width_adder+1) + resize(sum7_stage1_2v6_re, bit_width_adder+1);
            --MultPart
            sum7_stage2_2v3_re <= resize(sum7_stage1_3v6_re, bit_width_adder+1) + resize(sum7_stage1_4v6_re, bit_width_adder+1);
            sum7_stage2_3v3_re <= resize(sum7_stage1_5v6_re, bit_width_adder+1) + resize(sum7_stage1_6v6_re, bit_width_adder+1);
            -- Imag
            sum7_stage2_1v3_im <= resize(sum7_stage1_1v6_im, bit_width_adder+1) + resize(sum7_stage1_2v6_im, bit_width_adder+1);
            --MultPart
            --2_6 und 3_6 vertauscht
            sum7_stage2_2v3_im <= resize(sum7_stage1_3v6_im, bit_width_adder+1) + resize(sum7_stage1_5v6_im, bit_width_adder+1);
            sum7_stage2_3v3_im <= resize(sum7_stage1_4v6_im, bit_width_adder+1) + resize(sum7_stage1_6v6_im, bit_width_adder+1);
            
          when others => element <= element;
        end case;

        nextMultState <= additions_stage3;
        
        
when additions_stage3 =>
        case W_row is
          -- 1. Zeile aus W
          when 0 =>
              -- Real
              sum0_stage3_1v1_re := resize(sum0_stage2_1v2_re, bit_width_adder+2) + resize(sum0_stage2_2v2_re, bit_width_adder+2);
              -- Imag
              sum0_stage3_1v1_im := resize(sum0_stage2_1v2_im, bit_width_adder+2) + resize(sum0_stage2_2v2_im, bit_width_adder+2);
              
              if dft_1d_2d = '0' then
                dft_1d_real(I_col)(0) <= sum0_stage3_1v1_re(bit_width_extern-1 downto 0);
                dft_1d_imag(I_col)(0) <= sum0_stage3_1v1_im(bit_width_extern-1 downto 0);
              else
                result_real(I_col)(0) <= sum0_stage3_1v1_re(bit_width_extern-1 downto 0);
                result_imag(I_col)(0) <= sum0_stage3_1v1_im(bit_width_extern-1 downto 0);
              end if;
              
          -- 2. Zeile aus W
          when 1 =>
              -- Real
              sum1_stage3_1v1_re <= resize(sum1_stage2_2v3_re, bit_width_adder+2) + resize(sum1_stage2_3v3_re, bit_width_adder+2);    
              -- Imag
              sum1_stage3_1v1_im <= resize(sum1_stage2_2v3_im, bit_width_adder+2) + resize(sum1_stage2_3v3_im, bit_width_adder+2);
                
          -- 3. Zeile aus W
          when 2 =>
              -- Real
              sum2_stage3_1v1_re := resize(sum2_stage2_1v2_re, bit_width_adder+2) + resize(sum2_stage2_2v2_re, bit_width_adder+2);
              -- Imag
              sum2_stage3_1v1_im := resize(sum2_stage2_1v2_im, bit_width_adder+2) + resize(sum2_stage2_2v2_im, bit_width_adder+2);
              
              if dft_1d_2d = '0' then
                dft_1d_real(I_col)(2) <= sum2_stage3_1v1_re(bit_width_extern-1 downto 0);
                dft_1d_imag(I_col)(2) <= sum2_stage3_1v1_im(bit_width_extern-1 downto 0);
              else
                result_real(I_col)(2) <= sum2_stage3_1v1_re(bit_width_extern-1 downto 0);
                result_imag(I_col)(2) <= sum2_stage3_1v1_im(bit_width_extern-1 downto 0);
              end if;
              
          -- 4. Zeile aus W
          when 3 =>
              -- Real
              sum3_stage3_1v1_re <= resize(sum3_stage2_2v3_re, bit_width_adder+2) + resize(sum3_stage2_3v3_re, bit_width_adder+2);
              -- Imag
              sum3_stage3_1v1_im <= resize(sum3_stage2_2v3_im, bit_width_adder+2) + resize(sum3_stage2_3v3_im, bit_width_adder+2);
                
          -- 5. Zeile
          when 4 =>
              -- Real
              sum4_stage3_1v1_re := resize(sum4_stage2_1v2_re, bit_width_adder+2) + resize(sum4_stage2_2v2_re, bit_width_adder+2);
              -- Imag
              sum4_stage3_1v1_im := resize(sum4_stage2_1v2_im, bit_width_adder+2) + resize(sum4_stage2_2v2_im, bit_width_adder+2);
              
              if dft_1d_2d = '0' then
                dft_1d_real(I_col)(4) <= sum4_stage3_1v1_re(bit_width_extern-1 downto 0);
                dft_1d_imag(I_col)(4) <= sum4_stage3_1v1_im(bit_width_extern-1 downto 0);
              else
                result_real(I_col)(4) <= sum4_stage3_1v1_re(bit_width_extern-1 downto 0);
                result_imag(I_col)(4) <= sum4_stage3_1v1_im(bit_width_extern-1 downto 0);
              end if;
              
          -- 6. Zeile
          when 5 =>
              -- Real
              sum5_stage3_1v1_re <= resize(sum5_stage2_2v3_re, bit_width_adder+2) + resize(sum5_stage2_3v3_re, bit_width_adder+2);
              -- Imag
              sum5_stage3_1v1_im <= resize(sum5_stage2_2v3_im, bit_width_adder+2) + resize(sum5_stage2_3v3_im, bit_width_adder+2);
                
          -- 7. Zeile
          when 6 =>
              -- Real
              sum6_stage3_1v1_re := resize(sum6_stage2_1v2_re, bit_width_adder+2) + resize(sum6_stage2_2v2_re, bit_width_adder+2);
              -- Imag
              sum6_stage3_1v1_im := resize(sum6_stage2_1v2_im, bit_width_adder+2) + resize(sum6_stage2_2v2_im, bit_width_adder+2);
              
              if dft_1d_2d = '0' then
                dft_1d_real(I_col)(6) <= sum6_stage3_1v1_re(bit_width_extern-1 downto 0);
                dft_1d_imag(I_col)(6) <= sum6_stage3_1v1_im(bit_width_extern-1 downto 0);
              else
                result_real(I_col)(6) <= sum6_stage3_1v1_re(bit_width_extern-1 downto 0);
                result_imag(I_col)(6) <= sum6_stage3_1v1_im(bit_width_extern-1 downto 0);
              end if;
              
          -- 8. Zeile
          when 7 =>
              -- Real
              sum7_stage3_1v1_re <= resize(sum7_stage2_2v3_re, bit_width_adder+2) + resize(sum7_stage2_3v3_re, bit_width_adder+2);
              -- Imag
              sum7_stage3_1v1_im <= resize(sum7_stage2_2v3_im, bit_width_adder+2) + resize(sum7_stage2_3v3_im, bit_width_adder+2);
              

          when others => element <= element;
        end case;
        
        nextMultState <= const_mult;
          
            
      when const_mult =>
        case W_row is
          when 1 =>
              mult_re_temp(0)(I_col) := sum1_stage3_1v1_re * my_constant_pos;  
              mult_im_temp(0)(I_col) := sum1_stage3_1v1_im * my_constant_pos;
                
              mult_re(0)(I_col) <= mult_re_temp(0)(I_col)(bit_width_adder downto 0);
              mult_im(0)(I_col) <= mult_im_temp(0)(I_col)(bit_width_adder downto 0);
                         
          when 3 =>
              mult_re_temp(1)(I_col) := sum3_stage3_1v1_re * my_constant_pos;
              mult_im_temp(1)(I_col) := sum3_stage3_1v1_im * my_constant_pos;
              
              mult_re(1)(I_col) <= mult_re_temp(1)(I_col)(bit_width_adder downto 0);
              mult_im(1)(I_col) <= mult_im_temp(1)(I_col)(bit_width_adder downto 0);
 
          when 5 =>
              mult_re_temp(2)(I_col) := sum5_stage3_1v1_re * my_constant_pos;
              mult_im_temp(2)(I_col) := sum5_stage3_1v1_im * my_constant_pos;
                
              mult_re(2)(I_col) <= mult_re_temp(2)(I_col)(bit_width_adder downto 0);
              mult_im(2)(I_col) <= mult_im_temp(2)(I_col)(bit_width_adder downto 0);
                
          when 7 =>
              mult_re_temp(3)(I_col) := sum7_stage3_1v1_re * my_constant_pos;
              mult_im_temp(3)(I_col) := sum7_stage3_1v1_im * my_constant_pos;
            
              mult_re(3)(I_col) <= mult_re_temp(3)(I_col)(bit_width_adder downto 0);
              mult_im(3)(I_col) <= mult_im_temp(3)(I_col)(bit_width_adder downto 0);
                        
          when others => element <= element;
        end case;
        
        nextMultState <= additions_stage4;

        
      when additions_stage4 =>
        case W_row is
          -- 2. Zeile
          when 1 =>
            -- Real  
            sum1_stage4_1v1_re := resize(mult_re(0)(I_col), bit_width_adder+2) + resize(sum1_stage2_1v3_re, bit_width_adder+2);
            -- Imag
            sum1_stage4_1v1_im := resize(mult_im(0)(I_col), bit_width_adder+2) + resize(sum1_stage2_1v3_im, bit_width_adder+2);
            
            if dft_1d_2d = '0' then
              dft_1d_real(I_col)(1) <= sum1_stage4_1v1_re(bit_width_extern-1 downto 0);
              dft_1d_imag(I_col)(1) <= sum1_stage4_1v1_im(bit_width_extern-1 downto 0);
            else
              result_real(I_col)(1) <= sum1_stage4_1v1_re(bit_width_extern-1 downto 0);
              result_imag(I_col)(1) <= sum1_stage4_1v1_im(bit_width_extern-1 downto 0);
            end if;
            
          -- 4. Zeile
          when 3 =>
            -- Real
            sum3_stage4_1v1_re := resize(mult_re(1)(I_col), bit_width_adder+2) + resize(sum3_stage2_1v3_re, bit_width_adder+2);
            -- Imag
            sum3_stage4_1v1_im := resize(mult_im(1)(I_col), bit_width_adder+2) + resize(sum3_stage2_1v3_im, bit_width_adder+2);
            
            if dft_1d_2d = '0' then
              dft_1d_real(I_col)(3) <= sum3_stage4_1v1_re(bit_width_extern-1 downto 0);
              dft_1d_imag(I_col)(3) <= sum3_stage4_1v1_im(bit_width_extern-1 downto 0);
            else
              result_real(I_col)(3) <= sum3_stage4_1v1_re(bit_width_extern-1 downto 0);
              result_imag(I_col)(3) <= sum3_stage4_1v1_im(bit_width_extern-1 downto 0);
            end if;
            
          -- 6. Zeile
          when 5 =>
            -- Real
            sum5_stage4_1v1_re := resize(mult_re(2)(I_col), bit_width_adder+2) + resize(sum5_stage2_1v3_re, bit_width_adder+2);
            -- Imag
            sum5_stage4_1v1_im := resize(mult_im(2)(I_col), bit_width_adder+2) + resize(sum5_stage2_1v3_im, bit_width_adder+2);
            
            if dft_1d_2d = '0' then
              dft_1d_real(I_col)(5) <= sum5_stage4_1v1_re(bit_width_extern-1 downto 0);
              dft_1d_imag(I_col)(5) <= sum5_stage4_1v1_im(bit_width_extern-1 downto 0);
            else
              result_real(I_col)(5) <= sum5_stage4_1v1_re(bit_width_extern-1 downto 0);
              result_imag(I_col)(5) <= sum5_stage4_1v1_im(bit_width_extern-1 downto 0);
            end if;
            
          -- 8. Zeile
          when 7 =>
            -- Real
            sum7_stage4_1v1_re := resize(mult_re(3)(I_col), bit_width_adder+2) + resize(sum7_stage2_1v3_re, bit_width_adder+2);
            -- Imag
            sum7_stage4_1v1_im := resize(mult_im(3)(I_col), bit_width_adder+2) + resize(sum7_stage2_1v3_im, bit_width_adder+2);
            
            if dft_1d_2d = '0' then
              dft_1d_real(I_col)(7) <= sum7_stage4_1v1_re(bit_width_extern-1 downto 0);
              dft_1d_imag(I_col)(7) <= sum7_stage4_1v1_im(bit_width_extern-1 downto 0);
            else
              result_real(I_col)(7) <= sum7_stage4_1v1_re(bit_width_extern-1 downto 0);
              result_imag(I_col)(7) <= sum7_stage4_1v1_im(bit_width_extern-1 downto 0);
            end if;
            
          when others => element <= element;
        end case;
          
        nextMultState <= set_ready_bit;

            
      when set_ready_bit =>
        result_ready <= '0';
        if element = 63 then
          if dft_1d_2d = '1' then
            result_ready <= '1';
          end if;
          dft_1d_2d <= not dft_1d_2d;
          dft_1d_2d_out <= not dft_1d_2d;
        else 
          dft_1d_2d <= dft_1d_2d;
          dft_1d_2d_out <= dft_1d_2d;
        end if;
            
        nextMultState <= additions_stage1;
        element <= element+1;
        
            
      when others => nextMultState <= additions_stage1;
    end case;
        
  end process;
    
end arch;
            
            
