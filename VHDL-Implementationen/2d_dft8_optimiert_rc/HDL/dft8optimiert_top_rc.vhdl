library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.all;
use constants.all;
use datatypes.all;

entity dft8optimiert_top is
   port(
         nReset       : in  bit;
         clk          : in  bit;
         idft         : in  bit;
         loaded       : in  bit;
         input_real   : in  t_2d_array;
         input_imag   : in  t_2d_array;
         result_real  : out t_2d_array;
         result_imag  : out t_2d_array;
         result_ready : out bit
        ); 
end entity dft8optimiert_top;

architecture arch of dft8optimiert_top is

  
  component dft8optimiert
    port(
          clk           : in  bit;
          nReset        : in  bit;
          loaded        : in  bit;
          input_real    : in  t_2d_array;
          input_imag    : in  t_2d_array;
          result_real   : out t_2d_array;
          result_imag   : out t_2d_array;
          result_ready  : out bit;
          idft          : in  bit
        );
  end component;


  begin
    dft : dft8optimiert
      port map(
                nReset        => nReset,
                clk           => clk,
                loaded        => loaded,
                input_real    => input_real,
                input_imag    => input_imag,
                result_real   => result_real,
                result_imag   => result_imag,
                result_ready  => result_ready,
                idft          => idft
              );
              
      
end arch;
