library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;


entity Addierer_TOP is
port(
     a : in signed(12 downto 0);
     b : in signed(12 downto 0);
     x : out signed(12 downto 0)
    );
end Addierer_TOP;


architecture arch of Addierer_TOP is

  component addierer 
    port(
          a   : in  signed(12 downto 0);
          b   : in  signed(12 downto 0);
          x   : out signed(12 downto 0)
        );
    end component;
  
begin
  mult : addierer
    port map(
              a   => a,
              b   => b,
              x   => x
            );

end arch;
