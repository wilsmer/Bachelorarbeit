library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



package constants is
  constant mat_size : integer;
  constant bit_width_extern : integer;
  constant bit_width_adder : integer;
  constant bit_width_multiplier : integer;
end constants;

package body constants is
  constant mat_size : integer := 8;
  constant bit_width_extern : integer := 12;
  constant bit_width_adder : integer := bit_width_extern+1;
  constant bit_width_multiplier : integer := bit_width_adder*2;
  
end constants;
