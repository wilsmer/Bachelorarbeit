-- Package, welches ein 2D-Array bereitstellt.
-- Das 2D-Array besteht aus 1D-Arrays, dies bringr gegenueber der direkten Erzeugung (m,n) statt (m)(n) den Vorteil, dass
-- dass zeilen- sowie spaltenweise zugewiesen werden kann. Sonst waere nur die komplette Matrix oder einzelne Elemente moeglich.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use ieee.std_logic_arith.all;
use ieee.numeric_std.all;
library work;
use work.all;
use constants.all;


package datatypes is
    type t_1d_array is array(integer range 0 to mat_size-1) of signed(bit_width_extern-1 downto 0);
    type t_2d_array is array(integer range 0 to mat_size-1) of t_1d_array; 
    
    type t_1d_array64_12bit is array(integer range 0 to 63) of signed(bit_width_extern-1 downto 0);
    type t_1d_array64_24bit is array(integer range 0 to 63) of signed(bit_width_multiplier-1 downto 0);
    
    type t_1d_array6_13bit is array(integer range 0 to 5) of signed(bit_width_adder-1 downto 0);
    type t_1d_array3_14bit is array(integer range 0 to 2) of signed(bit_width_adder downto 0);
    
    type t_1d_array8_13bit is array(integer range 0 to mat_size-1) of signed(bit_width_adder-1 downto 0);
    type t_1d_array8_14bit is array(integer range 0 to mat_size-1) of signed(bit_width_adder downto 0);
    type t_1d_array8_15bit is array(integer range 0 to mat_size-1) of signed(bit_width_adder+1 downto 0);
    type t_1d_array8_16bit is array(integer range 0 to mat_size-1) of signed(bit_width_adder+2 downto 0);
    
    type t_1d_array4_14bit is array(integer range 0 to mat_size-1) of signed(bit_width_adder downto 0);
    type t_2d_array4x8_14bit is array(integer range 0 to 3) of t_1d_array4_14bit;
    
    type t_1d_array4_30bit is array(integer range 0 to mat_size-1) of signed(29 downto 0);
    type t_2d_array4x8_30bit is array(integer range 0 to 3) of t_1d_array4_30bit;
    
    -- Zustandsautomat 1D-DFT
    subtype t_dft8_states is std_logic_vector(2 downto 0);
    constant idle             : t_dft8_states := "000";
    constant additions_stage1 : t_dft8_states := "001";
    constant additions_stage2 : t_dft8_states := "010";
    constant additions_stage3 : t_dft8_states := "011";
    constant const_mult       : t_dft8_states := "100";
    constant additions_stage4 : t_dft8_states := "101";
    constant pause            : t_dft8_states := "110";
    constant set_ready_bit    : t_dft8_states := "111";
    
end datatypes;
