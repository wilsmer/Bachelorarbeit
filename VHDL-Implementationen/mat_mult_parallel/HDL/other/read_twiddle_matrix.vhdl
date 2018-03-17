library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

library STD; 	-- for reading text file 
use STD.TEXTIO.ALL; 
use ieee.std_logic_textio.all;

library work;
use work.all;
use datatypes.all;
use constants.all;


entity read_twiddle_matrix is

  port(
        clk         : in  bit;
        loaded      : out bit;
        input_real  : out t_2d_array;
        input_imag  : out t_2d_array
      );  
end entity read_twiddle_matrix;


architecture bhv of read_twiddle_matrix is
  
begin
  reading :  process
    variable 	fstatus         : file_open_status; 	--	status r,w
    variable  	element_1_real  : std_logic_vector(bit_width_extern-1 downto 0);
    variable  	element_1_imag  : std_logic_vector(bit_width_extern-1 downto 0);
    variable  	element_2_real  : std_logic_vector(bit_width_extern-1 downto 0);
    variable  	element_2_imag  : std_logic_vector(bit_width_extern-1 downto 0);
    variable  	element_3_real	: std_logic_vector(bit_width_extern-1 downto 0);
    variable  	element_3_imag  : std_logic_vector(bit_width_extern-1 downto 0);
    variable  	element_4_real	: std_logic_vector(bit_width_extern-1 downto 0);
    variable  	element_4_imag	: std_logic_vector(bit_width_extern-1 downto 0);
    variable  	element_5_real	: std_logic_vector(bit_width_extern-1 downto 0);
    variable  	element_5_imag	: std_logic_vector(bit_width_extern-1 downto 0);
    variable  	element_6_real	: std_logic_vector(bit_width_extern-1 downto 0);
    variable  	element_6_imag	: std_logic_vector(bit_width_extern-1 downto 0);
    variable  	element_7_real	: std_logic_vector(bit_width_extern-1 downto 0);
    variable  	element_7_imag	: std_logic_vector(bit_width_extern-1 downto 0);
    variable  	element_8_real	: std_logic_vector(bit_width_extern-1 downto 0);
    variable  	element_8_imag	: std_logic_vector(bit_width_extern-1 downto 0);
    variable  	r_space  	: character;
    variable 	inline    	: line; 				--	readout line			
    file	infile 		: text;					--	filehandle

    begin

      file_open(fstatus,infile, "TwiddleMatrix_komplex.txt",  read_mode); 

      for i in 0 to mat_size-1 loop
			
        wait until clk = '1' and clk'event; 
          readline(infile, inline);
          read(inline, element_1_real);
          read(inline, r_space);
          read(inline, element_1_imag);
          read(inline, r_space);
          read(inline, element_2_real);
          read(inline, r_space);
          read(inline, element_2_imag);
          read(inline, r_space);
          read(inline, element_3_real);
          read(inline, r_space);
          read(inline, element_3_imag);
          read(inline, r_space);
          read(inline, element_4_real);
          read(inline, r_space);
          read(inline, element_4_imag);
          read(inline, r_space);
          read(inline, element_5_real);
          read(inline, r_space);
          read(inline, element_5_imag);
          read(inline, r_space);
          read(inline, element_6_real);
          read(inline, r_space);
          read(inline, element_6_imag);
          read(inline, r_space);
          read(inline, element_7_real);
          read(inline, r_space);
          read(inline, element_7_imag);
          read(inline, r_space);
          read(inline, element_8_real);
          read(inline, r_space);
          read(inline, element_8_imag);
          

		
          input_real(i)(0) <= unsigned(element_1_real); 
          input_imag(i)(0) <= unsigned(element_1_imag);
          input_real(i)(1) <= unsigned(element_2_real);
          input_imag(i)(1) <= unsigned(element_2_imag);
          input_real(i)(2) <= unsigned(element_3_real); 
          input_imag(i)(2) <= unsigned(element_3_imag);
          input_real(i)(3) <= unsigned(element_4_real); 
          input_imag(i)(3) <= unsigned(element_4_imag);
          input_real(i)(4) <= unsigned(element_5_real); 
          input_imag(i)(4) <= unsigned(element_5_imag);
          input_real(i)(5) <= unsigned(element_6_real); 
          input_imag(i)(5) <= unsigned(element_6_imag);
          input_real(i)(6) <= unsigned(element_7_real); 
          input_imag(i)(6) <= unsigned(element_7_imag);
          input_real(i)(7) <= unsigned(element_8_real); 
          input_imag(i)(7) <= unsigned(element_8_imag);
          
          if i = 7 then
            loaded <= '1' after 20 ns;
          end if;
      end loop;
      wait; 
      file_close(infile);     
      
  end process;
end bhv;


