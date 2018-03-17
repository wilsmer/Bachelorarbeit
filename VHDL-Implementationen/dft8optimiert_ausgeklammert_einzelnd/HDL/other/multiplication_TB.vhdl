library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
library work;
use work.all;
use datatypes.all;
use constants.all;

entity multiplication_tb is
end entity multiplication_tb;

architecture arch of multiplication_tb is  


  signal loaded               : bit := '0';
  signal input, twiddle, dft  : t_2d_array;
  signal mult                 : unsigned(bit_width_multiplier-1 downto 0);
  signal tw_i_m, in_x         : unsigned(bit_width_extern-1 downto 0);

  signal zero : unsigned(bit_width_extern-1 downto 0); 
  signal one_pos : unsigned(bit_width_extern-1 downto 0);
  signal one_neg : unsigned(bit_width_extern-1 downto 0);
  signal sqrt_2_half_pos : unsigned(bit_width_extern-1 downto 0);
  signal sqrt_2_half_neg : unsigned(bit_width_extern-1 downto 0);

  component multiplication is
    port(
          loaded         : in bit;
          input, twiddle : in t_2d_array;
          mult           : out unsigned(bit_width_multiplier-1 downto 0);
          tw_i_m, in_x   : out unsigned(bit_width_extern-1 downto 0);
          dft            : out t_2d_array
        );
  end component;

  begin
    zero <= (others => '0' );
    one_pos <= "010000000000";
    one_neg <= "110000000000";
    sqrt_2_half_pos <= "001011010100";
    sqrt_2_half_neg <= "110100101100";
    
    loaded <= '1' after 10 ns;
    
      input(0)(0) <= one_pos;
      input(0)(1) <= one_pos;
      input(0)(2) <= one_pos;
      input(0)(3) <= one_pos;
      input(0)(4) <= one_pos;
      input(0)(5) <= one_pos;
      input(0)(6) <= one_pos;
      input(0)(7) <= one_pos;

      input(1)(0) <= one_pos;
      input(1)(1) <= sqrt_2_half_pos;
      input(1)(2) <= zero;
      input(1)(3) <= sqrt_2_half_neg;
      input(1)(4) <= one_neg;
      input(1)(5) <= sqrt_2_half_neg;
      input(1)(6) <= zero;
      input(1)(7) <= sqrt_2_half_pos;

      input(2)(0) <= one_pos;
      input(2)(1) <= zero;
      input(2)(2) <= one_neg;
      input(2)(3) <= zero;
      input(2)(4) <= one_pos;
      input(2)(5) <= zero;
      input(2)(6) <= one_neg;
      input(2)(7) <= zero;
 
      input(3)(0) <= one_pos;
      input(3)(1) <= sqrt_2_half_neg;
      input(3)(2) <= zero;
      input(3)(3) <= sqrt_2_half_pos;
      input(3)(4) <= one_neg;
      input(3)(5) <= sqrt_2_half_pos;
      input(3)(6) <= zero;
      input(3)(7) <= sqrt_2_half_neg;

      input(4)(0) <= one_pos;
      input(4)(1) <= one_neg;
      input(4)(2) <= one_pos;
      input(4)(3) <= one_neg;
      input(4)(4) <= one_pos;
      input(4)(5) <= one_neg;
      input(4)(6) <= one_pos;
      input(4)(7) <= one_neg;

      input(5)(0) <= one_pos;
      input(5)(1) <= sqrt_2_half_neg;
      input(5)(2) <= zero;
      input(5)(3) <= sqrt_2_half_pos;
      input(5)(4) <= one_neg;
      input(5)(5) <= sqrt_2_half_pos;
      input(5)(6) <= zero;
      input(5)(7) <= sqrt_2_half_neg;

      input(6)(0) <= one_pos;
      input(6)(1) <= zero;
      input(6)(2) <= one_neg;
      input(6)(3) <= zero;
      input(6)(4) <= one_pos;
      input(6)(5) <= zero;
      input(6)(6) <= one_neg;
      input(6)(7) <= zero;

      input(7)(0) <= one_pos;
      input(7)(1) <= sqrt_2_half_pos;
      input(7)(2) <= zero;
      input(7)(3) <= sqrt_2_half_neg;
      input(7)(4) <= one_neg;
      input(7)(5) <= sqrt_2_half_neg;
      input(7)(6) <= zero;
      input(7)(7) <= sqrt_2_half_pos;

      twiddle(0)(0) <= one_pos;
      twiddle(0)(1) <= one_pos;
      twiddle(0)(2) <= one_pos;
      twiddle(0)(3) <= one_pos;
      twiddle(0)(4) <= one_pos;
      twiddle(0)(5) <= one_pos;
      twiddle(0)(6) <= one_pos;
      twiddle(0)(7) <= one_pos;

      twiddle(1)(0) <= one_pos;
      twiddle(1)(1) <= sqrt_2_half_pos;
      twiddle(1)(2) <= zero;
      twiddle(1)(3) <= sqrt_2_half_neg;
      twiddle(1)(4) <= one_neg;
      twiddle(1)(5) <= sqrt_2_half_neg;
      twiddle(1)(6) <= zero;
      twiddle(1)(7) <= sqrt_2_half_pos;

      twiddle(2)(0) <= one_pos;
      twiddle(2)(1) <= zero;
      twiddle(2)(2) <= one_neg;
      twiddle(2)(3) <= zero;
      twiddle(2)(4) <= one_pos;
      twiddle(2)(5) <= zero;
      twiddle(2)(6) <= one_neg;
      twiddle(2)(7) <= zero;
 
      twiddle(3)(0) <= one_pos;
      twiddle(3)(1) <= sqrt_2_half_neg;
      twiddle(3)(2) <= zero;
      twiddle(3)(3) <= sqrt_2_half_pos;
      twiddle(3)(4) <= one_neg;
      twiddle(3)(5) <= sqrt_2_half_pos;
      twiddle(3)(6) <= zero;
      twiddle(3)(7) <= sqrt_2_half_neg;

      twiddle(4)(0) <= one_pos;
      twiddle(4)(1) <= one_neg;
      twiddle(4)(2) <= one_pos;
      twiddle(4)(3) <= one_neg;
      twiddle(4)(4) <= one_pos;
      twiddle(4)(5) <= one_neg;
      twiddle(4)(6) <= one_pos;
      twiddle(4)(7) <= one_neg;

      twiddle(5)(0) <= one_pos;
      twiddle(5)(1) <= sqrt_2_half_neg;
      twiddle(5)(2) <= zero;
      twiddle(5)(3) <= sqrt_2_half_pos;
      twiddle(5)(4) <= one_neg;
      twiddle(5)(5) <= sqrt_2_half_pos;
      twiddle(5)(6) <= zero;
      twiddle(5)(7) <= sqrt_2_half_neg;

      twiddle(6)(0) <= one_pos;
      twiddle(6)(1) <= zero;
      twiddle(6)(2) <= one_neg;
      twiddle(6)(3) <= zero;
      twiddle(6)(4) <= one_pos;
      twiddle(6)(5) <= zero;
      twiddle(6)(6) <= one_neg;
      twiddle(6)(7) <= zero;

      twiddle(7)(0) <= one_pos;
      twiddle(7)(1) <= sqrt_2_half_pos;
      twiddle(7)(2) <= zero;
      twiddle(7)(3) <= sqrt_2_half_neg;
      twiddle(7)(4) <= one_neg;
      twiddle(7)(5) <= sqrt_2_half_neg;
      twiddle(7)(6) <= zero;
      twiddle(7)(7) <= sqrt_2_half_pos;



    dut : multiplication
      port map(
                loaded  => loaded,
                input   => input,
                twiddle => twiddle,
                mult    => mult,
                tw_i_m  => tw_i_m,
                in_x    => in_x,
                dft     => dft
              );

end arch;


