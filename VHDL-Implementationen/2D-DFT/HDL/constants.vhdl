library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



package constants is
  constant bit_width_extern : integer;
  constant bit_width_multiplier : integer;
  constant bit_width_adder : integer;
  constant mat_size : integer;
end constants;

package body constants is
  constant bit_width_extern : integer := 12;
  constant bit_width_multiplier : integer := 24;
  constant bit_width_adder : integer := 13;
  constant mat_size : integer := 8;
end constants;

