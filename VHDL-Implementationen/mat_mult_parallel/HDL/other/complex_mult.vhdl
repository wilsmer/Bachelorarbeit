library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
library work;
use work.all;
use datatypes.all;
use constants.all;



entity multiplication is
  port(
        nRESET              : in  bit;
        clk                 : in  bit;
        in_a, in_b          : in  t_complex_number;
        result              : out t_complex_number
      );
end multiplication;


architecture arch of multiplication is
  begin
  
  mult : process(clk)
  variable re_a, im_a, re_b, im_b : unsigned(bit_width_extern-1 downto 0);
  variable res_re1, res_re2, res_im1, res_im2 : unsigned(bit_width_multiplier-1 downto 0);
  
  re_a := in_a(0);
  im_a := in_a(1);
  re_b := in_b(0);
  im_b := in_b(1);
  
  begin
  if clk='1' and clk'event then
    res_re1 := re_a * re_b;
    res_re2 := im_a * im_b;
    res_im1 := re_a * im_b;
    res_im2 := im_a * re_a;
  end if;
