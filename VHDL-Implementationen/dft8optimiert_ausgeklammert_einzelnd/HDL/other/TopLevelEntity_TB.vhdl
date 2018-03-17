library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
library work;
use work.all;
use constants.all;
use datatypes.all;

entity top_level_tb is
end entity top_level_tb;

architecture arch of top_level_tb is

  signal clk                 : bit := '0';
  signal loaded_out          : bit;
  signal dft                 : t_2d_array;
  signal i_out, j_out, m_out : unsigned(2 downto 0);
  signal mult_res_out        : unsigned(bit_width_multiplier-1 downto 0);
  signal summation           : unsigned(bit_width_adder-1 downto 0);

  component top_level is
    port(
          clk                 : in  bit;
          loaded_out          : out bit;
          i_out, j_out, m_out : out unsigned(2 downto 0);
          mult_res_out        : out unsigned(bit_width_multiplier-1 downto 0);
          summation           : out unsigned(bit_width_adder-1 downto 0);
          dft                 : out t_2d_array
        );
  end component;

  begin
    dut : top_level
      port map(
                clk            => clk,
                loaded_out     => loaded_out,
                i_out          => i_out,
                j_out          => j_out,
                m_out          => m_out,
                mult_res_out   => mult_res_out,
                summation      => summation,
                dft            => dft
              );

    clk <= not clk after 20 ns;
end arch;
