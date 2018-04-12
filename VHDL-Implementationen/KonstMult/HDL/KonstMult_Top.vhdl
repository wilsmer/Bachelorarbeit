library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;


entity Konstatenmultiplizierer_Top is
--port(
--    );
end Konstatenmultiplizierer_Top;


architecture arch of Konstatenmultiplizierer_Top is

  signal clk : bit;
  signal a : signed(12 downto 0) := "0000000000111";
  signal b : signed(12 downto 0);
  
  component konstantenmultiplizierer 
    port(
          clk : in  bit;
          a   : in  signed(12 downto 0);
          b   : out signed(12 downto 0)
        );
    end component;
  
begin
  mult : konstantenmultiplizierer
    port map(
              clk => clk,
              a   => a,
              b   => b
            );

clk <= not clk after 10 ns;

end arch;
