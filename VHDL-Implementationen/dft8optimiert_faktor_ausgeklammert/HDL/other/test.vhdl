library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
library work;
use work.all;
use constants.all;
use datatypes.all;


entity mult_pkg is
port(
      a, b   : in  unsigned(bit_width_extern-1 downto 0);
      c      : out unsigned(bit_width_multiplier-1 downto 0)
    );
end mult_pkg;


architecture arch of mult_pkg is

  component register_12bit is
  port(
       clk : in  bit;
       d   : in  unsigned(bit_width_extern-1 downto 0);
       q   ; out unsigned(bit_width_extern-1 downto 0)
      );
  end component;
  
  begin    
  
    subtype t_complex_mult_states is std_logic_vector(1 downto 0);
    constant multiplications : t_complex_mult_states := "00";
    constant additions : t_complex_mult_states := "01";
    constant mat1_row3 : t_complex_mult_states := "10";
    constant mat1_row4 : t_complex_mult_states := "11";
    
    signal state, nextState : t_complex_mult_states;
    
    
    port map(
             clk => clk,
             d   => d,
             q   => q
            );
            
    FSM_COMPLEX_MULT1: process(nRESET, next_mat_mult_state)
    begin
      if nRESET = '0' then 
        mat_mult_state <= mat1_row1_mat2_col8;
      else 
        mat_mult_state <= next_mat_mult_state;
      end if;
    end process;
    
    
    FSM_MAT_MULT2 : process(en)
    begin
      if clk='1' and clk'event then
        case complex_mult_state is
          when multiplications => 
            multRes_re1       := re_a * re_b;
            multRes_re2       := im_a * im_b;
            multRes_im1       := re_a * im_b;
            multRes_im2       := im_a * re_b;
            
            multRes_re1_short := multRes_re1(bit_width_adder-1 downto 0);
            multRes_re2_short := multRes_re2(bit_width_adder-1 downto 0);
            multRes_im1_short := multRes_im1(bit_width_adder-1 downto 0);
            multRes_im2_short := multRes_im2(bit_width_adder-1 downto 0);
  
          when additions =>
            addRes_re        := ('0' & multRes_re1_short) - ('0' & multRes_re2_short);
            addRes_im        := ('0' & multRes_im1_short) + ('0' & multRes_im2_short);
  
            addRes_re_short  := addRes_re(bit_width_adder-1 downto 0); 
            addRes_im_short  := addRes_im(bit_width_adder-1 downto 0); 
            
        end case;
      end if;
    end process;
    

            
    
  
  
  
  result(0)       := add_res1_short;
  result(1)       := add_res2_short;
    
end arch;

