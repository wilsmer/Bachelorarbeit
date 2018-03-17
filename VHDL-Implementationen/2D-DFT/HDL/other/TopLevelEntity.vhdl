library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
library work;
use work.all;
use datatypes.all;
use constants.all;



entity top_level is
  port(
        clk                 : in  bit;
        loaded_out          : out bit;
        i_out, j_out, m_out : out unsigned(2 downto 0);
        mult_res_out        : out unsigned(bit_width_multiplier-1 downto 0);
        summation           : out unsigned(bit_width_adder-1 downto 0);
        dft                 : out t_2d_array
      );
end top_level;



architecture arch of top_level is
signal twiddle, input : t_2d_array;
signal loaded : bit;

component twiddle_matrix 
  port( 
        twiddle : out t_2d_array
      );
end component;

component read_file
  port(
        clk    : in bit;
        loaded : out bit;
        input  : out t_2d_array
      );
end component;

component multiplication
  port(
        clk                 : in  bit;
        loaded              : in  bit;
        input, twiddle      : in  t_2d_array;
        i_out, j_out, m_out : out unsigned(2 downto 0);
        mult_res_out        : out unsigned(bit_width_multiplier-1 downto 0);
        summation           : out unsigned(bit_width_adder-1 downto 0);
        dft                 : out t_2d_array
      );
end component;


begin

loaded_out <= loaded;

twiddle_mat : twiddle_matrix
  port map(
            twiddle => twiddle
          );

read_from_file : read_file
  port map(
            clk    => clk,
            loaded => loaded,
            input  => input
          );

multiply : multiplication
  port map(
            clk            => clk,
            loaded         => loaded,
            input          => input,
            twiddle        => twiddle,
            i_out          => i_out,
            j_out          => j_out,
            m_out          => m_out,
            mult_res_out   => mult_res_out,
            summation      => summation,
            dft            => dft
          );
end arch; 
