###############################################################
## Title      : Encounter(R) RTL Compiler - Script
## Project    : ESZ-ABS
###############################################################
## File       : vhdlRTL.tcl
## Author     : Daniel Sabotta
## Company    : HAW Hamburg
## Created    : 2012-05-23
## Last update: 2012-05-23
###############################################################
## Description: Load this file into Encounter(R) RTL Compiler 
##					- Script to synthesize a vhdl file
##
##				Usage: "rc -f vhdlRTL.tcl"
##
##				Original file from Erik Brunvand, 2008
###############################################################
## Revisions  :
## Date        Version  Author  Description
###############################################################

## Set the search paths to the libraries and HDL
## Remember that "." yout current directory

## Search Path for VHDL and Verilog files
set_attribute hdl_search_path 	{../HDL};
## Search Path for library files
set_attribute lib_search_path 	{/home/cdsmgr/ams/liberty/c35_3.3V};
## Target library
set_attribute library  			[list c35_CORELIB_TYP.lib];	
## See a lot of warnings
set_attribute information_level	6;


set hdlFiles		[list Multiplikation.vhdl];# All HDL files
#set hdlFiles		[list Multiplikation_Top.vhdl  Multiplikation.vhdl];# All HDL files
set basename		multiplizierer	;# name of toplevel module
#set basename		Multiplizierer_Top	;# name of toplevel module
set savePath		{./}	;# Save created Files here
set runName 		syn		;# name appended to output files

set clkName		clk		;# clock name
set clkPeriod_ps	62500	;# clock periode in ps
set clkInDelay_ps	250		;# delay from clock to input valid
set clkOutDelay_ps	250		;# delay from clock to output valid


set savePath		{../VERILOG/}
###############################################################
##		below here shouldn't need to be changed...   			##
###############################################################

## Analyze and Elaborate the HDL files
read_hdl	-vhdl 	${hdlFiles}
elaborate	${basename}

## Apply Constraints and generate clocks
#set clock [define_clock -period ${clkPeriod_ps} -name ${clkName} [clock_ports]]	
#external_delay -input $clkInDelay_ps -clock ${clkName} [find / -port ports_in/*]
#external_delay -output $clkOutDelay_ps -clock ${clkName} [find / -port ports_out/*]

## Sets transition to default values for Synopsys SDC format, 
## fall/rise 400ps
#dc::set_clock_transition .4 $clkName

## check that the design is OK so far
check_design -unresolved
report timing -lint

## Synthesize the design to the target library
synthesize -to_mapped

## Write out the reports
#report timing > ${savePath}${basename}_${runName}_timing.rep
report gates  > ${savePath}${basename}_${runName}_cell.rep
#report power  > ${savePath}${basename}_${runName}_power.rep

## Write out the structural Verilog and sdc files
write_hdl -mapped >  ${savePath}${basename}_${runName}.v
#write_sdc >  ${savePath}${basename}_${runName}.sdc

## write sdf-timing file with
##	-prec 3				: Use 3 digits floating point 
##							in delay calculation
##	-edges check_edge	: Check which edge delays are defined in 
##							technology file and calculate only 
##							those edges.
#write_sdf -prec 3 -edges check_edge > ${savePath}${basename}_${runName}.sdf

## log actual time in logfile
date

## exit rc (usefull, for "rc -f <thisFileName>")
#quit

