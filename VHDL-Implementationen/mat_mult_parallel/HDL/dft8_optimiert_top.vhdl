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
  signal loop_number   : signed(2 downto 0);
  signal loop_running  : bit;
  
  signal sum1_out      : signed(bit_width_adder-1 downto 0);
  signal sum2_out      : signed(bit_width_adder-1 downto 0);
  signal sum3_out      : signed(bit_width_adder-1 downto 0);
  signal sum4_out      : signed(bit_width_adder-1 downto 0);
  signal in1_out       : signed(bit_width_extern-1 downto 0);
  signal in2_out       : signed(bit_width_extern-1 downto 0);
  signal in3_out       : signed(bit_width_extern-1 downto 0);
  signal in4_out       : signed(bit_width_extern-1 downto 0);
  signal in5_out       : signed(bit_width_extern-1 downto 0);
  signal in6_out       : signed(bit_width_extern-1 downto 0);
  signal in7_out       : signed(bit_width_extern-1 downto 0);
  signal in8_out       : signed(bit_width_extern-1 downto 0);
  signal constMult_out : t_1d_array64_12bit;
  signal sum3_stage1_re_out : t_1d_array6_13bit;
  signal sum3_stage2_re_out : t_1d_array3_14bit;
  signal sum3_stage3_re_out : signed(bit_width_adder+1 downto 0);
  signal sum3_stage4_re_out : signed(bit_width_adder+2 downto 0);
  signal sum3_stage1_im_out : t_1d_array6_13bit;
  signal sum3_stage2_im_out : t_1d_array3_14bit;
  signal sum3_stage3_im_out : signed(bit_width_adder+1 downto 0);
  signal sum3_stage4_im_out : signed(bit_width_adder+2 downto 0);
  
  
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
          constMult_out : out t_1d_array64_12bit;
     sum3_stage1_re_out : out t_1d_array6_13bit;
     sum3_stage2_re_out : out t_1d_array3_14bit;
     sum3_stage3_re_out : out signed(bit_width_adder+1 downto 0);
     sum3_stage4_re_out : out signed(bit_width_adder+2 downto 0);
     sum3_stage1_im_out : out t_1d_array6_13bit;
     sum3_stage2_im_out : out t_1d_array3_14bit;
     sum3_stage3_im_out : out signed(bit_width_adder+1 downto 0);
     sum3_stage4_im_out : out signed(bit_width_adder+2 downto 0);
          sum1_out      : out signed(bit_width_adder-1 downto 0);
          sum2_out      : out signed(bit_width_adder-1 downto 0);
          sum3_out      : out signed(bit_width_adder-1 downto 0);
          sum4_out      : out signed(bit_width_adder-1 downto 0);
          in1_out       : out signed(bit_width_extern-1 downto 0);
          in2_out       : out signed(bit_width_extern-1 downto 0);
          in3_out       : out signed(bit_width_extern-1 downto 0);
          in4_out       : out signed(bit_width_extern-1 downto 0);
          in5_out       : out signed(bit_width_extern-1 downto 0);
          in6_out       : out signed(bit_width_extern-1 downto 0);
          in7_out       : out signed(bit_width_extern-1 downto 0);
          in8_out       : out signed(bit_width_extern-1 downto 0)
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
          write_done   : out bit;
          loop_number  : out signed(2 downto 0);
          loop_running : out bit
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
                constMult_out => constMult_out,
                sum3_stage1_re_out => sum3_stage1_re_out,
                sum3_stage2_re_out => sum3_stage2_re_out,
                sum3_stage3_re_out => sum3_stage3_re_out,
                sum3_stage4_re_out => sum3_stage4_re_out,
                sum3_stage1_im_out => sum3_stage1_im_out,
                sum3_stage2_im_out => sum3_stage2_im_out,
                sum3_stage3_im_out => sum3_stage3_im_out,
                sum3_stage4_im_out => sum3_stage4_im_out,
                sum1_out      => sum1_out,
                sum2_out      => sum2_out,
                sum3_out      => sum3_out,
                sum4_out      => sum4_out,
                in1_out       => in1_out,
                in2_out       => in2_out,
                in3_out       => in3_out,
                in4_out       => in4_out,
                in5_out       => in5_out,
                in6_out       => in6_out,
                in7_out       => in7_out,
                in8_out       => in8_out
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
               write_done   => write_done,
               loop_number  => loop_number,
               loop_running => loop_running
              );
               
    clk    <= not clk after 20 ns;
    nReset <= '1' after 40 ns;
      
end arch;
