library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
library work;
use work.all;
use constants.all;
use datatypes.all;

entity dft8optimiert_top is
--   port(
--        result_real : out t_2d_array;
--        result_imag : out t_2d_array
--       ); 
end entity dft8optimiert_top;

architecture arch of dft8optimiert_top is

  signal nReset        : bit;
  signal clk           : bit;
  signal input_real    : t_2d_array;
  signal input_imag    : t_2d_array;
  signal result_real   : t_2d_array;
  signal result_imag   : t_2d_array;
  signal loaded        : bit;  
  signal multState_out : t_dft8_states;
  
  signal result_ready  : bit;
  signal write_done    : bit;
  
  signal sum7_stage1_im_out : t_1d_array6_13bit;
  signal sum7_stage2_im_out : t_1d_array3_14bit;
  signal sum7_stage3_im_out : signed(bit_width_adder+1 downto 0);
  signal sum7_stage4_im_out : signed(bit_width_adder+1 downto 0);
  signal mult_im_out        :  t_2d_array4x8_14bit;
  signal mult_im_long_out : t_2d_array4x8_30bit;
  signal mult_im_short_out : t_2d_array4x8_14bit;
  
  
  
  component dft8optimiert
    port(
          clk           : in  bit;
          nReset        : in  bit;
          loaded        : in  bit;
          multState_out : out t_dft8_states;
          input_real    : in  t_2d_array;
          input_imag    : in  t_2d_array;
          result_real   : out t_2d_array;
          result_imag   : out t_2d_array;
          result_ready  : out bit;
     sum7_stage1_im_out : out t_1d_array6_13bit;
     sum7_stage2_im_out : out t_1d_array3_14bit;
     sum7_stage3_im_out : out signed(bit_width_adder+1 downto 0);
     sum7_stage4_im_out : out signed(bit_width_adder+1 downto 0);
          mult_im_out   : out t_2d_array4x8_14bit;
          mult_im_long_out : out t_2d_array4x8_30bit;
          mult_im_short_out : out t_2d_array4x8_14bit
        );
  end component;

  
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
          result_real  : in t_2d_array;
          result_imag  : in t_2d_array;
          write_done   : out bit
        );
  end component;
  

  begin
    dft : dft8optimiert
      port map(
                nReset        => nReset,
                clk           => clk,
                loaded        => loaded,
                multState_out => multState_out,
                input_real    => input_real,
                input_imag    => input_imag,
                result_real   => result_real,
                result_imag   => result_imag,
                result_ready  => result_ready,
                sum7_stage1_im_out => sum7_stage1_im_out,
                sum7_stage2_im_out => sum7_stage2_im_out,
                sum7_stage3_im_out => sum7_stage3_im_out,
                sum7_stage4_im_out => sum7_stage4_im_out,
                mult_im_out   => mult_im_out,
                mult_im_long_out => mult_im_long_out,
                mult_im_short_out => mult_im_short_out
              );
              
     mat : read_input_matrix
       port map(
                clk         => clk,
                loaded      => loaded,
                input_real  => input_real,
                input_imag  => input_imag
               );
               
    write : write_results
      port map(
               result_ready => result_ready,
               result_real  => result_real,
               result_imag  => result_imag,
               write_done   => write_done
              );
               
    clk    <= not clk after 20 ns;
    nReset <= '1' after 40 ns;
      
end arch;
