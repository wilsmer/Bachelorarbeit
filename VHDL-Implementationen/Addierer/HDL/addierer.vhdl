library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;


entity addierer is
port(
      --clk : in  bit;
      a   : in  signed(12 downto 0);
      b   : in  signed(12 downto 0);
      x   : out signed(12 downto 0)
    );
end addierer;


architecture arch of addierer is
  
begin
  
  
  mult : process(a,b)

  
  begin

    x <= resize(a(12 downto 1), 13) + resize(b(12 downto 1), 13);
    
  end process;

end arch;
