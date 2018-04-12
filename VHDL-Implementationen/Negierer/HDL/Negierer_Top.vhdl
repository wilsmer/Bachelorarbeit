library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;


entity negierer_top is
port(
     a : in signed(12 downto 0);
     b : out signed(12 downto 0)
    );
end negierer_top;


architecture arch of negierer_top is

  --signal a : signed(12 downto 0) := "000000000111";
  --signal b : signed(12 downto 0);
  
  component negierer 
    port(
          a : in signed(12 downto 0);
          b : out signed(12 downto 0)
        );
    end component;
  
begin
  inv : negierer
    port map(
              a => a,
              b => b
            );


end arch;
