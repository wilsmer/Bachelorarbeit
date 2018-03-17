library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
library work;
use work.all;
use datatypes.all;
use constants.all;



entity multiplication is
  port(
        nRESET              : in  bit;
        loaded, clk         : in  bit;
        input, twiddle      : in  t_2d_array;
        i_out, j_out, m_out : out unsigned(2 downto 0);
        mult_res_out        : out unsigned(bit_width_multiplier-1 downto 0);
        summation           : out unsigned(bit_width_adder-1 downto 0);
        dft                 : out t_2d_array
      );
end multiplication;


architecture arch of multiplication is
  
  begin

    subtype t_mat_mult_states is std_logic_vector(2 downto 0);
    constant mat1_row1 : t_mat_mult_states := "000";
    constant mat1_row2 : t_mat_mult_states := "001";
    constant mat1_row3 : t_mat_mult_states := "010";
    constant mat1_row4 : t_mat_mult_states := "011";
    constant mat1_row5 : t_mat_mult_states := "100";
    constant mat1_row6 : t_mat_mult_states := "101";
    constant mat1_row7 : t_mat_mult_states := "110";
    constant mat1_row8 : t_mat_mult_states := "111";
    
     
    
    signal mat_mult_state, next_mat_mult_state : t_mat_mult_states;
    signal state, nextState : t_mat_mult_states;
    signal row, column : integer;
    signal en : bit;
    
    
    FSM_MAT_MULT1: process(nRESET, next_mat_mult_state)
    begin
      if nRESET = '0' then 
        mat_mult_state <= mat1_row1_mat2_col8;
      else 
        mat_mult_state <= next_mat_mult_state;
      end if;
    end process;
        
    FSM_MAT_MULT2 : process(en)
    begin
      if en and en'event then
        case mat_mult_state is
          when mat1_row1_mat2_col8 =>
            row    <= 0;
            column <= 7;
            next_mat_mult_state <= mat1_row2_mat2_col1;
          when mat1_row2_mat2_col1 =>
            row    <= 1;
            column <= 0;
            next_mat_mult_state <= mat1_row3_mat2_col2;
          when mat1_row3_mat2_col2 =>
            row    <= 2;
            column <= 1;
            next_mat_mult_state <= mat1_row4_mat2_col3;
          when mat1_row4_mat2_col3 =>
            row    <= 3;
            column <= 2;
            next_mat_mult_state <= mat1_row5_mat2_col4;
          when mat1_row5_mat2_col4 =>
            row    <= 4;
            column <= 3;
            next_mat_mult_state <= mat1_row6_mat2_col5;
          when mat1_row6_mat2_col5 =>
            row    <= 5;
            column <= 4;
            next_mat_mult_state <= mat1_row7_mat2_col6;
          when mat1_row7_mat2_col6 =>
            row    <= 6;
            column <= 5;
            next_mat_mult_state <= mat1_row8_mat2_col7;
          when mat1_row8_mat2_col7 =>
            row    <= 7;
            column <= 6;
            next_mat_mult_state <= mat1_row1_mat2_col8;
        end case;
        dft <= matRow_x_matCol(twiddle, input, row, col);
      end if;
    end process;

    FSM_MAT_MULT3 : process(nRESET, nextState)
    begin
      if nRESET = '0' then
        state <= 

end arch;
