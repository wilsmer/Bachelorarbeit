
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
library work;
use work.all;
use datatypes.all;
use constants.all;

entity dft8optimiert_tb is
end dft8optimiert_tb;

architecture arch of dft8optimiert_tb is

  signal nReset              : bit := '0';
  signal clk                 : bit := '0';
  signal loaded              : bit;
  signal result_real         : t_2d_array;
  signal result_imag         : t_2d_array;
  signal input_real          : t_2d_array;
  signal input_imag          : t_2d_array;


  component dft8optimiert_top
   port(
        nReset      : in  bit;
        clk         : in  bit;
        loaded      : in  bit;
        input_real  : in  t_2d_array;
        input_imag  : out t_2d_array;
        result_real : out t_2d_array;
        result_imag : out t_2d_array
       );
  end component;
        
  begin    
    dut : dft8optimiert_top
      port map(
               nReset => nReset,
               clk    => clk,
               loaded => loaded,
               input_real => input_real,
               input_imag => input_imag,
               result_real => result_real,
               result_imag => result_imag
              );
      
    
    
    clk    <= not clk after 20 ns;
    nReset <= '1' after 40 ns;
    
end arch;
