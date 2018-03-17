--%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
-- Title      : inreal_justREAD.vhd
--%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
-- File       : inreal_justREAD.vhd
-- Author     : Thorben Schuethe
-- Company    : HAW
-- Created    : 2017-09-18 
--%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
-- Description: This VHDL code shows an example for how to read data 
--				from a *.txt file. In this code "real" data can be read 
--				line by line from a text file.  
--%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
library ieee;
library STD; 	-- for reading text file 
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use STD.TEXTIO.ALL; 
use ieee.std_logic_textio.all;
--======================================================================
-- 							ENTITY (empty for testbench)
--======================================================================
entity read_file is
end entity read_file;

architecture bhv of read_file is
--======================================================================
-- 			DEFINE SIGNALS
--======================================================================
	-- input
	signal 	CLK  		: bit := '0';
	
	-- output
	signal dat_c1		: std_logic_vector(11 downto 0) := (others => '0');
	signal dat_c2		: std_logic_vector(11 downto 0) := (others => '0');
	signal endoffile 	: bit := '0';  
begin

	CLK	<= not CLK	after 20 ns;       
--______________________________________________________________________
--
--	Start the read prozess of the file "RealDat.txt" 
--	For this process you need the follwoing library: 
-- 	>> library STD 			
--  >> use STD.TEXTIO.ALL 
--______________________________________________________________________
	process
		variable 	fstatus 	: file_open_status; 	--	status r,w
		variable  	col1  		: std_logic_vector(11 downto 0);
		variable  	col2  		: std_logic_vector(11 downto 0);
		variable  	r_space  	: character;
		variable 	inline    	: line; 				--	readout line			
		file 		infile 		: text;					--	filehandle
		begin
			-- open file to read			
			file_open(fstatus,infile, "binDAT12.txt",  read_mode); 
			
			-- start loop to read data 
			while not (endfile(infile)) loop
			
			-- clock driven input of data 
				wait until CLK = '1' and CLK'event; 
					readline(infile, inline);
					read(inline, col1);
					read(inline, r_space);
					read(inline, col2);
					
					-- local process data to arch. data 
					dat_c1 <= col1; 
					dat_c2 <= col2; 
			end loop;
			endoffile <='1'; 
			wait; 
			file_close(infile);     
  end process;
end bhv;


