library ieee;
use ieee.std_logic_1164.all;

library work;
use work.all;
use constants.all;
use datatypes.all;

entity register_12bit is 
port(
      clear : in bit; -- clear/reset
      clk   : in bit; -- clock
      load  : in bit; -- load/enable.
      d     : in bit_vector(bit_width_extern-1 downto 0);
      q     : out bit_vector(bit_width_extern-1 downto 0) -- output
     );
end register_12bit;

architecture description of register_12bit is
signal q_int : bit_vector(bit_width_extern-1 downto 0);
begin
    process(clk)
    begin
      if clk='1' and clk'event then
	q_int <= q_int;
        if clear = '0' then
          q_int <= (others => '0');
        else
          if load = '1' then
            q_int <= d;
          end if;
        end if;
	q <= q_int;
      end if;
    end process;
end description;
