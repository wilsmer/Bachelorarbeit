library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;


entity konstantenmultiplizierer is
port(
      --clk : in  bit;
      a   : in  signed(12 downto 0);
      x   : out signed(12 downto 0)
    );
end konstantenmultiplizierer;


architecture arch of konstantenmultiplizierer is
  signal m : signed(12 downto 0);
  --constant m : signed(12 downto 0) := "0001011010100";
begin
  
  m <= "0001011010100"; -- wenn m als signal deklariert wurde
  mult : process(a)
  
    --variable m : signed(12 downto 0) := "0001011010100";
    variable f_int : signed(25 downto 0);
  
  begin
  
    f_int := a*m;
    x <= f_int(21 downto 9);
    --x <= m*a;
    
    
  end process;

end arch;
