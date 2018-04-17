library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;


entity multiplizierer is
port(
      a   : in  signed(12 downto 0);
      b   : in  signed(12 downto 0);
      c   : out signed(12 downto 0)
    );
end multiplizierer;


architecture arch of multiplizierer is
  
begin
  
  
  mult : process(a)
  variable c_int : signed(25 downto 0);
  begin
    c_int := a*b;
    c <= c_int(12 downto 0);
  end process;

end arch;
