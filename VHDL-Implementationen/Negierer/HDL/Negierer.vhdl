library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;


entity negierer is
port(
      a : in signed(12 downto 0);
      b : out signed(12 downto 0)
    );
end negierer;


architecture arch of negierer is
  
begin

  b <= -a;

end arch;
