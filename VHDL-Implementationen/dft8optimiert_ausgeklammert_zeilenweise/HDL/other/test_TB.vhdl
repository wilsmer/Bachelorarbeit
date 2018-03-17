library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
library work;
use work.all;
use constants.all;
use datatypes.all;
use mult_pkg.all;

entity test_TB is
end entity;

architecture arch of test_TB is
  signal a, b : unsigned(11 downto 0);
  signal c    : unsigned(23 downto 0);
  
begin
  a <= "000000001000";
  b <= "000000000100";
  multiplication(a=>a, b=>b, c=>c);
  
end arch;
