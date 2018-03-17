library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

library STD; 	-- for writing text file 
use STD.TEXTIO.ALL; 
use ieee.std_logic_textio.all;

library work;
use work.all;
use datatypes.all;
use constants.all;


entity write_test is

  port(
       ready : in bit       
       --result_real  : in t_2d_array;
       --result_imag  : in t_2d_array;
       --write_done   : out bit;
       --loop_number  : out signed(2 downto 0);
       --loop_running : out bit
      );  
end entity write_test;


architecture bhv of write_test is
begin
  writing_test : process(ready)

    variable fstatus : file_open_status; -- status r,w
    variable outline : line; -- writeout line
    file     outfile : text; -- filehandle
    variable output1 : bit_vector(3 downto 0) := "0101";
    variable output2 : bit_vector(3 downto 0) := "0110";
    variable char    : character := ' ';

    begin

      file_open(fstatus, outfile, "HDL/Results.txt",  write_mode); 
            
      write(outline, output1);--, right, bit_width_extern);
      write(outline, char);
      write(outline, output2);
      writeline(outfile, outline);

      file_close(outfile);     

  end process;
end bhv;


