library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library STD; 	-- for writing text file 
use STD.TEXTIO.ALL; 
use ieee.std_logic_textio.all;

library work;
use work.all;
use datatypes.all;
use constants.all;


entity write_test_tb is
end entity write_test_tb;


architecture bhv of write_test_tb is

  signal clk          : bit;
  signal loaded       : bit;
  signal result_ready : bit;
  signal write_done   : bit;
  signal loop_running : bit;
  signal loop_number  : signed(2 downto 0);
  signal input_real   : t_2d_array;
  signal input_imag   : t_2d_array;
  signal output       : std_logic_vector(bit_width_extern-1 downto 0);

  component read_input_matrix
    port(
          clk        : in  bit;
          loaded     : out bit;
          input_real : out t_2d_array;
          input_imag : out t_2d_array
        );
  end component;
  
  component write_results
    port(
         result_ready : in bit;
         result_real  : in  t_2d_array;
         result_imag  : in  t_2d_array;
         write_done   : out bit;
         loop_number  : out signed(2 downto 0);
         loop_running : out bit;
         output       : out std_logic_vector(bit_width_extern-1 downto 0)
        );
  end component;
  
begin

  mat : read_input_matrix
    port map(
             clk        => clk,
             loaded     => loaded,
             input_real => input_real,
             input_imag => input_imag
            );

  write : write_results
    port map(
             result_ready => result_ready,
             result_real  => input_real,
             result_imag  => input_imag,
             write_done   => write_done,
             loop_number  => loop_number,
             loop_running => loop_running,
             output       => output
            );
  
  result_ready <= loaded  after 20 ns;
  clk          <= not clk after 10 ns;
  
end bhv;
