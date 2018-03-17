library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
library work;
use work.all;
use constants.all;
use datatypes.all;


entity dft8 is
port(
     fsm_enable : in bit;
     input      : in t_2d_array;
     dft        : out t_2d_array
    );
end dft8;


architecture arch of dft8 is

begin

  subtype t_complex_mult_states is std_logic_vector(2 downto 0);
  constant row1 : t_complex_mult_states := "000";
  constant row2 : t_complex_mult_states := "001";
  constant row3 : t_complex_mult_states := "010";
  constant row4 : t_complex_mult_states := "011";
  constant row5 : t_complex_mult_states := "100";
  constant row6 : t_complex_mult_states := "101";
  constant row7 : t_complex_mult_states := "110";
  constant row8 : t_complex_mult_states := "111";
   
  signal state, nextState : t_complex_mult_states;
  
  FSM_MAT_MULT2 : process(fsm_enable)

    begin
      if fsm_enable='1' and fsm_enable'event then
        case state is
          when row1 => 
            -- Realteil
            -- 1*re(0)(0) + 1*re(1)(0) + 1*re(2)(0) + 1*re(3)(0) + 1*re(4)(0) + 1*re(5)(0) + 1*re(6)(0) + 1*re(7)(0)
            dft(0)(0) = input(0)(0) + input(1)(0) + input(2)(0) + input(3)(0) + input(4)(0) + input(5)(0) + input(6)(0) + input(7)(0);
            -- Imaginaerteil
            -- 0*im(0)(0) + 0*im(1)(0) + 0*im(2)(0) + 0*im(3)(0) + 0*im(4)(0) + 0*im(5)(0) + 0*im(6)(0) + 0*im(7)(0)
            
          when row2 => 
            dft(1)(0) = input(0)(0) + sqrt2_2(input(1)(0))- (-sqrt2_2(input(1)(0))) + input(3)(0) + input(4)(0) + input(5)(0) + input(7)(0);
