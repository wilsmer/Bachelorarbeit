library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;


entity Multiplizierer_Top is
port(
     a : in signed(12 downto 0);
     b : in signed(12 downto 0);
     c : out signed(12 downto 0)
    );
end Multiplizierer_Top;


architecture arch of Multiplizierer_Top is


  component multiplizierer 
    port(
          a   : in  signed(12 downto 0);
          b   : in  signed(12 downto 0);
          c   : out signed(12 downto 0)
        );
    end component;
  
begin
  mult : multiplizierer
    port map(
              a   => a,
              b   => b,
              c   => c
            );

end arch;
