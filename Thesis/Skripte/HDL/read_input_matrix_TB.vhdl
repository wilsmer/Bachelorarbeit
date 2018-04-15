library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.all;
use datatypes.all;

entity read_input_matrix_tb is
end entity read_input_matrix_tb;

architecture arch of read_input_matrix_tb is

  signal clk         : bit := '0';
  signal loaded      : bit := '0';
  signal input_real  : t_2d_array;
  signal input_imag  : t_2d_array;

  component read_input_matrix is
    port(
          clk         : in  bit;
          loaded      : out bit;
          input_real  : out t_2d_array;
          input_imag  : out t_2d_array
        );
  end component;

  begin
    dut : read_input_matrix
      port map(
                clk        => clk,
                loaded     => loaded,
                input_real => input_real,
                input_imag => input_imag
              );

    clk <= not clk after 20 ns;
end arch;

