library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
library work;
use work.all;
use datatypes.all;
use constants.all;

package functions is
  --function RESIZE (X : unsigned; new_size : integer) return unsigned;
  function RESIZE (X : signed; new_size : integer) return signed;
  function RESIZE (X : signed) return signed;
end;

package body functions is
  function RESIZE (X : signed; new_size : integer) return signed is

    variable TMP : signed(new_size-1 downto 0);
    variable old_size : integer;
  begin
    old_size := X'Length;
    TMP(old_size-1 downto 0) := X;
    
    if X(old_size-1) = '1' then
      TMP(new_size-1 downto old_size) := (others => '1');
    else
      TMP(new_size-1 downto old_size) := (others => '0');
    end if;
    return TMP;
  end RESIZE;
  
  function RESIZE (X : signed) return signed is

    variable new_size : integer := X'Length+1;
    variable TMP : signed(new_size-1 downto 0);
    variable old_size : integer;
  begin
    old_size := X'Length;
    TMP(old_size-1 downto 0) := X;
    
    if X(old_size-1) = '1' then
      TMP(new_size-1 downto old_size) := (others => '1');
    else
      TMP(new_size-1 downto old_size) := (others => '0');
    end if;
    return TMP;
  end RESIZE;
  
end package body;
