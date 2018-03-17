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



entity write_results is
  port(
       result_ready : in  bit;
       result_real  : in  t_2d_array;
       result_imag  : in  t_2d_array;
       write_done   : out bit;
       loop_number  : out signed(2 downto 0);
       loop_running : out bit
       --output       : out std_logic_vector(bit_width_extern-1 downto 0)
      );  
end entity write_results;


architecture bhv of write_results is
begin
  writing_test : process(result_ready)

    variable fstatus : file_open_status; -- status r,w
    variable outline : line; -- writeout line
    file     outfile : text; -- filehandle
    
    --variable output1 : bit_vector(3 downto 0) := "0101";
    --variable output2 : bit_vector(3 downto 0) := "0110";
    
    variable element_1_real : std_logic_vector(bit_width_extern-1 downto 0);
    variable element_1_imag : std_logic_vector(bit_width_extern-1 downto 0);
    variable element_2_real : std_logic_vector(bit_width_extern-1 downto 0);
    variable element_2_imag : std_logic_vector(bit_width_extern-1 downto 0);
    variable element_3_real : std_logic_vector(bit_width_extern-1 downto 0);
    variable element_3_imag : std_logic_vector(bit_width_extern-1 downto 0);
    variable element_4_real : std_logic_vector(bit_width_extern-1 downto 0);
    variable element_4_imag : std_logic_vector(bit_width_extern-1 downto 0);
    variable element_5_real : std_logic_vector(bit_width_extern-1 downto 0);
    variable element_5_imag : std_logic_vector(bit_width_extern-1 downto 0);
    variable element_6_real : std_logic_vector(bit_width_extern-1 downto 0);
    variable element_6_imag : std_logic_vector(bit_width_extern-1 downto 0);
    variable element_7_real : std_logic_vector(bit_width_extern-1 downto 0);
    variable element_7_imag : std_logic_vector(bit_width_extern-1 downto 0);
    variable element_8_real : std_logic_vector(bit_width_extern-1 downto 0);
    variable element_8_imag : std_logic_vector(bit_width_extern-1 downto 0);
    variable space : character := ' ';
    
    --variable i : integer := 0;

    begin

      file_open(fstatus, outfile, "HDL/Results.txt",  write_mode); 

    for i in 0 to mat_size-1 loop
      element_1_real := std_logic_vector(result_real(i)(0)); 
      element_1_imag := std_logic_vector(result_imag(i)(0));
      element_2_real := std_logic_vector(result_real(i)(1));
      element_2_imag := std_logic_vector(result_imag(i)(1));
      element_3_real := std_logic_vector(result_real(i)(2)); 
      element_3_imag := std_logic_vector(result_imag(i)(2));
      element_4_real := std_logic_vector(result_real(i)(3));
      element_4_imag := std_logic_vector(result_imag(i)(3));
      element_5_real := std_logic_vector(result_real(i)(4)); 
      element_5_imag := std_logic_vector(result_imag(i)(4));
      element_6_real := std_logic_vector(result_real(i)(5));
      element_6_imag := std_logic_vector(result_imag(i)(5));
      element_7_real := std_logic_vector(result_real(i)(6)); 
      element_7_imag := std_logic_vector(result_imag(i)(6));
      element_8_real := std_logic_vector(result_real(i)(7));
      element_8_imag := std_logic_vector(result_imag(i)(7));
      
      --output <= element_1_real;
      
      write(outline, element_1_real);
      write(outline, space);
      write(outline, element_1_imag);
      write(outline, space);
      write(outline, element_2_real);
      write(outline, space);
      write(outline, element_2_imag);
      write(outline, space);
      write(outline, element_3_real);
      write(outline, space);
      write(outline, element_3_imag);
      write(outline, space);
      write(outline, element_4_real);
      write(outline, space);
      write(outline, element_4_imag);
      write(outline, space);
      write(outline, element_5_real);
      write(outline, space);
      write(outline, element_5_imag);
      write(outline, space);
      write(outline, element_6_real);
      write(outline, space);
      write(outline, element_6_imag);
      write(outline, space);
      write(outline, element_7_real);
      write(outline, space);
      write(outline, element_7_imag);
      write(outline, space);
      write(outline, element_8_real);
      write(outline, space);
      write(outline, element_8_imag);
            
      --write(outline, output1);--, right, bit_width_extern);
      --write(outline, char);
      --write(outline, output2);
      writeline(outfile, outline);
    end loop;

      file_close(outfile);     

  end process;
end bhv;
