library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
library work;
use work.all;
use constants.all;
use datatypes.all;

--entity complex_multiplication_function is
--end complex_multiplication_function;

package complex_mult_pkg is
--type unsigned(2*bit_width_multiplier-1) is array(integer range 0 to 1) of unsigned(bit_width_extern-1 downto 0);
function complex_multiplication(re_a : unsigned(2*bit_width_multiplier-1); im_a : unsigned(2*bit_width_multiplier-1); re_b : unsigned(2*bit_width_multiplier-1); im_b : unsigned(2*bit_width_multiplier-1)) return unsigned(2*bit_width_multiplier-1);
end complex_mult_pkg;



--architecture behave of complex_multiplication_function is
package body complex_mult_pkg is
function complex_multiplication(re_a : unsigned(2*bit_width_multiplier-1); im_a : unsigned(2*bit_width_multiplier-1); re_b : unsigned(2*bit_width_multiplier-1); im_b : unsigned(2*bit_width_multiplier-1)) return unsigned(2*bit_width_multiplier-1) is

  variable mult_res1       : unsigned(bit_width_multiplier-1 downto 0);
  variable mult_res2       : unsigned(bit_width_multiplier-1 downto 0);
  variable mult_res3       : unsigned(bit_width_multiplier-1 downto 0);
  variable mult_res4       : unsigned(bit_width_multiplier-1 downto 0);
  
  variable mult_res1_short : unsigned(bit_width_adder-1      downto 0);
  variable mult_res2_short : unsigned(bit_width_adder-1      downto 0);
  variable mult_res3_short : unsigned(bit_width_adder-1      downto 0);
  variable mult_res4_short : unsigned(bit_width_adder-1      downto 0);
  
  variable add_res1        : unsigned(bit_width_adder        downto 0);
  variable add_res2        : unsigned(bit_width_adder        downto 0);
  
  variable add_res1_short  : unsigned(bit_width_adder-1      downto 0);
  variable add_res2_short  : unsigned(bit_width_adder-1      downto 0);
  
  variable result          : unsigned(2*bit_width_multiplier-1);

begin 
  mult_res1       := re_a * re_b;
  mult_res2       := im_a * im_b;
  mult_res3       := re_a * im_b;
  mult_res4       := im_a * re_b;
  
  mult_res1_short := mult_res1(bit_width_adder-1 downto 0);
  mult_res2_short := mult_res2(bit_width_adder-1 downto 0);
  mult_res3_short := mult_res3(bit_width_adder-1 downto 0);
  mult_res4_short := mult_res4(bit_width_adder-1 downto 0);
  
  add_res1        := ('0' & mult_res1) - ('0' & mult_res2);
  add_res2        := ('0' & mult_res3) + ('0' & mult_res4);
  
  add_res1_short  := add_res1(bit_width_adder-1 downto 0); 
  add_res2_short  := add_res2(bit_width_adder-1 downto 0); 
  
  result(0)       := add_res1_short;
  result(1)       := add_res2_short;
  
  return result;
end complex_multiplication;
end complex_mult_pkg;
